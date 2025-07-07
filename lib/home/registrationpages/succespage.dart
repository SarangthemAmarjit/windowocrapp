import 'package:audioplayers/audioplayers.dart';
import 'package:camera_windows_example/controller/imagecapture.dart';
import 'package:camera_windows_example/controller/managementcontroller.dart';
import 'package:camera_windows_example/controller/pagecontroller.dart';
import 'package:camera_windows_example/home/registrationpages/paymentdetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'dart:async';

class Successpages extends StatefulWidget {
  const Successpages(
      {super.key,
      this.transactionstatus,
      this.trasactionstatus,
      this.transactionid,
      this.paymentmethodname,
      this.totalamount});
  final String? transactionstatus;
  final int? trasactionstatus;
  final String? transactionid;
  final String? paymentmethodname;
  final String? totalamount;
  @override
  State<Successpages> createState() => _SuccesspagesState();
}

class _SuccesspagesState extends State<Successpages> {
  final player = AudioPlayer();

  void playTimerSound(String audio) {
    try{

    player.play(AssetSource(audio)); // Plays the sound once
    }catch(e){

    }
  }

  Timer? _timer;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if( Get.find<PagenavControllers>().mainpageindex == 7 || Get.find<PagenavControllers>().mainpageindex == 5 || Get.find<Imagecontroller>().receipt!=null ){

          playTimerSound('success.mp3');
      } 

      startDelayedAction();
    });
  }

  void startDelayedAction() {
    _timer = Timer(Duration(seconds: 15), () {
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
                  // SizedBox(
                  //   height: 100,
                  //   width: 100,
                  //   child: Image.asset("assets/images/kanglashaok.png"),
                  // ),
                  SizedBox(
                    height: 100,
                  ),
                  Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16)),
                          child:pagectrl.mainpageindex == 7 || pagectrl.mainpageindex==5  ||imgcon.receipt != null?  Lottie.asset('assets/receipt.json',
                              repeat: false):SizedBox() )
                      .animate()
                      .fadeIn()
                      .slideY(
                          begin: -0.5,
                          end: 0,
                          duration: Duration(milliseconds: 800)),
                  SizedBox(
                    height: 40,
                  ),
                        pagectrl.mainpageindex == 7 
                      ? Text(
                          "User already exists.\nPlease collect your receipt and go to the ILP Counter",
                          style: TextStyle(fontSize: 30),textAlign: TextAlign.center
                        ).animate().fadeIn().slideY(
                          begin: 1, end: 0, delay: Duration(milliseconds: 400)):
                  pagectrl.mainpageindex == 6
                      ? Text(
                          "Failed to process Online Payment.\nYour Receipt has been Generated. Please collect your receipt and go to the ILP Counter",
                          style: TextStyle(fontSize: 30),
                          textAlign: TextAlign.center
                        ).animate().fadeIn().slideY(
                          begin: 1, end: 0, delay: Duration(milliseconds: 400))
                      : imgcon.receipt != null 
                          ? Text(
                              "Your Receipt Has been Generated. Please collect your receipt and go to the ILP Counter",
                              style: TextStyle(fontSize: 30),
                              textAlign: TextAlign.center
                            ).animate().fadeIn().slideY(
                              begin: 1,
                              end: 0,
                              delay: Duration(milliseconds: 400))
                          : pagectrl.mainpageindex==5?Text("Your Receipt Has been Generated. Please collect your receipt",
                                  style: TextStyle(fontSize: 30),textAlign: TextAlign.center,)
                              .animate()
                              .fadeIn()
                              .slideY(
                                  begin: 0,
                                  end: 0,
                                  delay: Duration(milliseconds: 400)) : Text("Failed to generate permit.Please try again",
                                  style: TextStyle(fontSize: 30),textAlign: TextAlign.center,)
                              .animate()
                              .fadeIn()
                              .slideY(
                                  begin: 0,
                                  end: 0,
                                  delay: Duration(milliseconds: 400)),
                  SizedBox(
                    height: 50,
                  ),

                  Text("For Enquiry please go to the ILP Counter",style: GoogleFonts.montserrat(fontSize: 30,fontWeight: FontWeight.bold),),
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
                  ),

                  SizedBox(height: 100,),
                //  pagectrl.mainpageindex == 7||imgcon.receipt != null?
                    Text("Please collect your receipt.",style: GoogleFonts.montserrat(fontSize: 30,fontWeight: FontWeight.bold),)
                    // :SizedBox(),
                //  pagectrl.mainpageindex == 7||imgcon.receipt != null?
                  ,Image.asset(
                    
                    colorBlendMode: BlendMode.colorBurn,
                    "assets/images/downloads.gif",height: 300,width: 300,fit: BoxFit.cover,)
                    // :SizedBox()
                ],
              ),
            ),
          );
        });
      });
    });
  }
}
