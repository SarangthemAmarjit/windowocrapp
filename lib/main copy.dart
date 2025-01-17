import 'dart:async';
import 'dart:io';

import 'package:camera_platform_interface/camera_platform_interface.dart';
import 'package:flutter/material.dart';
import 'package:opencv_dart/opencv.dart' as cv;

/// Example app for Camera with Document Detection.
class OpencvPage extends StatefulWidget {
  const OpencvPage({super.key});

  @override
  State<OpencvPage> createState() => _OpencvPageState();
}

class _OpencvPageState extends State<OpencvPage> {
  String _cameraInfo = 'Unknown';
  List<CameraDescription> _cameras = <CameraDescription>[];
  int _cameraIndex = 0;
  int _cameraId = -1;
  bool _initialized = false;
  Size? _previewSize;
  MediaSettings _mediaSettings = const MediaSettings(
    resolutionPreset: ResolutionPreset.high,
    fps: 30,
    videoBitrate: 2000000,
    audioBitrate: 32000,
    enableAudio: true,
  );

  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    _fetchCameras();
  }

  @override
  void dispose() {
    _disposeCurrentCamera();
    super.dispose();
  }

  Future<void> _fetchCameras() async {
    try {
      final cameras = await CameraPlatform.instance.availableCameras();
      if (mounted) {
        setState(() {
          _cameras = cameras;
          _cameraIndex = 0;
          _cameraInfo = cameras.isNotEmpty
              ? 'Found camera: ${cameras.first.name}'
              : 'No available cameras';
        });
      }
    } catch (e) {
      _showInSnackBar('Error fetching cameras: $e');
    }
  }

  Future<void> _initializeCamera() async {
    if (_cameras.isEmpty) return;

    final camera = _cameras[_cameraIndex % _cameras.length];
    try {
      final cameraId = await CameraPlatform.instance.createCameraWithSettings(
        camera,
        _mediaSettings,
      );

      await CameraPlatform.instance.initializeCamera(cameraId);

      if (mounted) {
        setState(() {
          _cameraId = cameraId;
          _initialized = true;
          _cameraInfo = 'Capturing camera: ${camera.name}';
        });
      }
    } catch (e) {
      _showInSnackBar('Failed to initialize camera: $e');
    }
  }

  Future<void> _disposeCurrentCamera() async {
    if (_cameraId < 0) return;

    try {
      await CameraPlatform.instance.dispose(_cameraId);
      if (mounted) {
        setState(() {
          _initialized = false;
          _cameraId = -1;
          _cameraInfo = 'Camera disposed';
        });
      }
    } catch (e) {
      _showInSnackBar('Error disposing camera: $e');
    }
  }

  Future<void> _captureAndProcessImage() async {
    try {
      if (!_initialized || _cameraId < 0) return;

      // Capture image
      final XFile file = await CameraPlatform.instance.takePicture(_cameraId);

      // Process image with OpenCV
      final String processedPath = await _processImage(file.path);

      _showInSnackBar('Processed image saved at: $processedPath');
    } catch (e) {
      _showInSnackBar('Error capturing or processing image: $e');
    }
  }

  Future<String> _processImage(String imagePath) async {
    try {
      // Load the image into a Mat
      final cv.Mat image = await cv.imread(imagePath);

      // Convert to grayscale
      final cv.Mat gray = await cv.cvtColor(image, cv.COLOR_BGR2BGRA);

      // Apply Gaussian Blur
      final cv.Mat blurred = await cv.gaussianBlur(
          gray,
          (
            5,
            5,
          ),
          0);

      // Detect edges using Canny edge detection
      final cv.Mat edges = await cv.canny(blurred, 50, 150);

// Find contours
      final cv.VecVecPoint contours =
          cv.VecVecPoint(); // Initialize MatVector for contours
// Required for hierarchy data
      await cv.findContours(
        edges,

        cv.RETR_EXTERNAL, // External contours
        cv.CHAIN_APPROX_SIMPLE, // Approximation method
      );

// Clone the original image for drawing
      final cv.Mat output = image.clone();

// Draw contours
      await cv.drawContours(
        output, // Destination image
        contours, // Contours to draw
        -1, // Index (-1 for all contours)
        cv.Scalar(255, 0, 0), // Color in Scalar (Red)
        // Thickness
      );

      // Save the processed image
      final String outputPath =
          '${Directory.systemTemp.path}/processed_image.png';
      await cv.imwrite(outputPath, output);

      return outputPath;
    } catch (e) {
      _showInSnackBar('Error processing image: $e');
      return imagePath;
    }
  }

  void _showInSnackBar(String message) {
    _scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: _scaffoldMessengerKey,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Document Detection with Camera'),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(_cameraInfo),
            ),
            if (_cameras.isEmpty)
              ElevatedButton(
                onPressed: _fetchCameras,
                child: const Text('Check Cameras'),
              ),
            if (_cameras.isNotEmpty) ...[
              ElevatedButton(
                onPressed:
                    _initialized ? _disposeCurrentCamera : _initializeCamera,
                child: Text(_initialized ? 'Dispose Camera' : 'Start Camera'),
              ),
              ElevatedButton(
                onPressed: _initialized ? _captureAndProcessImage : null,
                child: const Text('Capture & Detect Document'),
              ),
            ],
            if (_initialized && _cameraId > 0)
              Expanded(
                child: CameraPlatform.instance.buildPreview(_cameraId),
              ),
          ],
        ),
      ),
    );
  }
}
