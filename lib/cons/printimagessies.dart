import 'dart:ffi';
import 'package:ffi/ffi.dart';

/// Load `DeviceCapabilitiesW` from `winspool.drv`
final _deviceCapabilities = DynamicLibrary.open("winspool.drv").lookupFunction<
    Int32 Function(Pointer<Utf16>, Pointer<Utf16>, Uint16, Pointer<Void>, Pointer<Void>),
    int Function(Pointer<Utf16>, Pointer<Utf16>, int, Pointer<Void>, Pointer<Void>)>("DeviceCapabilitiesW");

/// Constants for DeviceCapabilities function
const int DC_PAPERS = 2;
const int DC_PAPERNAMES = 16;

/// Function to get printer-supported paper sizes
void getPrinterPaperSizes(String printerName) {
  final printerNamePtr = printerName.toNativeUtf16();

  // Get the number of supported paper sizes
  final numPapers = _deviceCapabilities(printerNamePtr, nullptr, DC_PAPERS, nullptr, nullptr);
  if (numPapers <= 0) {
    print("No paper sizes found or an error occurred.");
    calloc.free(printerNamePtr);
    return;
  }

  // Allocate memory for paper sizes
  final paperSizes = calloc<Uint16>(numPapers);

  // Allocate memory for paper names (32 bytes per name as per documentation)
  final int paperNameSize = 64; // Each paper name is 64 bytes max
  final paperNames = calloc<Uint16>(numPapers * paperNameSize);

  // Retrieve supported paper sizes and names
  _deviceCapabilities(printerNamePtr, nullptr, DC_PAPERS, paperSizes.cast(), nullptr);
  _deviceCapabilities(printerNamePtr, nullptr, DC_PAPERNAMES, paperNames.cast(), nullptr);

  print("✅ Supported Paper Sizes:");
  for (var i = 0; i < numPapers; i++) {
    final paperSize = paperSizes[i]; // Paper size constant
    final paperNamePtr = paperNames.elementAt(i * paperNameSize).cast<Utf16>();
    final paperName = paperNamePtr.toDartString(); // Convert Utf16 to Dart string

    print("📄 Paper ID: $paperSize | Name: $paperName");
  }

  // Clean up memory
  calloc.free(paperSizes);
  calloc.free(paperNames);
  calloc.free(printerNamePtr);
}

// void main() {
//   getPrinterPaperSizes("Microsoft Print to PDF"); // Replace with actual printer name
// }
