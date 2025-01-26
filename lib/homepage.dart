import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:camera_platform_interface/camera_platform_interface.dart';
import 'package:camera_windows_example/controller/imagecapture.dart';
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
    return GetBuilder<Imagecontroller>(builder: (_) {
      return SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                            side: BorderSide(color: Colors.green),
                            borderRadius: BorderRadius.circular(10))),
                        backgroundColor: WidgetStatePropertyAll(
                            imgcon.isFrontcapturebuttonpress
                                ? const Color.fromARGB(255, 216, 236, 217)
                                : Colors.white)),
                    onPressed: () {
                      imgcon.initializeCamera(
                          isfront: true, isback: false, isprofilecam: false);
                      // _initializeCamera(isfront: true);
                    },
                    child: Text('Capture Front Side'),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  // Csizebapture back side of the ID card

                  ElevatedButton(
                    style: ButtonStyle(
                        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                            side: BorderSide(color: Colors.green),
                            borderRadius: BorderRadius.circular(10))),
                        backgroundColor: WidgetStatePropertyAll(
                            imgcon.isBackcapturebuttonpress
                                ? const Color.fromARGB(255, 216, 236, 217)
                                : Colors.white)),
                    onPressed: () {
                      imgcon.initializeCamera(
                          isfront: false, isback: false, isprofilecam: false);
                      // _initializeCamera(isfront: false);
                    },
                    child: Text('Capture Back Side'),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  // Csizebapture back side of the ID card

                  ElevatedButton(
                    style: ButtonStyle(
                        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                            side: BorderSide(color: Colors.green),
                            borderRadius: BorderRadius.circular(10))),
                        backgroundColor: WidgetStatePropertyAll(
                            imgcon.isBackcapturebuttonpress
                                ? const Color.fromARGB(255, 216, 236, 217)
                                : Colors.white)),
                    onPressed: () {
                      imgcon.initializeCamera(
                          isfront: false, isback: true, isprofilecam: true);
                      // _initializeCamera(isfront: false);
                    },
                    child: Text('Capture Profile Image'),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 50, left: 40, right: 40),
              child: Container(
                constraints: imgcon.iscamerashown
                    ? null
                    : const BoxConstraints(maxHeight: 250, maxWidth: 500),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all()),
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
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                ),
                                child: Align(
                                  child: Container(
                                    constraints: const BoxConstraints(
                                      maxHeight: 250,
                                    ),
                                    child: Transform.flip(
                                      flipX: true,
                                      child: AspectRatio(
                                          aspectRatio:
                                              imgcon.previewsize!.width /
                                                  imgcon.previewsize!.height,
                                          child: imgcon.buildPreview()),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 50, bottom: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        imgcon.disposeCurrentCamera();
                                      },
                                      child: Text('Cancel'),
                                    ),
                                    const SizedBox(width: 5),
                                    ElevatedButton(
                                      onPressed: () {
                                        imgcon.takePicture();
                                      },
                                      child: const Text('Capture ID'),
                                    ),
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                imgcon.frontimage != null
                    ? Container(
                        height: 120,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all()),
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
                        constraints:
                            const BoxConstraints(maxHeight: 120, maxWidth: 160),
                      ),
                SizedBox(
                  height: 40,
                ),
                imgcon.backImage != null
                    ? Container(
                        height: 120,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all()),
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
                            border: Border.all()),
                        constraints:
                            const BoxConstraints(maxHeight: 120, maxWidth: 160),
                      ),
              ],
            )
          ],
        ),
      );
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
