import 'dart:async';
import 'dart:io';

import 'package:camera_windows_example/controller/connectivitycontroller.dart';
import 'package:camera_windows_example/controller/imagecapture.dart';
import 'package:camera_windows_example/home/landingpage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:window_manager/window_manager.dart';

import 'controller/managementcontroller.dart';
import 'controller/pagecontroller.dart';
import 'controller/paymentcontroller.dart';

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
  Get.put(GetxTapController());
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
            backgroundColor: Colors.grey[300], // clean background
            surfaceTintColor: Colors.transparent,
            elevation: 4,
            shadowColor: Colors.black.withOpacity(0.05),

            // Flat rectangle corners
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),

            // Selected day (blue background, white text)
            dayBackgroundColor: WidgetStateColor.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return Colors.blue;
              }
              return Colors.transparent;
            }),
            dayForegroundColor: WidgetStateColor.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return Colors.white;
              }
              return Colors.grey[900]!;
            }),

            // Today’s date with subtle border
            todayBackgroundColor:
                WidgetStateColor.resolveWith((c) => Colors.transparent),
            todayBorder: BorderSide(color: Colors.blue, width: 1.2),

            // Range selection
            rangeSelectionBackgroundColor: WidgetStateColor.resolveWith(
                (c) => Colors.blue.withOpacity(0.15)),
            rangeSelectionOverlayColor: WidgetStateColor.resolveWith(
                (c) => Colors.blue.withOpacity(0.2)),

            // Buttons
            cancelButtonStyle: ButtonStyle(
              foregroundColor:
                  WidgetStateColor.resolveWith((e) => Colors.grey[700]!),
            ),
            confirmButtonStyle: ButtonStyle(
              foregroundColor:
                  WidgetStateColor.resolveWith((e) => Colors.white),
              backgroundColor: WidgetStateColor.resolveWith((e) => Colors.blue),
            ),
          ),
          textTheme: GoogleFonts.interTextTheme(),
          colorScheme: ColorScheme(
              brightness: Brightness.light,
              primary: Colors.white,
              onPrimary: Colors.black,
              secondary: Colors.blue,
              onSecondary: Colors.blue.withValues(alpha: 0.5),
              error: Colors.redAccent,
              onError: Colors.white,
              surface: Colors.white,
              onSurface: const Color.fromARGB(255, 26, 25, 25))),
      // home: Paymentdemo(),
      home: LandingPage(),
      // home: CardShuffleDemo()
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
