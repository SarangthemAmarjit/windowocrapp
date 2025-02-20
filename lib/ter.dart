// // ignore_for_file: unnecessary_this

// import 'dart:ui' as ui;

// import 'package:flutter/material.dart';
// import 'package:textify/textify.dart';

// /// The entry point of the application. Runs the [MainApp] widget.
// void main() async {'
//   WidgetsFlutterBinding.ensureInitialized();

//   // load your image

//   runApp(
//     MaterialApp(
//       title: 'TEXTify example',
//       home: OCRPage(extractedText: extractedText),
//     ),
//   );
// }

// class OCRPage extends StatelessWidget {
//   const OCRPage({
//     super.key,
//     required this.extractedText,
//   });

//   final String extractedText;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.white,
//       child: Text(
//         extractedText, // <<< display the text here
//         style: TextStyle(
//           color: Colors.black,
//           decoration: TextDecoration.none,
//         ),
//       ),
//     );
//   }
// }
