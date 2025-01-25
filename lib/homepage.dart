import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:camera_platform_interface/camera_platform_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_ocr_sdk/flutter_ocr_sdk.dart';

class IdSelectionAndScanningScreen extends StatefulWidget {
  @override
  _IdSelectionAndScanningScreenState createState() =>
      _IdSelectionAndScanningScreenState();
}

class _IdSelectionAndScanningScreenState
    extends State<IdSelectionAndScanningScreen> {
  final List<String> cardTypes = ['Aadhar', 'PAN', 'Voter', 'Driving Licence'];
  String? selectedCardType;
  XFile? frontImage;
  XFile? backImage;
  final ImagePicker picker = ImagePicker();
  FlutterOcrSdk detector = FlutterOcrSdk();
  String _cameraInfo = 'Unknown';
  List<CameraDescription> _cameras = <CameraDescription>[];
  int _cameraIndex = 0;
  int _cameraId = -1;
  bool isinitialized = false;
  bool iscamerashown = false;
  bool _recording = false;
  bool _recordingTimed = false;
  bool _previewPaused = false;
  Size? _previewSize;
  bool isFrontcapturebuttonpress = false;
  bool isBackcapturebuttonpress = false;
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
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    _fetchCameras();
  }

  @override
  void dispose() {
    _disposeCurrentCamera();
    _errorStreamSubscription?.cancel();
    _errorStreamSubscription = null;
    _cameraClosingStreamSubscription?.cancel();
    _cameraClosingStreamSubscription = null;
    super.dispose();
  }

  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  /// Fetches list of available cameras from camera_windows plugin.
  Future<void> _fetchCameras() async {
    String cameraInfo;
    List<CameraDescription> cameras = <CameraDescription>[];

    int cameraIndex = 0;
    try {
      cameras = await CameraPlatform.instance.availableCameras();
      log("All Cameras : " + cameras.toString());
      if (cameras.isEmpty) {
        cameraInfo = 'No available cameras';
      } else {
        cameraIndex = _cameraIndex % cameras.length;
        cameraInfo = 'Found camera: ${cameras[1].name}';
      }
    } on PlatformException catch (e) {
      cameraInfo = 'Failed to get cameras: ${e.code}: ${e.message}';
    }

    if (mounted) {
      setState(() {
        _cameraIndex = cameraIndex;
        _cameras = cameras;
        _cameraInfo = cameraInfo;
      });
    }
  }

  void _showInSnackBar(String message) {
    _scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 1),
    ));
  }

  void _onCameraError(CameraErrorEvent event) {
    if (mounted) {
      _scaffoldMessengerKey.currentState?.showSnackBar(
          SnackBar(content: Text('Error: ${event.description}')));

      // Dispose camera on camera error as it can not be used anymore.
      _disposeCurrentCamera();
      _fetchCameras();
    }
  }

  void _onCameraClosing(CameraClosingEvent event) {
    if (mounted) {
      _showInSnackBar('Camera is closing');
    }
  }

  Future<void> _initialize(
      {required bool isfront,
      required bool isback,
      required bool isprofilecam}) async {}

  /// Initializes the camera on the device.
  Future<void> _initializeCamera(
      {required bool isfront,
      required bool isback,
      required bool isprofilecam}) async {
    int cameraIndex = 0;
    setState(() {
      isFrontcapturebuttonpress = isfront
          ? isfront
          : isprofilecam
              ? true
              : false;
      isBackcapturebuttonpress = isback;
    });
    if (isFrontcapturebuttonpress) {
      assert(!isinitialized);
      print("isinitialized " + isinitialized.toString());
      if (_cameras.isEmpty) {
        return;
      }

      int cameraId = -1;
      try {
        if (isprofilecam) {
          setState(() {
            cameraIndex = _cameras.indexWhere((ele) =>
                ele.name.toString().toLowerCase().contains('webcam') ||
                ele.name.toString().toLowerCase().contains('logi'));
          });
        } else {
          setState(() {
            cameraIndex = _cameras.indexWhere(
                (ele) => ele.name.toString().toLowerCase().contains('czur'));
          });
        }

        final CameraDescription camera = _cameras[cameraIndex];

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

        if (mounted) {
          setState(() {
            isinitialized = true;
            _cameraId = cameraId;
            iscamerashown = true;
            _cameraIndex = cameraIndex;
            _cameraInfo = 'Capturing camera: ${camera.name}';
          });
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
        if (mounted) {
          setState(() {
            isinitialized = false;
            iscamerashown = false;
            _cameraId = -1;
            _cameraIndex = 0;
            _previewSize = null;
            _recording = false;
            _recordingTimed = false;
            _cameraInfo =
                'Failed to initialize camera: ${e.code}: ${e.description}';
          });
        }
      }
    }
  }

  Future<void> _disposeCurrentCamera() async {
    if (_cameraId >= 0 && isinitialized) {
      try {
        await CameraPlatform.instance.dispose(_cameraId);

        if (mounted) {
          setState(() {
            frontImage = null;
            backImage = null;
            isFrontcapturebuttonpress = false;
            isBackcapturebuttonpress = false;
            isinitialized = false;
            iscamerashown = false;
            _cameraId = -1;
            _previewSize = null;
            _recording = false;
            _recordingTimed = false;
            _previewPaused = false;
            _cameraInfo = 'Camera disposed';
          });
        }
      } on CameraException catch (e) {
        if (mounted) {
          setState(() {
            _cameraInfo =
                'Failed to dispose camera: ${e.code}: ${e.description}';
          });
        }
      }
    }
  }

  Future<void> _takePicture() async {
    final XFile file = await CameraPlatform.instance.takePicture(_cameraId);
    setState(() {
      if (isFrontcapturebuttonpress) {
        frontImage = file;
      } else {
        backImage = file;
      }
    });
    var dn = await detector.recognizeByFile(frontImage!.path);
    log(dn.toString());
  }

  Widget _buildPreview() {
    return CameraPlatform.instance.buildPreview(_cameraId);
  }

  @override
  Widget build(BuildContext context) {
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
                          isFrontcapturebuttonpress
                              ? const Color.fromARGB(255, 216, 236, 217)
                              : Colors.white)),
                  onPressed: () {
                    _initializeCamera(
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
                          isBackcapturebuttonpress
                              ? const Color.fromARGB(255, 216, 236, 217)
                              : Colors.white)),
                  onPressed: () {
                    _initializeCamera(
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
                          isBackcapturebuttonpress
                              ? const Color.fromARGB(255, 216, 236, 217)
                              : Colors.white)),
                  onPressed: () {
                    _initializeCamera(
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
              constraints: iscamerashown
                  ? null
                  : const BoxConstraints(maxHeight: 250, maxWidth: 500),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all()),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iscamerashown
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            iscamerashown
                                ? Padding(
                                    padding: const EdgeInsets.only(left: 30),
                                    child: Center(
                                      child: Text(
                                        isFrontcapturebuttonpress
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
                                      aspectRatio: _previewSize!.width /
                                          _previewSize!.height,
                                      child: _buildPreview(),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 50, bottom: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      _disposeCurrentCamera();
                                    },
                                    child: Text('Cancel'),
                                  ),
                                  const SizedBox(width: 5),
                                  ElevatedButton(
                                    onPressed: () {
                                      _takePicture();
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
              frontImage != null
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
                            File(frontImage!.path),
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
              backImage != null
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
                            File(backImage!.path),
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
