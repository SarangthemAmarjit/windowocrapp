import 'package:camera_windows_example/controller/connectivitycontroller.dart';
import 'package:camera_windows_example/controller/managementcontroller.dart';
import 'package:camera_windows_example/controller/pagecontroller.dart';
import 'package:camera_windows_example/home/idselectionpage.dart';
import 'package:camera_windows_example/home/registration.dart';
import 'package:camera_windows_example/home/registrationpages/succespage.dart';
import 'package:camera_windows_example/widgets/errorwidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'deviceidpage.dart';
import 'welcomepage.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<Managementcontroller>(builder: (mngctrl) {
      return GetBuilder<Connectivitycontroller>(builder: (connectcontrol) {
        return GetBuilder<PagenavControllers>(builder: (pagenav) {
          return Scaffold(
              backgroundColor: const Color.fromARGB(255, 162, 207, 240),
              body: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  const Color.fromARGB(255, 68, 143, 197),
                  const Color.fromARGB(255, 162, 207, 240),
                  const Color.fromARGB(255, 162, 207, 240),
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Image.asset(
                            'assets/images/kanglashaok.png',
                            height: 60,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Image.asset(
                            'assets/images/ilplogo2.png',
                            height: 60,
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Obx(() => connectcontrol.isConnectivity.value
                          //  ||
                          //         (mngctrl.getDocNames.isEmpty && mngctrl.isloading == false)
                          ? ErrorPages()
                          : Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      alignment: Alignment.bottomCenter,
                                      image: AssetImage(
                                        'assets/images/Untitled21.png',
                                      ))),
                              width: MediaQuery.of(context).size.width,
                              child: ConstrainedBox(
                                constraints: BoxConstraints(maxWidth: 1000),
                                child: !mngctrl.isdeviceCheck &&
                                        mngctrl.deviceId == null &&
                                        mngctrl.gateId == null
                                    ? ConfigSaverWidget()
                                    : pagenav.mainpageindex == 0
                                        ? WelcomeScreen()
                                        : pagenav.mainpageindex == 1
                                            ? DocumentScanPage()
                                            // ?Successpages()
                                            : pagenav.mainpageindex == 2
                                                ? Center(child: RegistrationPage())
                                                : Successpages(),
                              ))),
                    ),
                  ],
                ),
              ));
        });
      });
    });
  }
}
