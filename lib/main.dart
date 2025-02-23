import 'dart:async';
import 'dart:io';
import 'package:camera_windows_example/controller/imagecapture.dart';
import 'package:camera_windows_example/home/landingpage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:window_manager/window_manager.dart';
import 'cons/printimagessies.dart';
import 'controller/managementcontroller.dart';
import 'controller/pagecontroller.dart';

Future<void> main()async {

  WidgetsFlutterBinding.ensureInitialized();
  //  getPrinterPaperSizes("Microsoft Print to PDF"); 
  // Initialize window_manager
  await windowManager.ensureInitialized();

  // Set fullscreen mode
  windowManager.waitUntilReadyToShow().then((_) async {
    await windowManager.setFullScreen(true);
  });
  HttpOverrides.global = MyHttpOverrides();

  runApp(MyApp());

  Get.put(Imagecontroller());
  Get.put(PagenavControllers());
  Get.put(Managementcontroller());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          textTheme: GoogleFonts.robotoCondensedTextTheme(),
          colorSchemeSeed: Colors.green),
      home: LandingPage(),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    // Customizing the HttpClient as needed
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) {
        // Allow self-signed or invalid certificates (for development purposes only)
        return true;
      };
  }
}
