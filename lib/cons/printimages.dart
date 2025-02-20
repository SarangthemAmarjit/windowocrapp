import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';
import 'package:ffi/ffi.dart';
import 'package:image/image.dart' as img;
import 'package:win32/win32.dart';

void printImageDirectly(String printerName, String imagePath,Uint8List images) async {
  final hPrinter = calloc<HANDLE>();
  final printerDefaults = calloc<PRINTER_DEFAULTS>()
    ..ref.pDatatype = nullptr
    ..ref.pDevMode = nullptr
    ..ref.DesiredAccess = GENERIC_ACCESS_RIGHTS.GENERIC_READ | GENERIC_ACCESS_RIGHTS.GENERIC_WRITE;

  if (OpenPrinter(printerName.toNativeUtf16(), hPrinter, printerDefaults) == 0) {
    print('Failed to open printer');
    return;
  }

  final hPrinterRef = hPrinter.value;
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

  // Load the PNG image
  final imageFile = File(imagePath);
  // final Uint8List imageBytes = await imageFile.readAsBytes();
  final Uint8List imageBytes =images;
  final img.Image? image = img.decodeImage(imageBytes);
  if (image == null) {
    print("Failed to decode image.");
    return;
  }

  // Convert image to BMP format (DIB)
  final Uint8List bmpData = img.encodeBmp(image);

  final written = calloc<DWORD>();

  // Allocate native memory and copy BMP data
  final Pointer<Uint8> bmpPointer = malloc.allocate<Uint8>(bmpData.length);
  bmpPointer.asTypedList(bmpData.length).setAll(0, bmpData);

  // Send the BMP image to the printer
  WritePrinter(hPrinterRef, bmpPointer.cast<Void>(), bmpData.length, written);
 print("Send image");
  // Free allocated memory
  malloc.free(bmpPointer);
  malloc.free(written);

  EndPagePrinter(hPrinterRef);
  EndDocPrinter(hPrinterRef);
  ClosePrinter(hPrinterRef);

  calloc.free(hPrinter);
  calloc.free(docInfo);
  calloc.free(printerDefaults);
}

// void main() {
//   printImageDirectly("Microsoft Print to PDF", "C:/path/to/your/image.png");
// }
