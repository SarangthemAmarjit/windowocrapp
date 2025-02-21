import 'dart:ffi';
import 'dart:typed_data';
import 'package:ffi/ffi.dart';
import 'package:image/image.dart' as img;
import 'package:win32/win32.dart';

class Sizes {
  final int width;
  final int height;
  Sizes(this.width, this.height);
}
const int DM_PAPERLENGTH = 0x00000100;
const int DM_PAPERWIDTH = 0x00000080;
const int DM_UPDATE = 0x00000001;     // Updates printer defaults
const int DM_COPY = 0x00000002;       // Copies the current DEVMODE settings
const int DM_OUT_BUFFER = 0x00000002; // Retrieves the current DEVMODE
const int DM_IN_BUFFER = 0x00000008;  // Loads input values into DEVMODE
const int DM_IN_PROMPT = 0x00000004;  // Prompts the user for changes
const int DM_MODIFY = 0x00000008;     // Modifies the printer settings

Future<void> printImageDirectly(String printerName, Uint8List imageBytes, Sizes size) async {
  final hPrinter = calloc<HANDLE>();
  final printerDefaults = calloc<PRINTER_DEFAULTS>()
    ..ref.pDatatype = nullptr
    ..ref.pDevMode = nullptr
    ..ref.DesiredAccess = GENERIC_ACCESS_RIGHTS.GENERIC_READ | GENERIC_ACCESS_RIGHTS.GENERIC_WRITE;

  try {
    if (OpenPrinter(printerName.toNativeUtf16(), hPrinter, printerDefaults) == 0) {
      print('Failed to open printer');
      return;
    }

    final hPrinterRef = hPrinter.value;
    
    // // Get printer settings
    // final pDevMode = calloc<DEVMODE>();
    // if (DocumentProperties(0, hPrinterRef, printerName.toNativeUtf16(), pDevMode, nullptr, DM_OUT_BUFFER) != IDOK) {
    //   print('Failed to get printer properties');
    //   return;
    // }

    // // Set custom paper size (in tenths of a millimeter)
    // pDevMode.ref.dmFields |= (DM_PAPERLENGTH | DM_PAPERWIDTH);
    // pDevMode.ref.dmPaperWidth = size.width * 10;
    // pDevMode.ref.dmPaperLength = size.height * 10;
    
    // if (DocumentProperties(0, hPrinterRef, printerName.toNativeUtf16(), pDevMode, pDevMode, (DM_IN_BUFFER | DM_OUT_BUFFER)) != IDOK) {
    //   print('Failed to set custom paper size');
    //   return;
    // }

    final docInfo = calloc<DOC_INFO_1>()
      ..ref.pDocName = 'Flutter PNG Print'.toNativeUtf16()
      ..ref.pOutputFile = nullptr
      ..ref.pDatatype = 'RAW'.toNativeUtf16();

    if (StartDocPrinter(hPrinterRef, 1, docInfo.cast()) == 0) {
      print('Failed to start document print');
      return;
    }

    if (StartPagePrinter(hPrinterRef) == 0) {
      print('Failed to start page print');
      return;
    }

    final img.Image? image = img.decodeImage(imageBytes);
    if (image == null) {
      print("Failed to decode image.");
      return;
    }

    // Convert image to BMP format (DIB)
    final Uint8List bmpData = img.encodeBmp(image);
    final written = calloc<DWORD>();

    final Pointer<Uint8> bmpPointer = malloc.allocate<Uint8>(bmpData.length);
    bmpPointer.asTypedList(bmpData.length).setAll(0, bmpData);

    WritePrinter(hPrinterRef, bmpPointer.cast<Void>(), bmpData.length, written);
    print("Sent image to printer");

    malloc.free(bmpPointer);
    malloc.free(written);

    EndPagePrinter(hPrinterRef);
    EndDocPrinter(hPrinterRef);
    ClosePrinter(hPrinterRef);
  } catch (e) {
    print("Error while printing: $e");
  } finally {
    calloc.free(hPrinter);
    calloc.free(printerDefaults);
  }
}

// Example usage:
// await printImageDirectly("Your Printer Name", imageBytes, Size(80, 180));
