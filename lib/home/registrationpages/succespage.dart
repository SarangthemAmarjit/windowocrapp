import 'package:camera_windows_example/controller/imagecapture.dart';
import 'package:camera_windows_example/controller/managementcontroller.dart';
import 'package:camera_windows_example/controller/pagecontroller.dart';
import 'package:camera_windows_example/home/registrationpages/paymentdetails.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Successpages extends StatelessWidget {
  const Successpages({super.key});

  @override
  Widget build(BuildContext context) {
    return  GetBuilder<Managementcontroller>(
      builder: (mngctrl) {
        return GetBuilder<Imagecontroller>(
          builder: (imgcon) {
            return GetBuilder<PagenavControllers>(
              builder: (pagectrl) {
                return Center(
                  child: Container(
                    child: Column(children: [
                      SizedBox(
                        height: 100,
                        width: 100,
                        child: Image.asset("assets/images/kanglashaok.png"),
                      ),
                      SizedBox(height: 20,),
                      imgcon.receipt!=null ? Text("Your Receipt Has been Generated. Please collect your receipt",style: TextStyle(fontSize: 30),):Text("Faile to generate permit.Please try again",style: TextStyle(fontSize: 30)),
                      SizedBox(height: 20,),
                      ButtonCard(title: "Go Home", onpress: (){
                          pagectrl.changeDashboardPage(0);
                          pagectrl.reset();
                          imgcon.disposeAll();
                          mngctrl.disposeAll();
                      })
                    ],
                    ),
                  ),
                );
              }
            );
          }
        );
      }
    );
  }
}