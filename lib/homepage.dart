import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:camera_platform_interface/camera_platform_interface.dart';
import 'package:camera_windows_example/cons/constant.dart';
import 'package:camera_windows_example/controller/imagecapture.dart';
import 'package:camera_windows_example/controller/pagecontroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class IdSelectionAndScanningScreen extends StatefulWidget {
  @override
  _IdSelectionAndScanningScreenState createState() =>
      _IdSelectionAndScanningScreenState();
}

class _IdSelectionAndScanningScreenState
    extends State<IdSelectionAndScanningScreen> {
  @override
  Widget build(BuildContext context) {
    Imagecontroller imgcon = Get.put(Imagecontroller());
    PagenavControllers pngcon = Get.put(PagenavControllers());
    return GetBuilder<PagenavControllers>(builder: (_) {
      return GetBuilder<Imagecontroller>(builder: (_) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Text(
                'Scan Your ${documentTypes[pngcon.docindex]} ID',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 50),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       ElevatedButton(
            //         style: ButtonStyle(
            //             shape: WidgetStatePropertyAll(RoundedRectangleBorder(
            //                 side: BorderSide(color: Colors.green),
            //                 borderRadius: BorderRadius.circular(10))),
            //             backgroundColor: WidgetStatePropertyAll(
            //                 imgcon.isFrontcapturebuttonpress
            //                     ? const Color.fromARGB(255, 216, 236, 217)
            //                     : Colors.white)),
            //         onPressed: () {
            //           imgcon.initializeCamera(
            //               isfront: true,
            //               isback: false,
            //               isprofilecam: false,
            //               context: context);
            //           // _initializeCamera(isfront: true);
            //         },
            //         child: Padding(
            //           padding: const EdgeInsets.symmetric(
            //               vertical: 30, horizontal: 20),
            //           child: Text(
            //             'Capture Front Side',
            //             style: TextStyle(fontSize: 23),
            //           ),
            //         ),
            //       ),
            //       pngcon.docindex == 3 || pngcon.docindex == 1
            //           ? SizedBox()
            //           : SizedBox(
            //               width: 30,
            //             ),
            //       // Csizebapture back side of the ID card

            //       pngcon.docindex == 3 || pngcon.docindex == 1
            //           ? SizedBox()
            //           : ElevatedButton(
            //               style: ButtonStyle(
            //                   shape: WidgetStatePropertyAll(
            //                       RoundedRectangleBorder(
            //                           side: BorderSide(color: Colors.green),
            //                           borderRadius: BorderRadius.circular(10))),
            //                   backgroundColor: WidgetStatePropertyAll(
            //                       imgcon.isBackcapturebuttonpress
            //                           ? const Color.fromARGB(255, 216, 236, 217)
            //                           : Colors.white)),
            //               onPressed: () {
            //                 imgcon.initializeCamera(
            //                     isfront: false,
            //                     isback: true,
            //                     isprofilecam: false,
            //                     context: context);
            //                 // _initializeCamera(isfront: false);
            //               },
            //               child: Padding(
            //                 padding: const EdgeInsets.symmetric(
            //                     vertical: 30, horizontal: 20),
            //                 child: Text(
            //                   'Capture Back Side',
            //                   style: TextStyle(fontSize: 23),
            //                 ),
            //               ),
            //             ),

            //       // Csizebapture back side of the ID card
            //     ],
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.only(bottom: 50, left: 40, right: 40),
              child: Container(
                constraints: imgcon.iscamerashown
                    ? null
                    : const BoxConstraints(maxHeight: 250, maxWidth: 500),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.white)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    imgcon.iscamerashown
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              imgcon.iscamerashown
                                  ? Padding(
                                      padding: const EdgeInsets.only(left: 30),
                                      child: Center(
                                        child: Text(
                                          imgcon.isFrontcapturebuttonpress
                                              ? 'Place the front side of the ID card within the frame.'
                                              : 'Flip the card and place the back side within the frame.',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                    )
                                  : SizedBox(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 10,
                                      ),
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Container(
                                          constraints: BoxConstraints(
                                              maxHeight: pngcon.docindex == 1
                                                  ? 180
                                                  : 160,
                                              maxWidth: pngcon.docindex == 1
                                                  ? 600
                                                  : 500
                                              // maxHeight: 160, maxWidth: 500
                                              ),
                                          child: Transform.flip(
                                            flipX: true,
                                            child: AspectRatio(
                                              aspectRatio: pngcon.docindex == 1
                                                  ? 12.5 / 7.5
                                                  : 12.5 / 7,

                                              // Passport photo ratio
                                              child: Center(
                                                child: ClipRect(
                                                  child: OverflowBox(
                                                    alignment: Alignment.center,
                                                    maxWidth:
                                                        pngcon.docindex == 1
                                                            ? 500
                                                            : 600,
                                                    maxHeight:
                                                        pngcon.docindex == 1
                                                            ? 300
                                                            : 420,
                                                    // maxWidth: 600,
                                                    // maxHeight: 420,
                                                    child: FittedBox(
                                                      fit: BoxFit
                                                          .contain, // Ensure it covers the entire aspect ratio
                                                      child: SizedBox(
                                                        width: imgcon
                                                            .previewsize!.width,
                                                        height: imgcon
                                                            .previewsize!
                                                            .height,
                                                        child: imgcon
                                                            .buildPreview(), // Your camera preview
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 40),
                                        child: ElevatedButton(
                                          onPressed: () {
                                            imgcon.takePicture();
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    255, 0, 66, 234),
                                            foregroundColor: Colors.white,
                                            textStyle: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: Text(
                                              imgcon.isFrontcapturebuttonpress
                                                  ? 'Capture Front Side'
                                                  : 'Capture Back Side',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 18),
                                            ),
                                          ),
                                        )),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 50, bottom: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10))),
                                      onPressed: () {
                                        imgcon.disposeCurrentCamera();
                                      },
                                      child: Text('Cancel'),
                                    ),
                                    const SizedBox(width: 5),
                                  ],
                                ),
                              ),
                            ],
                          )
                        : Center(child: Text('Camera Preview Area'))
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: pngcon.docindex == 3 || pngcon.docindex == 1
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.spaceAround,
              children: [
                imgcon.frontimage != null
                    ? Container(
                        height: 120,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.white)),
                        // constraints: const BoxConstraints(
                        //     maxHeight: 120, maxWidth: 160),
                        child: Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(
                              fit: BoxFit.contain,
                              File(imgcon.frontimage!.path),
                            ),
                          ),
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.white)),
                        constraints:
                            const BoxConstraints(maxHeight: 120, maxWidth: 160),
                      ),
                pngcon.docindex == 3 || pngcon.docindex == 1
                    ? SizedBox()
                    : Row(
                        children: [
                          imgcon.backImage != null
                              ? Container(
                                  height: 120,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: Colors.white)),
                                  // constraints: const BoxConstraints(
                                  //     maxHeight: 120, maxWidth: 160),
                                  child: Center(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.file(
                                        File(imgcon.backImage!.path),
                                      ),
                                    ),
                                  ),
                                )
                              : Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: Colors.white)),
                                  constraints: const BoxConstraints(
                                      maxHeight: 120, maxWidth: 160),
                                ),
                        ],
                      ),
              ],
            ),
            SizedBox(
              height: 70,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 50, right: 50),
                child: ElevatedButton(
                  onPressed: () {
                    pngcon.setmainpageindex(ind: 1);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 0, 183, 234),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 60, vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Back', style: TextStyle(fontSize: 20)),
                ),
              ),
            ),
          ],
        );
      });
    });
  }
}

class AutoFillFormScreen extends StatelessWidget {
  final XFile frontImage;
  final XFile backImage;

  AutoFillFormScreen({required this.frontImage, required this.backImage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Auto-Fill Form')),
      body: Center(
        child: Text(
          'Front and Back images received!\nFront: ${frontImage.path}\nBack: ${backImage.path}',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
