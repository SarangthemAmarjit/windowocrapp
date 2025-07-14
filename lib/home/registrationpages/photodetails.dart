import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
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
  GlobalKey _profilekey = GlobalKey();
  final player = AudioPlayer();

  int timernew = 0;
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    // loadcascade();
    timernew = 0;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      debugPrint("First timernew = $timernew");
      // Hide keyboard when the screen starts
      if (Get.find<Imagecontroller>().profileImage == null) {
        debugPrint("In Initialise data : Image if null profile");
        initialise();
      }
    });
  }

  void playtimernewSound(String audio) {
    try {
      player.play(AssetSource(audio)); // Plays the sound once
    } catch (e) {
      debugPrint("Audio Error");
    }
  }

  void initialise() async {
    await Get.find<Imagecontroller>().retakeImage();
    // await Get.find<Imagecontroller>().initializeCameraAgain(
    //     isfront: false, isback: false, isprofilecam: true);
    if (Get.find<Imagecontroller>().isinitialized) {
      countdowntimernew();
    }
    // if (Get.find<Imagecontroller>().isinitialized) {
    //   countdowntimernew();
    // } else {

    // }
  }

  @override
  void dispose() {
    if (_sched != null) {
      _sched.cancel();
    }
    Get.find<Imagecontroller>().disposeCurrentsCamera();
    player.dispose();
    super.dispose();
  }

  var _sched;
  Future<void> countdowntimernew() async {
    debugPrint("In Initialise data : Image if null countdown");

    timernew = 5;

    await Future.delayed(Duration(seconds: 1));

    _sched = Timer.periodic(
      Duration(seconds: 1),
      (t) {
        setState(() {
          timernew--;
          debugPrint("timernew update");
        });

        if (timernew <= 1) {
          if (_sched != null) {
            playtimernewSound('camera.mp3');
            Get.find<Imagecontroller>().takeprofilePicture(_profilekey);

            t.cancel();
          }
        } else {
          debugPrint("In timernew camera: $timernew");
          playtimernewSound('dng.mp3');
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("timernew in Build: $timernew");
    return GetBuilder<Managementcontroller>(builder: (mngctrl) {
      return GetBuilder<PagenavControllers>(builder: (controller) {
        return GetBuilder<Imagecontroller>(builder: (imgcon) {
          return Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 700),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    clipBehavior: Clip.antiAlias,
                    margin: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withValues(alpha: 0.2),
                              blurRadius: 5)
                        ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Text("Profile Photo",style: TextStyle(fontSize: 30,color: Colors.green),),

                        imgcon.profileImage != null
                            ? BannerContainer(
                                color: Colors.blue,
                                text:
                                    "Check if your face fits within the frame. Retake if necessary.",
                              ).animate().fadeIn()
                            : Container(
                                padding: EdgeInsets.all(32),
                                margin: EdgeInsets.all(16),
                                child: imgcon.isinitialized
                                    ? Text(
                                        "Please look at the Camera and stand still.",
                                        style: TextStyle(fontSize: 26),
                                      )
                                    : Text(
                                        "Initializing Camera. Please Wait",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.green),
                                      )),
                        timernew <= 1
                            ? SizedBox(
                                height: 20,
                              )
                            : Text(
                                ' Capturing in $timernew seconds.',
                                style: TextStyle(fontSize: 20),
                              ).animate().fadeIn(),
                        // Divider(),
                        SizedBox(
                          height: 10,
                        ),

                        Stack(
                          children: [
                            RepaintBoundary(
                              key: _profilekey,
                              child: Container(
                                width: 500,
                                height: 500,
                                margin: EdgeInsets.all(16),
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  border: Border.all(
                                    width: 2,
                                    color: Colors.grey[400]!,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ClipRRect(
                                    //  borderRadius: BorderRadius.circular(10),
                                    child: imgcon.profileImage != null
                                        ? Image.memory(
                                            fit: BoxFit.cover,
                                            imgcon.profileImage!,
                                          )
                                        : imgcon.isinitialized
                                            ? imgcon.buildPreview()
                                            : Center(
                                                child: Icon(
                                                  Icons.camera,
                                                  color: Colors.grey,
                                                  size: 60,
                                                ).animate(
                                                  onComplete: (controller) {
                                                    controller.repeat();
                                                  },
                                                ).rotate(
                                                  duration:
                                                      Duration(seconds: 2),
                                                ),
                                              )),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              left: 0,
                              bottom: 0,
                              child: AnimatedOpacity(
                                  opacity: timernew <= 1 ? 0 : 1,
                                  duration: Duration(seconds: 1),
                                  child: Center(
                                      child: Text(
                                    '$timernew',
                                    style: TextStyle(
                                        fontSize: 200,
                                        color: Colors.green
                                            .withValues(alpha: 0.6)),
                                  ).animate().fadeIn())),
                              // child: Center(
                              //     child: Text(
                              //   '$timernew',
                              //   style: TextStyle(
                              //       fontSize: 200,
                              //       color: Colors.green.withValues(alpha: 0.6)),
                              // ).animate().fadeIn()),
                            ),

                            // Draw bounding boxes on top of the image
                          ],
                        ).animate().fadeIn(
                            duration: Duration(),
                            delay: Duration(milliseconds: 200)),

                        SizedBox(
                          height: 20,
                        ),
                        //
                        timernew > 1
                            ? SizedBox.shrink()
                            : imgcon.isinitialized ||
                                    imgcon.profileImage != null
                                ? Row(
                                    children: [
                                      Expanded(
                                        child: InkWell(
                                          onTap: () async {
                                            await imgcon.retakeImage();
                                            countdowntimernew();
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
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.camera_sharp,
                                                  color: Colors.white,
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Text(
                                                  "Retake",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 24),
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

                                            // imgcon.initializeCamera(
                                            //   isfront: true,
                                            //   isback: false,
                                            //   isprofilecam: false,
                                            // );
                                            controller.changePage(3);
                                            controller.pageIncremeter(3);
                                            controller.listenPageChange();
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
                                            child: Center(
                                                child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Proceed",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 24),
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Icon(
                                                  Icons.check,
                                                  color: Colors.white,
                                                ),
                                              ],
                                            )),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ).animate().fadeIn(
                                    duration: Duration(milliseconds: 1200),
                                    delay: Duration(milliseconds: 400))
                                : SizedBox(),
                      ],
                    ),
                  )
                      .animate()
                      .scaleXY(
                          begin: 0.7,
                          end: 1,
                          curve: Curves.easeInCubic,
                          duration: Duration(milliseconds: 600))
                      .fadeIn(duration: Duration(milliseconds: 500)),
                  SizedBox(
                    height: 64,
                  ),
                  Container(
                    width: 540,
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    padding: EdgeInsets.all(32),
                    color: Colors.grey[200],
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '📸 Face Capture Instructions',
                            style: TextStyle(
                                color: Colors.grey[900],
                                fontWeight: FontWeight.bold,
                                fontSize: 24),
                          ),
                          SizedBox(
                            height: 32,
                          ),
                          Text(
                            '1. Stand close to the camera',
                            style: TextStyle(
                                color: Colors.grey[800],
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          Text(
                            '→ Maintain a distance of 1 - 2 ft',
                            style: TextStyle(
                                color: Colors.grey[800],
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Text(
                            '2. Align your face within the frame',
                            style: TextStyle(
                                color: Colors.grey[800],
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          Text(
                            '→ Make sure your entire face is visible — no cropping',
                            style: TextStyle(
                                color: Colors.grey[800],
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Text(
                            "3. Avoid background faces",
                            style: TextStyle(
                                color: Colors.grey[800],
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          Text(
                            '→ Only one face must be clearly visible in the frame',
                            style: TextStyle(
                                color: Colors.grey[800],
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
      });
    });
  }
}
