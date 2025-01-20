import 'dart:async';
import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:camera_platform_interface/camera_platform_interface.dart';
import 'package:camera_windows_example/controller/imagecapture.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';

void initCamera() {
  if (Platform.isWindows) {
    /// Add camera support to Image Picker on Windows.
    WindowsCameraDelegate.register();
    WindowsCameraDelegate()._fetchCameras();
  }
}

class WindowsCameraDelegate extends ImagePickerCameraDelegate {
  List<CameraDescription> _cameras = [];
  int _cameraId = -1;
  bool _initialized = false;
  bool _isTakingPhoto = false;
  StreamSubscription<CameraErrorEvent>? _errorStreamSubscription;

  @override
  Future<XFile?> takePhoto(
      {ImagePickerCameraDelegateOptions options =
          const ImagePickerCameraDelegateOptions()}) async {
    if (_isTakingPhoto) {
      return null;
    }
    _isTakingPhoto = true;

    if (!_initialized) {
      await _initializeCamera();
    }

    try {
      // Capture the image
      final file = await CameraPlatform.instance.takePicture(_cameraId);
      return file;
    } catch (e) {
      // HMBToast.error('Error capturing image: $e');
      return null;
    } finally {
      await _disposeCamera();
      _isTakingPhoto = false;
    }
  }

  Future<void> _fetchCameras() async {
    try {
      _cameras = await CameraPlatform.instance.availableCameras();
      print(_cameras);
    } catch (e) {
      print(e);
      // HMBToast.error('Error fetching cameras: $e');
    }
  }

  Future<void> _initializeCamera() async {
    Imagecontroller imgcon = Get.put(Imagecontroller());
    print('initializeCamera');
    if (_cameras.isEmpty) {
      await _fetchCameras();
    }

    try {
      final camera = _cameras.first;
      _cameraId = await CameraPlatform.instance.createCameraWithSettings(
        camera,
        const MediaSettings(resolutionPreset: ResolutionPreset.high, fps: 30),
      );

      final Future<CameraInitializedEvent> initialized =
          CameraPlatform.instance.onCameraInitialized(_cameraId).first;
      final CameraInitializedEvent event = await initialized;
      // Listen for camera initialization
      await CameraPlatform.instance.initializeCamera(_cameraId);
      _initialized = true;
      imgcon.setcameraid(
          id: _cameraId,
          size: Size(
            event.previewWidth,
            event.previewHeight,
          ));

      // Start monitoring the camera error stream
      _monitorCameraErrors();
    } catch (e) {
      // HMBToast.error('Error initializing camera: $e');
      _initialized = false;
    }
  }

  void _monitorCameraErrors() {
    // Cancel any previous subscription to avoid duplicate listeners
    unawaited(_errorStreamSubscription?.cancel());

    _errorStreamSubscription =
        CameraPlatform.instance.onCameraError(_cameraId).listen((errorEvent) {
      // HMBToast.error('Camera error detected: ${errorEvent.description}');
      unawaited(_resetCamera());
    });
  }

  Future<void> _resetCamera() async {
    await _disposeCamera();
    await _initializeCamera();
  }

  Future<void> _disposeCamera() async {
    // Dispose of error stream
    await _errorStreamSubscription?.cancel();
    _errorStreamSubscription = null;

    if (_initialized) {
      await CameraPlatform.instance.dispose(_cameraId);
      _initialized = false;
    }
  }

  @override
  Future<XFile?> takeVideo(
      {ImagePickerCameraDelegateOptions options =
          const ImagePickerCameraDelegateOptions()}) {
    throw UnimplementedError('Video capture is not yet supported on Windows.');
  }

  /// Initialize this CameraDelegate
  /// This method should be called before the ImagePicker is used
  /// on Windows.
  static void register() {
    final instance = ImagePickerPlatform.instance;
    if (instance is CameraDelegatingImagePickerPlatform) {
      instance.cameraDelegate = WindowsCameraDelegate();
    }
  }
}
