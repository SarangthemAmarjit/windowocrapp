import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ocr_camera/ocr_camera_widget.dart';
import 'package:satya_textocr/satya_textocr.dart';



class OcrWindows extends StatefulWidget {
  OcrWindows({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _OcrWindowsState createState() => _OcrWindowsState();
}

class _OcrWindowsState extends State<OcrWindows> {
  late List<CameraDescription> _cameras;
  String _imgPath = '';

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        child: Visibility(
          visible: _imgPath.isNotEmpty,
          child: Image.file(
            File(_imgPath),
            width: _size.width,
            height: _size.height,
            fit: BoxFit.cover,
          ),
          replacement: Text('Image empty!'),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

             
              TextButton(
                onPressed: () async {
                  _cameras = await availableCameras();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OCRCameraWidget(
                                camera: _cameras,
                                maskType: MaskType.selfie,
                                onResult: (XFile? value) {
                                  setState(() {
                                    _imgPath = value!.path;
                                  });
                                  print(
                                    'XFile ----> ${value!.path}',
                                  );
                                },
                              )));
                },
                child: Text('Take a selfie'),
              ),
              TextButton(
                onPressed: () async {
                  _cameras = await availableCameras();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OCRCameraWidget(
                                camera: _cameras,
                                onResult: (XFile? value) {
                                  setState(() {
                                    _imgPath = value!.path;
                                  });
                                  print(
                                    'XFile ----> ${value!.path}',
                                  );
                                },
                              )));
                },
                child: Text('Take a photo'),
              ),
            ],
          )
        ],
      ),
    );
  }
}