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

class PhotoSignaturePage extends StatefulWidget {
  const PhotoSignaturePage({super.key});

  @override
  State<PhotoSignaturePage> createState() => _PhotoSignaturePageState();
}

class _PhotoSignaturePageState extends State<PhotoSignaturePage> {

    List<FaceDetection>? _detections;
  Uint8List? _imageBytes;
  int  _imageWidth = 400;
  int? _imageHeight = 400;
  Haarcascade? cascade;
  var _scheduler;

   late CameraWindows _cameraWindows;
  late StreamController<Image> _imageStreamController;
  Uint8List? image;

  @override
  void initState() {
    // TODO: implement initState
    
    super.initState();
    // loadcascade();

    Get.find<Imagecontroller>().initializeCamera(
                                 isfront: false,
                                 isback: false,
                                 isprofilecam: true,
                                 context: context);

                       
// schedule();
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            countdownTimer();
      },);
  }



  @override
  void dispose() {
    _imageStreamController.close();
    _scheduler.cancel();
    super.dispose();
  }

  Future<void> loadcascade() async {
      cascade = await Haarcascade.load();
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

  Future<void> _runFaceDetection(XFile files) async {
    // 1) Load the Haar Cascade data

    // 2) Load the image bytes from assets
    // final ByteData data = await rootBundle.load('assets/images/pics.jpeg');
    // _imageBytes = data.buffer.asUint8List();
      final _imagefile = await files.readAsBytes();
    // 3) Decode the image so we get the width and height
    // final decoded = await decodeImageFromList(_imagefile);
    // _imageWidth = decoded.width;
    // _imageHeight = decoded.height;

        final cropped = img.copyCrop(
          img.decodeImage(_imagefile)!,
        x: 0,
        y: 0,
        width: 400,
        height: 400,
      );

  Directory directory = await getApplicationDocumentsDirectory();

  // Create a unique file path in the temporary directory
  String filePath = '${directory.path}\face.jpg';

  // Create a File and write the bytes to it
  File file = File(filePath);
  await file.writeAsBytes(cropped.toUint8List());

    // 5) Run face detection on the image file

    // if(cascade!=null){
    // _detections = cascade!.detect(file);

    // }

    // 6) Update the UI
    setState(() {
      image = cropped.toUint8List();

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
                  Text("Profile Photo",style: TextStyle(fontSize: 30,color: Colors.green),),
                Text("Please look at the Camera and stand still.",style: TextStyle(fontSize: 20),),
                timer<=1?SizedBox(height: 20,): Text(' Capturing in $timer seconds.').animate().fadeIn(),
                  // Divider(),
                  SizedBox(
                    height: 10,
                  ),
              
                  Container(
                       height: 400,
                               width: 400,
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
                    if (_detections != null && _detections!.isNotEmpty)
                      CustomPaint(
                        painter: FacePainter(_detections!),
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
                                          onTap: (){
                                              imgcon.retakeImage();
                                                            countdownTimer();
                                          },
                                          child: Container(

                                            margin: EdgeInsets.symmetric(horizontal: 32),
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
                           margin: EdgeInsets.symmetric(horizontal: 32),
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


/// A simple [CustomPainter] to draw bounding boxes for face detections.
class FacePainter extends CustomPainter {
  final List<FaceDetection> detections;

  FacePainter(this.detections);

  @override
  void paint(Canvas canvas, Size size) {
    // Define the paint for our rectangle
    final paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    // Draw each detection as a rectangle
    for (final detection in detections) {
      canvas.drawRect(
        Rect.fromLTWH(
          detection.x.toDouble(),
          detection.y.toDouble(),
          detection.width.toDouble(),
          detection.height.toDouble(),
        ),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(FacePainter oldDelegate) {
    // Repaint if the list of detections changes
    return oldDelegate.detections != detections;
  }
}