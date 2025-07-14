import 'package:audioplayers/audioplayers.dart';
import 'package:camera_windows_example/controller/imagecapture.dart';
import 'package:camera_windows_example/controller/managementcontroller.dart';
import 'package:camera_windows_example/controller/pagecontroller.dart';
import 'package:camera_windows_example/home/registrationpages/paymentdetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'dart:async';

class OnlinePaymentPage extends StatefulWidget {
  const OnlinePaymentPage({
    super.key,
  });

  @override
  State<OnlinePaymentPage> createState() => _OnlinePaymentPageState();
}

class _OnlinePaymentPageState extends State<OnlinePaymentPage> {
  final player = AudioPlayer();

  void playTimerSound(String audio) {
    player.play(AssetSource(audio)); // Plays the sound once
  }

  Timer? _timer;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // if(widget.transactionstatus=="SUCCESS"){

      // playTimerSound('success.mp3');
      // startDelayedAction();

      // }
    });
  }

  void startDelayedAction() {
    _timer = Timer(Duration(seconds: 20), () {
      // This will execute after 5 seconds unless canceled
      Get.find<PagenavControllers>().reset();
      Get.find<Imagecontroller>().disposeAll();
      Get.find<Managementcontroller>().disposeAll();
      Get.find<PagenavControllers>().setmainpageindex(ind: 0);
    });
  }

  @override
  void dispose() {
    player.dispose();
    Get.find<PagenavControllers>().reset();
    Get.find<Imagecontroller>().disposeAll();

    Get.find<Managementcontroller>().disposeAll();
    Get.find<PagenavControllers>().setmainpageindexnoupdate(ind: 0);
    if (_timer != null) {
      _timer!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Managementcontroller>(builder: (mngctrl) {
      return GetBuilder<Imagecontroller>(builder: (imgcon) {
        return GetBuilder<PagenavControllers>(builder: (pagectrl) {
          return Center(
            child: Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: Image.asset("assets/images/kanglashaok.png"),
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16)),
                          child: Lottie.asset('assets/receipt.json',
                              repeat: false))
                      .animate()
                      .fadeIn()
                      .slideY(
                          begin: -0.5,
                          end: 0,
                          duration: Duration(milliseconds: 800)),
                  SizedBox(
                    height: 20,
                  ),
                  //  widget.transactionstatus=="SUCCESS" ? Text("Your Receipt Has been Generated. Please collect your receipt",style: TextStyle(fontSize: 30),).animate().fadeIn().slideY(begin: 1,end:0,delay: Duration(milliseconds: 400)):Text("Payment failed.\nFailed to generate permit.Please try again",style: TextStyle(fontSize: 30)).animate().fadeIn().slideY(begin: 0,end:0,delay: Duration(milliseconds: 400)),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 300,
                    child: ButtonCard(
                        title: "Apply New Permit",
                        onpress: () {
                          Get.find<PagenavControllers>().reset();
                          Get.find<Imagecontroller>().disposeAll();
                          Get.find<Managementcontroller>().disposeAll();
                          Get.find<PagenavControllers>()
                              .setmainpageindex(ind: 0);
                          if (_timer != null) {
                            _timer!.cancel();
                          }
                        }),
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
