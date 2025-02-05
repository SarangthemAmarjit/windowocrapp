import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:camera_platform_interface/camera_platform_interface.dart';
import 'package:camera_windows/camera_windows.dart';
import 'package:camera_windows_example/controller/imagecapture.dart';
import 'package:camera_windows_example/controller/managementcontroller.dart';
import 'package:camera_windows_example/models/permit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/_http/_stub/_file_decoder_stub.dart';
import 'package:haarcascade/haarcascade.dart';
import 'package:path_provider/path_provider.dart';

import '../../controller/pagecontroller.dart';

import 'package:image/image.dart' as img;

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
                       
// schedule();
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
         
      },);
  }

  void initialise()async{

   await Get.find<Imagecontroller>().initializeCameraAgain(
                                 isfront: false,
                                 isback: false,
                                 isprofilecam: true,
                                 context: context);
if(Get.find<Imagecontroller>().isinitialized){
 countdownTimer();
}
 


  }


  @override
  void dispose() {

    _scheduler.cancel();
    super.dispose();
  }

  void schedule(){
     _scheduler = Timer.periodic(Duration(seconds: 2),(timer) async {
        print("In Scheduler");
      try{
            Get.find<Imagecontroller>().takePicture();
      // await _runFaceDetection(file);
      }catch(e){
        print(e);
      }
    
      
      
      }); 
           
  }

  int timer= 0;
  var _sched;
  void countdownTimer(){
      timer = 8;
    _sched = Timer.periodic(Duration(seconds: 1), (TabController) {
      setState(() {
        timer--;
      if(timer<=1){
        if(_sched!=null){
                     Get.find<Imagecontroller>().takeprofilePicture();
          _sched.cancel();
         
        }
      }
      });
    },);

  }




  @override
  Widget build(BuildContext context) {
    return GetBuilder<Managementcontroller>(
      builder: (mngctrl) {
        return GetBuilder<PagenavControllers>(builder: (controller) {
          return GetBuilder<Imagecontroller>(
            builder: (imgcon) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Text("Profile Photo",style: TextStyle(fontSize: 30,color: Colors.green),),
         
         
         imgcon.profileimage!=null?BannerContainer(color:Colors.blue ,text: "Check if your face fits within the frame. Retake if necessary.",).animate().fadeIn() : imgcon.initialized?Text("Please look at the Camera and stand still.",style: TextStyle(fontSize: 26),):Text("Initializing Camera. Please Wait",style: TextStyle(fontSize: 20,color: Colors.green),),
                timer<=1?SizedBox(height: 20,): Text(' Capturing in $timer seconds.',style: TextStyle(fontSize: 20),).animate().fadeIn(),
                // Divider(),
                  SizedBox(
                    height: 10,
                  ),
              
                  Container(
                       height: 600,
                               width: 600,
                    child: Stack(
                      children: [
                        
              
                                  
                           Container(
                        
                             decoration: BoxDecoration(
                               border: Border.all(
                                 color: Colors.grey[700]!,
                               ),
                               borderRadius: BorderRadius.circular(10),
                             ),
                             child: ClipRRect(
                               borderRadius: BorderRadius.circular(10),
                               child: imgcon.profileimage != null
                                   ? Transform.flip(
                                       flipX: true,
                                       child: Image.file(
                                         fit: BoxFit.contain,
                                         File(imgcon.profileimage!.path),
                                       ),
                                     )
                                   : imgcon.buildPreview()
                             ),
                           ),
                        Positioned(
                          top: 0,
                          right: 0,left: 0,bottom: 0,
                          child: AnimatedOpacity(
                                opacity: timer<=1?0:1,
                          duration: Duration(seconds: 1),
                            child: Center(child: Text('$timer',style: TextStyle(fontSize: 200),).animate().fadeIn())),),
                    
                                     // Draw bounding boxes on top of the image
              
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
                                          onTap: (){
                                              imgcon.retakeImage();
                                                            countdownTimer();
                                          },
                                          child: Container(

                                            margin: EdgeInsets.symmetric(horizontal: 32,vertical: 16),
                                                                    width: double.infinity,
                                                                    padding: EdgeInsets.all(32),
                                                                    decoration: BoxDecoration(
                                                                        color: Colors.red, borderRadius: BorderRadius.circular(8)),
                                                                    clipBehavior: Clip.antiAlias,
                                                                    child: Center(
                                                                        child: Text(
                                                                      "Retake",
                                                                      style: TextStyle(color: Colors.white,fontSize: 24),
                                                                    )),
                                                                  ),
                                        ),
                                      ),
                      Expanded(
                        child: Container(
                           margin: EdgeInsets.symmetric(horizontal: 32,vertical: 16),
                          width: double.infinity,
                          padding: EdgeInsets.all(32),
                          decoration: BoxDecoration(
                              color: Colors.green, borderRadius: BorderRadius.circular(8)),
                          clipBehavior: Clip.antiAlias,
                          child: Center(
                              child: Text(
                            "Proceed",
                            style: TextStyle(color: Colors.white,fontSize: 24),
                          )),
                        ),
                      ),
                    ],
                  ),
                ],
              ).animate().fadeIn(duration: Duration(milliseconds: 500));
            }
          );
        });
      }
    );
  }
}



