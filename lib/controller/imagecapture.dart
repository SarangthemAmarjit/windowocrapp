import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:uuid/uuid.dart';
import 'package:camera_platform_interface/camera_platform_interface.dart';
import 'package:crop_image/crop_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as img;

class Imagecontroller extends GetxController {
  Size? _previewSize;
  Size? get previewsize => _previewSize;

  int? _navindex;
  int? get navindex => _navindex;

  String? selectedCardType;

  XFile? _frontImage;
  XFile? get frontimage => _frontImage;

  XFile? _profileimage;
  XFile? get profileimage => _profileimage;

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
  final crcontroller = CropController(
    aspectRatio: 0.9,
    defaultCrop: const Rect.fromLTRB(0.1, 0.1, 0.9, 0.9),
  );
  void showProfileCameraDialog() {
    Get.dialog(
      AlertDialog(
        contentPadding: EdgeInsets.zero,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              constraints: const BoxConstraints(maxHeight: 250),
              child: AspectRatio(
                aspectRatio: 7 / 9, // Passport photo ratio
                child: Center(
                  child: ClipRect(
                    child: OverflowBox(
                      alignment: Alignment.center,
                      maxWidth: 400,
                      maxHeight: 600,
                      child: FittedBox(
                        fit: BoxFit
                            .fill, // Ensure it covers the entire aspect ratio
                        child: SizedBox(
                          width: _previewSize!.width,
                          height: _previewSize!.height,
                          child: buildPreview(), // Your camera preview
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    disposeCurrentCamera();
                    Get.back(); // Close the dialog
                  },
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      // Capture the image using the camera
                      final XFile file =
                          await CameraPlatform.instance.takePicture(_cameraId);

                      // Load the captured image as a File object
                      final imageFile = File(file.path);

                      // Crop the image based on aspectRatio and defaultCrop
                      final croppedFile = await cropImageWithAspectRatio(
                        imageFile,
                        aspectRatio: 0.9,
                        defaultCrop: const Rect.fromLTRB(0.3, 0.1, 0.9, 0.9),
                      );

                      updateProfileImage(XFile(croppedFile.path));
                      disposeCurrentCamera();
                      Get.back(); // Close the dialog
                      log('done capture');
                    } catch (e) {
                      // Handle any errors
                      print("Error capturing or cropping image: $e");
                    }
                  },
                  child: const Text("Capture"),
                ),
              ],
            ),
          ],
        ),
      ),
      barrierDismissible:
          false, // Prevent the dialog from closing when tapping outside
    );
  }

  // Update profile image method
  void updateProfileImage(XFile file) {
    _profileimage = file;
    update();
  }

  /// Initializes the camera on the device.
  Future<void> initializeCamera(
      {required bool isfront,
      required bool isback,
      required bool isprofilecam,
      required BuildContext context}) async {
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

// Adjust the preview size to match the passport photo aspect ratio (7:9)
        _previewSize = Size(event.previewWidth, event.previewWidth
            // Adjust height based on the 7:9 aspect ratio
            );

        _isinitialized = true;
        _cameraId = cameraId;
        _iscamerashown = true;
        _cameraIndex = cameraIndex;
        _profileimage = null;
        update();
        if (isprofilecam) {
          showProfileCameraDialog();
        }
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

  Future<File> cropImageWithAspectRatio(
    File imageFile, {
    required double aspectRatio,
    required Rect defaultCrop,
  }) async {
    // Read the image as bytes
    final bytes = await imageFile.readAsBytes();

    // Decode the image using the `image` package
    final originalImage = img.decodeImage(bytes);

    if (originalImage != null) {
      // Get image dimensions
      final imageWidth = originalImage.width;
      final imageHeight = originalImage.height;

      // Calculate cropping rectangle based on `defaultCrop`
      final int x = (defaultCrop.left * imageWidth).toInt();
      final int y = (defaultCrop.top * imageHeight).toInt();
      final int cropWidth =
          ((defaultCrop.right - defaultCrop.left) * imageWidth).toInt();
      final int cropHeight =
          ((defaultCrop.bottom - defaultCrop.top) * imageHeight).toInt();

      // Ensure the crop respects the aspect ratio
      final int adjustedCropHeight = (cropWidth / aspectRatio).toInt();
      final int adjustedCropWidth = (cropHeight * aspectRatio).toInt();

      // Adjust the final crop dimensions
      final finalWidth =
          cropWidth < adjustedCropWidth ? cropWidth : adjustedCropWidth;
      final finalHeight =
          cropHeight < adjustedCropHeight ? cropHeight : adjustedCropHeight;

      // Crop the image
      final cropped = img.copyCrop(originalImage,
          x: x, y: y, width: finalWidth, height: finalHeight);

      // Encode the cropped image back to PNG or JPG
      final croppedBytes = img.encodePng(cropped);

// Generate a unique file name
      final uniqueFileName =
          'cropped_image_${Uuid().v4()}.png'; // Using UUID for uniqueness
      final tempDir = Directory.systemTemp;
      final croppedFilePath = '${tempDir.path}/$uniqueFileName';
      final croppedFile = File(croppedFilePath);

// Save the cropped image to the unique file path
      await croppedFile.writeAsBytes(croppedBytes);

// You can now use `croppedFile.path` for further operations

      return croppedFile;
    } else {
      throw Exception("Failed to decode image.");
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

  Future<void> takeprofilePicture() async {
    final XFile file = await CameraPlatform.instance.takePicture(_cameraId);

    _profileimage = file;
    update();
  }

  Widget buildPreview() {
    return CameraPlatform.instance.buildPreview(_cameraId);
  }

  void setnavindex({required int navin}) {
    _navindex = navin;
    update();
  }
}
