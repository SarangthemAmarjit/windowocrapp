import 'dart:async';
import 'dart:io';

import 'package:camera_windows_example/cons/utils.dart';
import 'package:camera_windows_example/controller/connectivitycontroller.dart';
import 'package:camera_windows_example/controller/imagecapture.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:window_manager/window_manager.dart';

import 'controller/managementcontroller.dart';
import 'controller/pagecontroller.dart';
import 'home/landingpage.dart';

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
  print("Parse any date :${parseAnyDate("12-08-2025 11:17:11")}");
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
  }

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
              foregroundColor: Colors.grey,
              textStyle: GoogleFonts.ralewayTextTheme().bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          datePickerTheme: DatePickerThemeData(
              backgroundColor: Colors.grey[300]!,
              rangeSelectionBackgroundColor: WidgetStateColor.resolveWith(
                  (c) => Colors.blue.withValues(alpha: 0.2)),
              dayOverlayColor: WidgetStateColor.resolveWith(
                  (c) => Colors.blue.withValues(alpha: 0.2)),
              todayBackgroundColor:
                  WidgetStateColor.resolveWith((c) => Colors.grey[300]!),
              dayStyle: TextStyle(color: Colors.grey[900]),
              rangeSelectionOverlayColor: WidgetStateColor.resolveWith(
                  (c) => Colors.blue.withValues(alpha: 0.2)),
              cancelButtonStyle: ButtonStyle(
                  foregroundColor:
                      WidgetStateColor.resolveWith((e) => Colors.blue)),
              confirmButtonStyle: ButtonStyle(
                  foregroundColor:
                      WidgetStateColor.resolveWith((e) => Colors.blue))),
          textTheme: GoogleFonts.robotoCondensedTextTheme(),
          colorScheme: ColorScheme(
              brightness: Brightness.light,
              primary: Colors.white,
              onPrimary: Colors.black,
              secondary: Colors.blue,
              onSecondary: Colors.blue.withValues(alpha: 0.5),
              error: Colors.redAccent,
              onError: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black)),
      // home: Paymentdemo(),
      home: LandingPage(),
      // home: MyWidget()
      // home:PermitGenerateWidget(

      //   applicantId: "123485986768"),
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
