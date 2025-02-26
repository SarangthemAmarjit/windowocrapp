import 'package:camera_windows_example/controller/connectivitycontroller.dart';
import 'package:camera_windows_example/controller/pagecontroller.dart';
import 'package:camera_windows_example/home/idselectionpage.dart';
import 'package:camera_windows_example/home/registration.dart';
import 'package:camera_windows_example/home/registrationpages/succespage.dart';
import 'package:camera_windows_example/home/welcomepage.dart';
import 'package:camera_windows_example/widgets/errorwidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PagenavControllers pagenav = Get.find<PagenavControllers>();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color.fromARGB(255, 162, 207, 240),
      body: GetBuilder<Connectivitycontroller>(builder: (connectcontrol) {
        return GetBuilder<PagenavControllers>(builder: (_) {
          return SingleChildScrollView(
            child: Container(
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
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
                  Obx(() => connectcontrol.isConnectivity.value
                      ? ErrorPages()
                      : Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  alignment: Alignment.bottomCenter,
                                  image: AssetImage(
                                    'assets/images/Untitled21.png',
                                  ))),
                          width: MediaQuery.of(context).size.width,
                          child: pagenav.mainpageindex == 0
                              ? WelcomeScreen()
                              : pagenav.mainpageindex == 1
                                  ? DocumentScanPage()
                                  : pagenav.mainpageindex == 2
                                      ? Center(child: RegistrationPage())
                                      : Successpages())),
                ],
              ),
            ),
          );
        });
      }),
    );
  }
}
