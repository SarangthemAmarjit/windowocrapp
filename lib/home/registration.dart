import 'package:camera_windows_example/controller/imagecapture.dart';
import 'package:camera_windows_example/homepage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/managementcontroller.dart';
import '../controller/pagecontroller.dart';
import 'registrationpages/ilpformreplica.dart';
import 'registrationpages/paymentdetails.dart';
import 'registrationpages/photodetails.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});
  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}


class _RegistrationPageState extends State<RegistrationPage> {
 
 @override
  void dispose() {

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PagenavControllers>(builder: (controller) {
      return Container(
        // padding: EdgeInsets.all(32),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  InkWell(
                    // overlayColor:
                    //     WidgetStateProperty.all(Colors.transparent),
                    focusColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    onTap: () {
                      if (controller.regPage == 0) {
                        controller.setmainpageindex(ind: 0);
                            Get.find<Imagecontroller>().disposeAll();
                            Get.find<Managementcontroller>().disposeAll();
                      } else {
                        controller.changeDashboardPage(controller.regPage - 1);
                      }
                    },

                    child: Transform.flip(
                      flipX: true,
                      child: Image.asset(
                        'assets/images/next2.png',
                        height: 60,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Registration",
                    style: TextStyle(fontSize: 30),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap:controller.incrementPage>0? () {
                      controller.changePage(1);
                    }:null,
                    child: Center(
                        child: Text(
                      "Personal Details",
                      style: TextStyle(
                          fontSize: controller.page == 1 ? 30 : 16,
                          color: controller.page >= 1 ? Colors.green : null),
                    )),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap:controller.incrementPage>1? () {
                      controller.changePage(2);
                    }:null,
                    child: Center(
                        child: Text(
                      "Profile Image",
                      style: TextStyle(
                          fontSize: controller.page == 2 ? 30 : 16,
                          // fontSize: 16,

                          color: controller.page >= 2 ? Colors.green : null),
                    )),
                  ),
                ),
                         Expanded(
                  child: InkWell(
                    onTap:controller.incrementPage>2? () {
                      controller.changePage(3);
                    }:null,
                    child: Center(
                        child: Text(
                      "Card  & Signature",
                      style: TextStyle(
                          fontSize: controller.page == 3 ? 30 : 16,
                          // fontSize: 16,

                          color: controller.page >= 3 ? Colors.green : null),
                    )),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap:controller.incrementPage>3? () {
                      controller.changePage(4);
                    }:null,
                    child: Center(
                        child: Text(
                      "Payment",
                      style: TextStyle(
                          fontSize: controller.page == 4 ? 30 : 16,
                          // fontSize: 16,

                          color: controller.page >= 4 ? Colors.green : null),
                    )),
                  ),
                ),
              ],
            ),
            LayoutBuilder(builder: (context, s) {
              double x = ((controller.page / 4) * s.maxWidth);
              return AnimatedContainer(
                duration: Duration(milliseconds: 300),
                height: 5,
                width: x,
                color: Colors.green,
              );
            }),
            SizedBox(
              height: 10,
            ),
            Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "Completed: ${controller.page}/4",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                )),
            SizedBox(
              height: 20,
            ),
            controller.page == 1
                ? TemporaryILPFormReplica()
                  // ?PaymentDetails()                

                //     : controller.page == 3
                //         ? PermitDetails()
                : controller.page == 2
                    ? PhotoSignaturePage()
                    // ?FaceDetectionPage()
                    :controller.page==3? IdSelectionAndScanningScreen():
                    PaymentDetails()
          
          ],
        ),
      );
    });
  }
}

