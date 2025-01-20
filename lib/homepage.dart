import 'dart:async';
import 'dart:io';
import 'package:camera_platform_interface/camera_platform_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

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
  bool isFrontcapture = false;
  MediaSettings _mediaSettings = const MediaSettings(
    resolutionPreset: ResolutionPreset.low,
    fps: 15,
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
      if (cameras.isEmpty) {
        cameraInfo = 'No available cameras';
      } else {
        cameraIndex = _cameraIndex % cameras.length;
        cameraInfo = 'Found camera: ${cameras[cameraIndex].name}';
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

  /// Initializes the camera on the device.
  Future<void> _initializeCamera({required bool isfront}) async {
    setState(() {
      isFrontcapture = isfront;
    });
    if (isFrontcapture) {
      assert(!isinitialized);
      print(isinitialized.toString());
      if (_cameras.isEmpty) {
        return;
      }

      int cameraId = -1;
      try {
        final int cameraIndex = _cameraIndex % _cameras.length;
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
      if (isFrontcapture) {
        frontImage = file;
      } else {
        backImage = file;
      }
    });
  }

  Widget _buildPreview() {
    return CameraPlatform.instance.buildPreview(_cameraId);
  }

  Future<void> captureImage(bool isFront) async {
    final image = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (isFront) {
        frontImage = image;
      } else {
        backImage = image;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ID Card Scanning')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Dropdown for selecting ID card type
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Choose ID Card Type',
                border: OutlineInputBorder(),
              ),
              items: cardTypes.map((String cardType) {
                return DropdownMenuItem<String>(
                  value: cardType,
                  child: Text(cardType),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedCardType = newValue;
                });
              },
              value: selectedCardType,
            ),
            SizedBox(height: 100),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _initializeCamera(isfront: true);
                      },
                      child: Text('Capture Front Side'),
                    ),
                    SizedBox(height: 20),

                    // Capture back side of the ID card

                    ElevatedButton(
                      onPressed: () {
                        _initializeCamera(isfront: false);
                      },
                      child: Text('Capture Back Side'),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
                Container(
                  constraints:
                      const BoxConstraints(maxHeight: 400, maxWidth: 600),
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
                                Padding(
                                  padding: const EdgeInsets.only(left: 30),
                                  child: Text(
                                    isFrontcapture
                                        ? 'Place the front side of the ID card within the frame.'
                                        : 'Flip the card and place the back side within the frame.',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                  ),
                                  child: Align(
                                    child: Container(
                                      constraints: const BoxConstraints(
                                        maxHeight: 300,
                                      ),
                                      child: AspectRatio(
                                        aspectRatio: _previewSize!.width /
                                            _previewSize!.height,
                                        child: _buildPreview(),
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
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
                                )
                              ],
                            )
                          : Center(child: Text('Camera Preview Area'))
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    frontImage != null
                        ? Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all()),
                            constraints: const BoxConstraints(maxHeight: 160),
                            child: Center(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(
                                  File(frontImage!.path),
                                ),
                              ),
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all()),
                            constraints: const BoxConstraints(
                                maxHeight: 160, maxWidth: 300),
                          ),
                    SizedBox(
                      height: 40,
                    ),
                    backImage != null
                        ? Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all()),
                            constraints: const BoxConstraints(maxHeight: 160),
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
                            constraints: const BoxConstraints(
                                maxHeight: 160, maxWidth: 300),
                          ),
                  ],
                )
              ],
            ), // Capture front side of the ID card

            // Proceed button
            ElevatedButton(
              onPressed: selectedCardType != null &&
                      frontImage != null &&
                      backImage != null
                  ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AutoFillFormScreen(
                            frontImage: frontImage!,
                            backImage: backImage!,
                          ),
                        ),
                      );
                    }
                  : null,
              child: Text('Proceed'),
            ),
          ],
        ),
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
