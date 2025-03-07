import 'package:camera_windows_example/controller/imagecapture.dart';
import 'package:camera_windows_example/controller/managementcontroller.dart';
import 'package:camera_windows_example/controller/pagecontroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
class ErrorPages extends StatelessWidget {
  const ErrorPages({super.key});

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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
              
                      SizedBox(height: 50,),
                      
                      Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16)
                        ),
                        child: Image.asset('assets/images/nointernet.jpg',height: 200,width: 200,fit: BoxFit.contain,)).animate().fadeIn().slideY(begin: -0.5,end: 0,duration: Duration(milliseconds: 800)),
                      SizedBox(height: 20,),
                   Text("Service is temporarily down. We will get back soon.",style: TextStyle(fontSize: 50),textAlign: TextAlign.center,).animate().fadeIn().slideY(begin: 1,end:0,delay: Duration(milliseconds: 400)),
                      SizedBox(height: 20,),
           
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