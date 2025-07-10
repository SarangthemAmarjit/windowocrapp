import 'dart:async';
import 'dart:io';

import 'package:camera_windows_example/controller/connectivitycontroller.dart';
import 'package:camera_windows_example/controller/imagecapture.dart';
import 'package:camera_windows_example/demopayment.dart';
import 'package:camera_windows_example/home/landingpage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:window_manager/window_manager.dart';

import 'controller/managementcontroller.dart';
import 'controller/pagecontroller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  windowManager.waitUntilReadyToShow().then((_) async {
    await windowManager.setFullScreen(true);
  });
  HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp());
  Get.put(Imagecontroller());
  Get.put(Connectivitycontroller());
  Get.put(PagenavControllers());
  Get.put(Managementcontroller());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      scrollBehavior: NoScrollbarBehavior(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              visualDensity: VisualDensity.standard,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              backgroundColor: Colors.blueAccent,
              foregroundColor: Colors.white,
              textStyle:
                  GoogleFonts.robotoCondensedTextTheme().bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
            ),
          ),
          textTheme: GoogleFonts.robotoCondensedTextTheme(),
          colorSchemeSeed: Colors.white),
      // home: Paymentdemo(),
      home: LandingPage(),
      // home: MyWidget()
      // home:PermitGenerateWidget(applicantId: "123485986768"),
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

class NoScrollbarBehavior extends ScrollBehavior {
  @override
  Widget buildScrollbar(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }

  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
