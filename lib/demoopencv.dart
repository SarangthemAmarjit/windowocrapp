// import 'package:flutter/material.dart';
// import 'package:windows_camera/windows_camera.dart';
// import 'package:opencv/opencv.dart';
// import 'package:opencv/core/core.dart';
// import 'package:opencv/imgproc/imgproc.dart';

// class DocumentIDScannerPage extends StatefulWidget {
//   @override
//   _DocumentIDScannerPageState createState() => _DocumentIDScannerPageState();
// }

// class _DocumentIDScannerPageState extends State<DocumentIDScannerPage> {
//   final _cameraController = ();
//   String detectedID = "No ID detected";

//   @override
//   void initState() {
//     super.initState();
//     _initializeCamera();
//   }

//   Future<void> _initializeCamera() async {
//     await _cameraController.initialize();
//     setState(() {});
//   }

//   Future<void> _processFrame() async {
//     if (_cameraController.isInitialized) {
//       final frame = await _cameraController.captureFrame();

//       // Convert frame to grayscale for processing
//       final grayImage = await ImgProc.cvtColor(
//         frame, 
//         ImgProc.colorBGR2GRAY,
//       );

//       // Apply thresholding to isolate the document ID
//       final thresholdImage = await .threshold(
//         grayImage, 
//         120, 
//         255, 
//         ImgProc.threshBinary,
//       );

//       // Extract the document ID (simulate OCR functionality)
//       // This is where OCR or similar processing would come in
//       final extractedID = _simulateOCR(thresholdImage);

//       setState(() {
//         detectedID = extractedID ?? "Unable to detect ID";
//       });
//     }
//   }

//   String? _simulateOCR(List<int> imageBytes) {
//     // Placeholder for actual OCR logic
//     // Replace with an OCR library for real text extraction
//     return "123456789"; // Simulated ID
//   }

//   @override
//   void dispose() {
//     _cameraController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Document ID Scanner"),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: _cameraController.isInitialized
//                 ? WindowsCameraPreview(_cameraController)
//                 : Center(child: CircularProgressIndicator()),
//           ),
//           SizedBox(height: 20),
//           Text(
//             "Detected ID: $detectedID",
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//           SizedBox(height: 20),
//           ElevatedButton(
//             onPressed: _processFrame,
//             child: Text("Detect Document ID"),
//           ),
//         ],
//       ),
//     );
//   }
// }
