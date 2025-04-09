import 'dart:async';
import 'dart:io';
import 'package:camera_windows_example/controller/connectivitycontroller.dart';
import 'package:camera_windows_example/controller/imagecapture.dart';
import 'package:camera_windows_example/home/landingpage.dart';
import 'package:camera_windows_example/models/scannermodel.dart';
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
  print("${QrScannerModel(permitType: "ONLINE", permitNo: "!!((73874))", applicantName: "aRVINSD", applicantParent: "aRVINDSAPFJ", idNo: "274824872647", dateOfIssue: DateTime.now(), validUpto: DateTime.now(), placeOfStay: "fdsfs", hs: "fgdjf").toJson()}");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          textTheme: GoogleFonts.robotoCondensedTextTheme(),
          colorSchemeSeed: Colors.white),
      home: LandingPage(),
    // home: MyWidget()
      // home:PermitGenerateWidget(applicantId: "123485986768"),
    );
  }
}

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(navigatorKey: navigatorKey, home: ExampleBrowser());
//   }
// }
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
