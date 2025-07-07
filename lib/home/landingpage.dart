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
    return GestureDetector(
      onTap: () {
        FocusScope.of(context)
            .unfocus(); // Hide keyboard when the screen starts
      },
      child: GetBuilder<Managementcontroller>(builder: (mngctrl) {
        final height = MediaQuery.sizeOf(context).height;
        print('height s:  $height');
        return GetBuilder<Connectivitycontroller>(builder: (connectcontrol) {
          return GetBuilder<PagenavControllers>(builder: (pagenav) {
            return Scaffold(
                resizeToAvoidBottomInset: true,
                backgroundColor: const Color.fromARGB(255, 162, 207, 240),
                body: SingleChildScrollView(
                  child: Container(
                    height: height < 1000
                        ? null
                        : MediaQuery.sizeOf(context).height,
                    width: double.infinity,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            alignment: Alignment.bottomCenter,
                            image: AssetImage(
                              'assets/images/Untitled21.png',
                            ))),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 30),
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
                            //  ||
                            //         (mngctrl.getDocNames.isEmpty && mngctrl.isloading == false)
                            ? ErrorPages()
                            : Expanded(
                                flex: height < 1000 ? 0 : 1,
                                child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: ConstrainedBox(
                                      constraints:
                                          BoxConstraints(maxWidth: 1000),
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
                                                      ? Center(
                                                          child:
                                                              RegistrationPage())
                                                      : Successpages(),
                                    )),
                              )),
                      ],
                    ),
                  ),
                ));
          });
        });
      }),
    );
  }
}
