import 'dart:developer';
import 'dart:io';
import 'package:camera_platform_interface/camera_platform_interface.dart';
import 'package:camera_windows_example/controller/imagecapture.dart';
import 'package:camera_windows_example/controller/managementcontroller.dart';
import 'package:camera_windows_example/controller/pagecontroller.dart';
import 'package:camera_windows_example/home/registrationpages/signatureclass.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

class IdSelectionAndScanningScreen extends StatefulWidget {
  @override
  _IdSelectionAndScanningScreenState createState() =>
      _IdSelectionAndScanningScreenState();
}

class _IdSelectionAndScanningScreenState
    extends State<IdSelectionAndScanningScreen> {
  final GlobalKey _key = GlobalKey();
  bool signaturePage = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
        WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).unfocus(); // Hide keyboard when the screen starts
    });
  }

  @override
  void dispose() {
    Get.find<Imagecontroller>().disposeCurrentsCamera();
    super.dispose();
  }

  void changepages() {
    setState(() {
      signaturePage = !signaturePage;
    });
  }

  @override
  Widget build(BuildContext context) {
    Imagecontroller imgcon = Get.put(Imagecontroller());
    PagenavControllers pngcon = Get.put(PagenavControllers());
    Managementcontroller mngcon = Get.put(Managementcontroller());
    return GetBuilder<PagenavControllers>(builder: (_) {
      return GetBuilder<Imagecontroller>(builder: (_) {
        log("imgcon.isFrontcapturebuttonpress : " +
            imgcon.isFrontcapturebuttonpress.toString());
        return signaturePage
            ? PaintCanvas()
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    child: Text(
                      'Scan Your ${mngcon.getDocNames[pngcon.docindex]} ID',
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
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
                  //       pngcon.docindex == 3
                  //           ? SizedBox()
                  //           : SizedBox(
                  //               width: 30,
                  //             ),
                  //       // Csizebapture back side of the ID card

                  //       pngcon.docindex == 3
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
                    padding:
                        const EdgeInsets.only(bottom: 50, left: 40, right: 40),
                    child: Container(
                      constraints: imgcon.iscamerashown
                          ? null
                          : const BoxConstraints(maxHeight: 250, maxWidth: 500),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey[700]!)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          imgcon.iscamerashown
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    imgcon.iscamerashown
                                        ? Padding(
                                            padding:
                                                const EdgeInsets.only(left: 30),
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
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                                    maxHeight:
                                                        pngcon.docindex == 3
                                                            ? 195
                                                            : 180,
                                                    maxWidth:
                                                        pngcon.docindex == 3
                                                            ? 600
                                                            : 500
                                                    // maxHeight: 160, maxWidth: 500
                                                    ),
                                                child: Transform.flip(
                                                  flipX: true,
                                                  child: AspectRatio(
                                                    aspectRatio:
                                                        pngcon.docindex == 3
                                                            ? 12.5 / 8
                                                            : 2.5 / 2,

                                                    // Passport photo ratio
                                                    child: Center(
                                                        child: ClipRect(
                                                      child: OverflowBox(
                                                        alignment:
                                                            Alignment.center,
                                                        maxWidth:
                                                            pngcon.docindex == 3
                                                                ? 500
                                                                : 500,
                                                        maxHeight:
                                                            pngcon.docindex == 3
                                                                ? 300
                                                                : 330,
                                                        // maxWidth: 600,
                                                        // maxHeight: 420,
                                                        child: FittedBox(
                                                          fit: BoxFit
                                                              .cover, // Ensure it covers the entire aspect ratio
                                                          child: SizedBox(
                                                            width: imgcon
                                                                .previewsize!
                                                                .width,
                                                            height: imgcon
                                                                .previewsize!
                                                                .height,
                                                            child: imgcon
                                                                .buildPreview(), // Your camera preview
                                                          ),
                                                        ),
                                                      ),
                                                    )),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 40),
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  imgcon.takePicture();
                                                  pngcon.listenPageChange();
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      const Color.fromARGB(
                                                          255, 0, 66, 234),
                                                  foregroundColor: Colors.white,
                                                  textStyle: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 10),
                                                  child: Text(
                                                    pngcon.docindex == 3
                                                        ? imgcon.isFrontcapturebuttonpress
                                                            ? 'Capture Page 1'
                                                            : 'Capture Page 2'
                                                        : imgcon.isFrontcapturebuttonpress
                                                            ? 'Capture Front Side'
                                                            : 'Capture Back Side',
                                                    textAlign: TextAlign.center,
                                                    style:
                                                        TextStyle(fontSize: 18),
                                                  ),
                                                ),
                                              )),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 30,
                                    )
                                    // Padding(
                                    //   padding: const EdgeInsets.only(
                                    //       right: 50, bottom: 20),
                                    //   child: Row(
                                    //     mainAxisAlignment: MainAxisAlignment.end,
                                    //     children: [
                                    //       ElevatedButton(
                                    //         style: ElevatedButton.styleFrom(
                                    //             shape: RoundedRectangleBorder(
                                    //                 borderRadius:
                                    //                     BorderRadius.circular(10))),
                                    //         onPressed: () {
                                    //           imgcon.disposeCurrentCamera();
                                    //         },
                                    //         child: Text('Cancel'),
                                    //       ),
                                    //       const SizedBox(width: 5),
                                    //     ],
                                    //   ),
                                    // ),
                                  ],
                                )
                              : Center(child: Text('Camera Preview Area'))
                        ],
                      ),
                    ),
                  ),
                  RepaintBoundary(
                    key: _key,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        // decoration: BoxDecoration(
                        //   borderRadius: BorderRadius.circular(10),
                        //   border: Border.all(),
                        //   color: Colors.white,
                        // ),
                        padding: EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // mainAxmainisAlignment: pngcon.docindex == 3
                          //     ? MainAxisAlignment.center
                          //     : MainAxisAlignment.spaceAround,
                          children: [
                            imgcon.frontimage != null
                                ? Container(
                                    height: 120,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border:
                                            Border.all(color: Colors.white)),
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
                                        border: Border.all()),
                                    height: 200,
                                    child: Center(
                                      child: Text(
                                        'Front Image Preview',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                    // decoration: BoxDecoration(
                                    //          image: DecorationImage(image: AssetImage('assets/images/aadhar.jpeg')),
                                    //     // borderRadius: BorderRadius.circular(10),
                                    //     // border: Border.all(color: Colors.black)

                                    //     ),

                                    constraints: const BoxConstraints(
                                        maxHeight: 200, maxWidth: 300),
                                  ),
                            SizedBox(
                              width: 30,
                            ),
                            Divider(),
                            pngcon.docindex == 2
                                ? SizedBox()
                                : imgcon.backImage != null
                                    ? Container(
                                        height: 120,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                color: Colors.black)),
                                        // constraints: const BoxConstraints(
                                        //     maxHeight: 120, maxWidth: 160),
                                        child: Center(
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.file(
                                              File(imgcon.backImage!.path),
                                            ),
                                          ),
                                        ),
                                      )
                                    : Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all()),
                                        height: 200,
                                        child: Center(
                                          child: Text(
                                            'Back Image Preview',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ),
                                        // decoration: BoxDecoration(
                                        //   image: DecorationImage(image: AssetImage('assets/images/aadhar.jpeg')),
                                        //     // borderRadius: BorderRadius.circular(10),
                                        //     // border: Border.all(color: Colors.black  )

                                        //     ),
                                        constraints: const BoxConstraints(
                                            maxHeight: 200, maxWidth: 300),
                                      ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 70,
                  ),
                  Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 800),
                      child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    // changing page in registration going back to image page
                                    pngcon.changePage(2);
                                    pngcon.listenPageChange();
                                  },
                                  child: Container(
                                    // margin: EdgeInsets.symmetric(horizontal: 16),
                                    width: double.infinity,
                                    padding: EdgeInsets.all(32),
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      // borderRadius: BorderRadius.circular(8)
                                    ),
                                    clipBehavior: Clip.antiAlias,
                                    child: Center(
                                        child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.replay,
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          "Back",
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
                                    //going to payment after success
                                    //         //  pngcon.changePage(4);
                                    //
                                    imgcon.saveCard(_key);

                                    changepages();
                                    pngcon.listenPageChange();
                                  },
                                  child: Container(
                                    //  margin: EdgeInsets.symmetric(horizontal: 16),
                                    width: double.infinity,
                                    padding: EdgeInsets.all(32),
                                    decoration: BoxDecoration(
                                      color: imgcon.frontimage != null &&
                                              imgcon.backImage != null
                                          ? Colors.green
                                          : Colors.green[300],
                                      //  borderRadius: BorderRadius.circular(8)
                                    ),
                                    clipBehavior: Clip.antiAlias,
                                    child: Center(
                                        child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Save & Proceed",
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
                          //  Row(
                          //   children: [
                          // Expanded(
                          //   child: ElevatedButton(
                          //         onPressed: () {
                          //           //changing page in registration going back to image page
                          //           pngcon.changePage(2);
                          //         },
                          //         style: ElevatedButton.styleFrom(
                          //           backgroundColor: const Color.fromARGB(255, 0, 183, 234),
                          //           foregroundColor: Colors.white,
                          //           padding: const EdgeInsets.symmetric(
                          //               horizontal: 60, vertical: 30),
                          //           shape: RoundedRectangleBorder(
                          //             borderRadius: BorderRadius.circular(8),
                          //           ),
                          //         ),
                          //         child: const Text('Back', style: TextStyle(fontSize: 20)),
                          //       ),
                          // ),
                          //   SizedBox(width: 20,),
                          // Expanded(
                          //   child: ElevatedButton(
                          //         onPressed: () {
                          //
                          //         },
                          //         style: ElevatedButton.styleFrom(
                          //           backgroundColor:Colors.green,
                          //           foregroundColor: Colors.white,
                          //           padding: const EdgeInsets.symmetric(
                          //               horizontal: 60, vertical: 30),
                          //           shape: RoundedRectangleBorder(
                          //             borderRadius: BorderRadius.circular(8),
                          //           ),
                          //         ),
                          //         child: const Text('Next', style: TextStyle(fontSize: 20)),
                          //       ),
                          // ),
                          //   ],
                          // ),

                          ),
                    ),
                  )
                ],
              )
                .animate()
                .scaleXY(
                    begin: 0.7,
                    end: 1,
                    curve: Curves.easeInCubic,
                    duration: Duration(milliseconds: 600))
                .fadeIn(duration: Duration(milliseconds: 500));
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
