import 'package:camera_windows_example/controller/pagecontroller.dart';
import 'package:camera_windows_example/home/dashboard.dart';
import 'package:camera_windows_example/home/registration.dart';
import 'package:camera_windows_example/home/welcomepage.dart';
import 'package:camera_windows_example/homepage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PagenavControllers pagenav = Get.put(PagenavControllers());
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 162, 207, 240),
      body: GetBuilder<PagenavControllers>(builder: (_) {
        return Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.asset(
                      'assets/images/Kanglashanew1.png',
                      height: 50,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Image.asset(
                      'assets/images/ilplogo.png',
                      height: 60,
                    )
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                  'assets/images/Untitled21.png',
                ))),
                width: MediaQuery.of(context).size.width,
                child: pagenav.mainpageindex == 0
                    ? WelcomeScreen()
                    : pagenav.mainpageindex == 1
                        ? SelectIdCardTypeScreen()
                        : pagenav.mainpageindex == 2
                            ? IdSelectionAndScanningScreen()
                            : pagenav.mainpageindex == 3
                                ? RegistrationPage()
                                : SizedBox(),
              ),
            ],
          ),
        );
      }),
    );
  }
}
