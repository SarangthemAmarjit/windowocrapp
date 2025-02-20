// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
//import 'dart:io';
import 'dart:async';
import 'dart:io';
import 'package:camera_platform_interface/camera_platform_interface.dart';
import 'package:camera_windows_example/controller/imagecapture.dart';
import 'package:camera_windows_example/home/dashboard.dart';
import 'package:camera_windows_example/home/landingpage.dart';
import 'package:camera_windows_example/homepage.dart';
import 'package:camera_windows_example/webviewdemo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'controller/managementcontroller.dart';
import 'controller/pagecontroller.dart';
import 'home/dashboard.dart';

void main() {
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
