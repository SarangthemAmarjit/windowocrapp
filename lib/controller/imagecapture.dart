import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:camera_platform_interface/camera_platform_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class Imagecontroller extends GetxController {
  Size? _previewSize;
  Size? get previewsize => _previewSize;

  int? _navindex;
  int? get navindex => _navindex;

  String? selectedCardType;

  XFile? _frontImage;
  XFile? get frontimage => _frontImage;

  XFile? _backImage;
  XFile? get backImage => _backImage;

  List<CameraDescription> _allavailablecameras = <CameraDescription>[];
  List<CameraDescription> get allavailablecameras => _allavailablecameras;
  int _cameraIndex = 0;
  int get cameraindex => _cameraIndex;

  int _cameraId = -1;
  int get cameraid => _cameraId;

  bool _isinitialized = false;
  bool get isinitialized => _isinitialized;

  bool _iscamerashown = false;
  bool get iscamerashown => _iscamerashown;

  bool _isFrontcapturebuttonpress = false;
  bool get isFrontcapturebuttonpress => _isFrontcapturebuttonpress;

  bool _isBackcapturebuttonpress = false;
  bool get isBackcapturebuttonpress => _isBackcapturebuttonpress;

  MediaSettings _mediaSettings = const MediaSettings(
    resolutionPreset: ResolutionPreset.high,
    fps: 30,
    videoBitrate: 200000,
    audioBitrate: 32000,
    enableAudio: true,
  );
  StreamSubscription<CameraErrorEvent>? _errorStreamSubscription;
  StreamSubscription<CameraClosingEvent>? _cameraClosingStreamSubscription;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    WidgetsFlutterBinding.ensureInitialized();
    _fetchCameras();
  }

  @override
  void dispose() {
    disposeCurrentCamera();
    _errorStreamSubscription?.cancel();
    _errorStreamSubscription = null;
    _cameraClosingStreamSubscription?.cancel();
    _cameraClosingStreamSubscription = null;
    super.dispose();
  }

  /// Fetches list of available cameras from camera_windows plugin.
  Future<void> _fetchCameras() async {
    String cameraInfo;

    int cameraIndex = 0;
    try {
      var availablecameras = await CameraPlatform.instance.availableCameras();
      log("All Cameras : " + availablecameras.toString());
      if (availablecameras.isEmpty) {
        cameraInfo = 'No available cameras';
      } else {
        _allavailablecameras = availablecameras;
        update();
      }
    } on PlatformException catch (e) {
      cameraInfo = 'Failed to get cameras: ${e.code}: ${e.message}';
    }
  }

  void _onCameraError(CameraErrorEvent event) {
    // Dispose camera on camera error as it can not be used anymore.
    disposeCurrentCamera();
    _fetchCameras();
  }

  void _onCameraClosing(CameraClosingEvent event) {}

  /// Initializes the camera on the device.
  Future<void> initializeCamera(
      {required bool isfront,
      required bool isback,
      required bool isprofilecam}) async {
    int cameraIndex = 0;

    _isFrontcapturebuttonpress = isfront
        ? isfront
        : isprofilecam
            ? true
            : false;
    _isBackcapturebuttonpress = isback;

    if (isFrontcapturebuttonpress) {
      assert(!isinitialized);
      print("isinitialized " + isinitialized.toString());
      if (_allavailablecameras.isEmpty) {
        return;
      }

      int cameraId = -1;
      try {
        if (isprofilecam) {
          cameraIndex = _allavailablecameras.indexWhere((ele) =>
              ele.name.toString().toLowerCase().contains('webcam') ||
              ele.name.toString().toLowerCase().contains('logi') ||
              ele.name.toString().toLowerCase().contains('integrated camera'));
          update();
        } else {
          cameraIndex = _allavailablecameras.indexWhere(
              (ele) => ele.name.toString().toLowerCase().contains('czur'));
          update();
        }

        final CameraDescription camera = _allavailablecameras[cameraIndex];

        cameraId = await CameraPlatform.instance.createCameraWithSettings(
          camera,
          _mediaSettings,
        );

        unawaited(_errorStreamSubscription?.cancel());
        _errorStreamSubscription = CameraPlatform.instance
            .onCameraError(cameraId)
            .listen(_onCameraError);

        unawaited(_cameraClosingStreamSubscription?.cancel());
        _cameraClosingStreamSubscription = CameraPlatform.instance
            .onCameraClosing(cameraId)
            .listen(_onCameraClosing);

        final Future<CameraInitializedEvent> initialized =
            CameraPlatform.instance.onCameraInitialized(cameraId).first;

        await CameraPlatform.instance.initializeCamera(
          cameraId,
        );

        final CameraInitializedEvent event = await initialized;
        _previewSize = Size(
          event.previewWidth,
          event.previewHeight,
        );

        _isinitialized = true;
        _cameraId = cameraId;
        _iscamerashown = true;
        _cameraIndex = cameraIndex;
        update();
      } on CameraException catch (e) {
        try {
          if (cameraId >= 0) {
            await CameraPlatform.instance.dispose(cameraId);
          }
        } on CameraException catch (e) {
          debugPrint('Failed to dispose camera: ${e.code}: ${e.description}');
        }

        // Reset state.

        _isinitialized = false;
        _iscamerashown = false;
        _cameraId = -1;
        _cameraIndex = 0;
        _previewSize = null;
        update();
      }
    }
  }

  Future<void> disposeCurrentCamera() async {
    if (_cameraId >= 0 && isinitialized) {
      try {
        await CameraPlatform.instance.dispose(_cameraId);

        _frontImage = null;
        _backImage = null;
        _isFrontcapturebuttonpress = false;
        _isBackcapturebuttonpress = false;
        _isinitialized = false;
        _iscamerashown = false;
        _cameraId = -1;
        _previewSize = null;
        update();
      } on CameraException catch (e) {}
    }
  }

  Future<void> takePicture() async {
    final XFile file = await CameraPlatform.instance.takePicture(_cameraId);

    if (isFrontcapturebuttonpress) {
      _frontImage = file;
      update();
    } else {
      _backImage = file;
      update();
    }
  }

  Widget buildPreview() {
    return CameraPlatform.instance.buildPreview(_cameraId);
  }

  void setnavindex({required int navin}) {
    _navindex = navin;
    update();
  }
}
