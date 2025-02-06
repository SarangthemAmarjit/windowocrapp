import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:camera_windows_example/controller/imagecapture.dart';
import 'package:camera_windows_example/controller/managementcontroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

import '../../controller/pagecontroller.dart';
import '../../widgets/bannercard.dart';

class PhotoSignaturePage extends StatefulWidget {
  const PhotoSignaturePage({super.key});

  @override
  State<PhotoSignaturePage> createState() => _PhotoSignaturePageState();
}

class _PhotoSignaturePageState extends State<PhotoSignaturePage> {
  var _scheduler;

  Uint8List? image;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    // loadcascade();

    initialise();

  }

  void initialise() async {
    if (Get.find<Imagecontroller>().isinitialized) {
      countdownTimer();
    } else {
      await Get.find<Imagecontroller>().initializeCameraAgain(
          isfront: false, isback: false, isprofilecam: true, context: context);
      if (Get.find<Imagecontroller>().isinitialized) {
        countdownTimer();
      }
    }
  }

  @override
  void dispose() {
    Get.find<Imagecontroller>().disposeCurrentCamera();
    _scheduler.cancel();
    super.dispose();
  }

  void schedule() {
    _scheduler = Timer.periodic(Duration(seconds: 2), (timer) async {
      print("In Scheduler");
      try {
        Get.find<Imagecontroller>().takePicture();
        // await _runFaceDetection(file);
      } catch (e) {
        print(e);
      }
    });
  }

  int timer = 0;
  var _sched;
  Future<void> countdownTimer() async {
    timer = 8;
    await Future.delayed(Duration(seconds: 2));
    _sched = Timer.periodic(
      Duration(seconds: 1),
      (TabController) {
        setState(() {
          timer--;
          if (timer <= 1) {
            if (_sched != null) {
              Get.find<Imagecontroller>().takeprofilePicture();
              _sched.cancel();
            }
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Managementcontroller>(builder: (mngctrl) {
      return GetBuilder<PagenavControllers>(builder: (controller) {
        return GetBuilder<Imagecontroller>(builder: (imgcon) {
          return Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 700),
              child: Container(
                
                margin: EdgeInsets.all(16),
                decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withValues(alpha: 0.2),blurRadius: 5)
                  ]
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Text("Profile Photo",style: TextStyle(fontSize: 30,color: Colors.green),),
                          
                    imgcon.profileimage != null
                        ? BannerContainer(
                            color: Colors.blue,
                            text:
                                "Check if your face fits within the frame. Retake if necessary.",
                          ).animate().fadeIn()
                        : Container(
                            padding: EdgeInsets.all(32),
                            margin: EdgeInsets.all(16),
                            child: imgcon.initialized
                                ? Text(
                                    "Please look at the Camera and stand still.",
                                    style: TextStyle(fontSize: 26),
                                  )
                                : Text(
                                    "Initializing Camera. Please Wait",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.green),
                                  )),
                    timer <= 1
                        ? SizedBox(
                            height: 20,
                          )
                        : Text(
                            ' Capturing in $timer seconds.',
                            style: TextStyle(fontSize: 20),
                          ).animate().fadeIn(),
                    // Divider(),
                    SizedBox(
                      height: 10,
                    ),
                          
                    Stack(
                      children: [
                        Container(
                          width: 500,
                          height: 500,
                          margin: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 2,
                              color: Colors.grey[900]!,
                            ),
                            //  borderRadius: BorderRadius.circular(10),
                          ),
                          child: ClipRRect(
                              //  borderRadius: BorderRadius.circular(10),
                              child: imgcon.profileimage != null
                                  ? Transform.flip(
                                      flipX: true,
                                      child: Image.file(
                                        fit: BoxFit.contain,
                                        File(imgcon.profileimage!.path),
                                      ),
                                    )
                                  : imgcon.buildPreview()),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          left: 0,
                          bottom: 0,
                          child: AnimatedOpacity(
                              opacity: timer <= 1 ? 0 : 1,
                              duration: Duration(seconds: 1),
                              child: Center(
                                  child: Text(
                                '$timer',
                                style: TextStyle(
                                    fontSize: 200,
                                    color: Colors.green.withValues(alpha: 0.6)),
                              ).animate().fadeIn())),
                        ),
                                
                        // Draw bounding boxes on top of the image
                      ],
                    ).animate().fadeIn(duration: Duration(),delay: Duration(milliseconds: 200)) ,
                          
                    SizedBox(
                      height: 20,
                    ),
                          
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              imgcon.retakeImage();
                              countdownTimer();
                            },
                            child: Container(
                              // margin: EdgeInsets.symmetric(horizontal: 16),
                              width: double.infinity,
                              padding: EdgeInsets.all(32),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                // borderRadius: BorderRadius.circular(8)
                              ),
                              clipBehavior: Clip.antiAlias,
                              child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.camera_sharp,color: Colors.white,),
                                      SizedBox(width: 20,),
                                      Text(
                                                                      "Retake",
                                                                      style:
                                        TextStyle(color: Colors.white, fontSize: 24),
                                                                    ),
                                    ],
                                  )),
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              controller.changePage(3);
                            },
                            child: Container(
                              //  margin: EdgeInsets.symmetric(horizontal: 16),
                              width: double.infinity,
                              padding: EdgeInsets.all(32),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                //  borderRadius: BorderRadius.circular(8)
                              ),
                              clipBehavior: Clip.antiAlias,
                              child:  Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                    
                                   
                                      Text(
                                                                      "Proceed",
                                                                      style:
                                        TextStyle(color: Colors.white, fontSize: 24),
                                                                    ),
                                                                       SizedBox(width: 20,),
                                                                         Icon(Icons.check,color: Colors.white,),
                                    ],
                                  )),
                            ),
                          ),
                        ),
                      ],
                    ).animate().fadeIn(duration: Duration(milliseconds: 1200),delay: Duration(milliseconds: 400)) ,
                  ],
                ),
              ).animate().scaleXY(begin: 0.7,end: 1,curve: Curves.easeInCubic,duration: Duration(milliseconds: 600)).fadeIn(duration: Duration(milliseconds: 500)),
            ),
          );
        });
      });
    });
  }
}
