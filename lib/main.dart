import 'dart:async';

import 'package:camera_windows_example/controller/connectivitycontroller.dart';
import 'package:camera_windows_example/controller/imagecapture.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:window_manager/window_manager.dart';

import 'cons/themes/theme.dart';
import 'controller/managementcontroller.dart';
import 'controller/pagecontroller.dart';
import 'controller/paymentcontroller.dart';
import 'routes/approute.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  windowManager.waitUntilReadyToShow().then((_) async {
    await windowManager.setFullScreen(true);
  });
  // HttpOverrides.global = MyHttpOverrides();
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
    return MaterialApp.router(
      scrollBehavior: NoScrollbarBehavior(),
      debugShowCheckedModeBanner: false,
      theme: themedata,
      routerConfig: AcnooAppRoutes.routerConfig,
    );
  }
}

// class MyHttpOverrides extends HttpOverrides {
//   @override
//   HttpClient createHttpClient(SecurityContext? context) {
//     // Customizing the HttpClient as needed
//     return super.createHttpClient(context)
//       ..badCertificateCallback = (X509Certificate cert, String host, int port) {
//         // Allow self-signed or invalid certificates (for development purposes only)
//         return true;
//       };
//   }
// }

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
