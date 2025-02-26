import 'dart:ffi';
import 'dart:typed_data';
import 'package:ffi/ffi.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:win32/win32.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
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
    final Uint8List bmpData = Uint8List.fromList( img.encodeBmp(image));
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

// Future<List<int>> testTicket() async {

//   // Using default profile
//   final profile = await CapabilityProfile.load();
//   final generator = Generator(PaperSize.mm80, profile);
//   List<int> bytes = [];

//   bytes += generator.text(
//       'Regular: aA bB cC dD eE fF gG hH iI jJ kK lL mM nN oO pP qQ rR sS tT uU vV wW xX yY zZ');
//   bytes += generator.text('Special 1: àÀ èÈ éÉ ûÛ üÜ çÇ ôÔ',
//       styles: PosStyles(codeTable: PosCodeTable.westEur));
//   bytes += generator.text('Special 2: blåbærgrød',
//       styles: PosStyles(codeTable: PosCodeTable.westEur));

//   bytes += generator.text('Bold text', styles: PosStyles(bold: true));
//   bytes += generator.text('Reverse text', styles: PosStyles(reverse: true));
//   bytes += generator.text('Underlined text',
//       styles: PosStyles(underline: true), linesAfter: 1);
//   bytes += generator.text('Align left', styles: PosStyles(align: PosAlign.left));
//   bytes += generator.text('Align center', styles: PosStyles(align: PosAlign.center));
//   bytes += generator.text('Align right',
//       styles: PosStyles(align: PosAlign.right), linesAfter: 1);

//   bytes += generator.text('Text size 200%',
//       styles: PosStyles(
//         height: PosTextSize.size2,
//         width: PosTextSize.size2,
//       ));

//   bytes += generator.feed(2);
//   bytes += generator.cut();
//   return bytes;
// }



void printUsbReceiptWindows(Uint8List d,String applicantID) async {
  final profile = await CapabilityProfile.load();
  final generator = Generator(PaperSize.mm80, profile);
  final List<int> bytes = [];

  // Add text
  bytes.addAll(generator.text(
    'ILP MANIPUR',
    styles: const PosStyles(
      align: PosAlign.center,
      height: PosTextSize.size2,
      width: PosTextSize.size2,
    ),
  ));
  bytes.addAll(generator.text('Date: ${DateTime.now()}',
      styles: const PosStyles(align: PosAlign.center)));
        bytes.addAll(generator.feed(2));

 bytes.addAll(generator.text('Applicant ID',
      styles: const PosStyles(align: PosAlign.center)));
  bytes.addAll(generator.feed(1));
  bytes.addAll(generator.text('$applicantID',
      styles: const PosStyles(align: PosAlign.center,
       height: PosTextSize.size3,
      width: PosTextSize.size3,
      )));
  bytes.addAll(generator.feed(2));
  
  bytes.addAll(generator.image(img.decodeImage(d)!,align: PosAlign.center),);
 
  bytes.addAll(generator.feed(2));
 bytes.addAll(generator.text('',
      styles: const PosStyles(align: PosAlign.center)));
       bytes.addAll(generator.text('Please go at the counter',
      styles: const PosStyles(align: PosAlign.center)));
         bytes.addAll(generator.text('to complete the process',
      styles: const PosStyles(align: PosAlign.center)));
    bytes.addAll(generator.feed(1));
  bytes.addAll(generator.text(' ---------------------------------------------------------------'));

  bytes.addAll(generator.text('Enjoy your stay!',
      styles: const PosStyles(align: PosAlign.center)));

  bytes.addAll(generator.cut());

  // Send raw bytes to USB printer
  printToWindowsPrinter("CUSTOM K80", Uint8List.fromList(bytes),Sizes(80,180));
  // printImageDirectly("CUSTOM K80", imageBytes, Sizes(80, 80));
}


void printUsbReceiptWindowsonline(String applicantID,String permitno) async {
  final profile = await CapabilityProfile.load();
  final generator = Generator(PaperSize.mm80, profile);
  final List<int> bytes = [];

  // Add text
  bytes.addAll(generator.text(
    'ILP MANIPUR',
    styles: const PosStyles(
      align: PosAlign.center,
      height: PosTextSize.size2,
      width: PosTextSize.size2,
    ),
  ));
  bytes.addAll(generator.text('Date: ${DateTime.now()}',
      styles: const PosStyles(align: PosAlign.center)));
        bytes.addAll(generator.feed(2));

 bytes.addAll(generator.text('Applicant ID',
      styles: const PosStyles(align: PosAlign.center)));
  bytes.addAll(generator.feed(1));
  bytes.addAll(generator.text('$applicantID',
      styles: const PosStyles(align: PosAlign.center,
       height: PosTextSize.size3,
      width: PosTextSize.size3,
      )));
  bytes.addAll(generator.feed(1));
  
  // bytes.addAll(generator.image(img.decodeImage(d)!,align: PosAlign.center),);
  bytes.addAll(generator.text('Permit No:',
      styles: const PosStyles(align: PosAlign.center)));
  bytes.addAll(generator.feed(1));
  bytes.addAll(generator.text('$permitno',
      styles: const PosStyles(align: PosAlign.center,
       height: PosTextSize.size3,
      width: PosTextSize.size3,
      )));
  bytes.addAll(generator.feed(2));
 
 bytes.addAll(generator.text('',
      styles: const PosStyles(align: PosAlign.center)));
       bytes.addAll(generator.text('A message will be sent to your number with the link.',
      styles: const PosStyles(align: PosAlign.center)));
         bytes.addAll(generator.text('Download the receipt.',
      styles: const PosStyles(align: PosAlign.center)));
    bytes.addAll(generator.feed(1));
  bytes.addAll(generator.text(' ---------------------------------------------------------------'));

  bytes.addAll(generator.text('Enjoy your stay!',
      styles: const PosStyles(align: PosAlign.center)));

  bytes.addAll(generator.cut());

  // Send raw bytes to USB printer
  printToWindowsPrinter("CUSTOM K80", Uint8List.fromList(bytes),Sizes(80,180));
  // printImageDirectly("CUSTOM K80", imageBytes, Sizes(80, 80));
}

void printToWindowsPrinter(String printerName, Uint8List data,Sizes size) {
  final hPrinter = calloc<HANDLE>();

      print("open printer $printerName");

  final pDocInfo = calloc<DOC_INFO_1>()
    ..ref.pDocName = "Flutter Print sign".toNativeUtf16()
    ..ref.pOutputFile = nullptr
    ..ref.pDatatype = "RAW".toNativeUtf16();

  // Open printer
  if (OpenPrinter(printerName.toNativeUtf16(), hPrinter, nullptr) == 0) {
    print("Failed to open printer: $printerName");
    return;
  }

  // Start document
  if (StartDocPrinter(hPrinter.value, 1, pDocInfo) == 0) {
    print("Failed to start document.");
    ClosePrinter(hPrinter.value);
    return;
  }

  // Start page
  if (StartPagePrinter(hPrinter.value) == 0) {
    print("Failed to start page.");
    ClosePrinter(hPrinter.value);
    return;
  }

  // Write data
  final written = calloc<DWORD>();
  WritePrinter(hPrinter.value, data.allocatePointer(), data.length, written);

  // End page and document
  EndPagePrinter(hPrinter.value);
  EndDocPrinter(hPrinter.value);
  ClosePrinter(hPrinter.value);

  calloc.free(hPrinter);
  calloc.free(pDocInfo);
}
