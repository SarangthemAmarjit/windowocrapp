import 'dart:developer';
import 'dart:io';
import 'package:camera_windows_example/controller/imagecapture.dart';
import 'package:camera_windows_example/windowcameradelegate.dart';
import 'package:flutter/material.dart';
import 'package:camera_platform_interface/camera_platform_interface.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CameraExample extends StatefulWidget {
  @override
  _CameraExampleState createState() => _CameraExampleState();
}

class _CameraExampleState extends State<CameraExample> {
  final ImagePicker _picker = ImagePicker();
  List<CameraDescription> _cameras = [];
  int? _cameraIndex;
  String _cameraInfo = 'Fetching cameras...';
  XFile? _capturedImage;

  @override
  void initState() {
    super.initState();
    
    initCamera();
  }

  Future<void> _fetchCameras() async {
    try {
      final cameras = await CameraPlatform.instance.availableCameras();
      if (mounted) {
        setState(() {
          _cameras = cameras;
          _cameraIndex = cameras.isNotEmpty ? 0 : null;
          _cameraInfo = cameras.isNotEmpty
              ? 'Found camera: ${cameras.first.name}'
              : 'No available cameras';
          final ImagePicker _picker = ImagePicker();
        });
      }
    } catch (e) {
      _showInSnackBar('Error fetching cameras: $e');
    }
  }

  Future<void> _captureImage() async {
    if (_cameraIndex == null || _cameras.isEmpty) {
      _showInSnackBar('No cameras available for capture.');
      return;
    }

    try {
      if (Platform.isWindows) {
        // Show a message that this feature is not supported on Windows.
        // Use ImagePicker for image capture
        final XFile? image =
            await _picker.pickImage(source: ImageSource.camera);
        if (image != null) {
          setState(() {
            _capturedImage = image;
          });
        }
      } else {}
    } catch (e) {
      log(e.toString());
      // _showInSnackBar('Error capturing image: $e');
    }
  }

  void _showInSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  Widget _buildPreview({required int id}) {
    log(id.toString());
    return CameraPlatform.instance.buildPreview(id);
  }

  @override
  Widget build(BuildContext context) {
    Imagecontroller imgcon = Get.put(Imagecontroller());
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Camera Example')),
        body: GetBuilder<Imagecontroller>(builder: (_) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(_cameraInfo),
                imgcon.cameraid != null
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                        child: Align(
                          child: Container(
                            constraints: const BoxConstraints(
                              maxHeight: 500,
                            ),
                            child: Transform.flip(
                              flipX: true,
                              child: AspectRatio(
                                aspectRatio: imgcon.previewsize!.width /
                                    imgcon.previewsize!.height,
                                child: _buildPreview(id: imgcon.cameraid!),
                              ),
                            ),
                          ),
                        ),
                      )
                    : SizedBox(),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: WindowsCameraDelegate().takePhoto,
                  child: Text('Capture Image'),
                ),
                SizedBox(height: 16),
                if (_capturedImage != null)
                  Image.file(
                    File(_capturedImage!.path),
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
