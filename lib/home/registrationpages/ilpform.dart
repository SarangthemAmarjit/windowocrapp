import 'dart:async';
import 'dart:developer';

import 'package:camera_platform_interface/camera_platform_interface.dart';
import 'package:camera_windows_example/controller/pagecontroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

class TemporaryILPForm extends StatefulWidget {
  const TemporaryILPForm({super.key});

  @override
  State<TemporaryILPForm> createState() => _TemporaryILPFormState();
}

class _TemporaryILPFormState extends State<TemporaryILPForm> {
  final _nameController = TextEditingController();
  final _parentNameController = TextEditingController();
  final _idNoController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();
  final _placeStayController = TextEditingController();
  final _visitPurposeController = TextEditingController();
  final _nearestpliceController = TextEditingController();
  final _villageController = TextEditingController();
  final _tehsilController = TextEditingController();
  final List<String> cardTypes = ['Aadhar', 'PAN', 'Voter', 'Driving Licence'];
  String? selectedCardType;
  XFile? profileimage;

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
  DateTime? _fromDate;
  DateTime? _dob;
  String? _selectedIdProof;
  String? _selectedPurpose;
  String? _selectedGate;
  String? _selectedState;
  String? _selectedDistrict;
  String? _selectedPoliceStation;
  String? _selectedGender;

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

  final List<String> idProofs = [
    'Aadhaar',
    'Voter ID',
    'Driving License',
    'Passport'
  ];
  final List<String> purposes = ['Business', 'Tourism', 'Medical', 'Other'];
  final List<String> gates = ['Imphal Gate', 'Mao Gate', 'Moreh Gate'];
  final List<String> states = ['Manipur', 'Assam', 'Nagaland', 'Other'];
  final List<String> genders = ['Male', 'Female', 'Others'];

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
          log(_cameras[0].name);
          setState(() {
            cameraIndex = _cameras.indexWhere((ele) =>
                ele.name.toString().toLowerCase().contains('webcam') ||
                ele.name.toString().toLowerCase().contains('logi') ||
                ele.name
                    .toString()
                    .toLowerCase()
                    .contains('integrated camera'));
          });
          log("cameraIndex :" + cameraIndex.toString());
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
          _showCameraDialog(context);
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

  void _onCameraError(CameraErrorEvent event) {
    if (mounted) {
      _scaffoldMessengerKey.currentState?.showSnackBar(
          SnackBar(content: Text('Error: ${event.description}')));

      // Dispose camera on camera error as it can not be used anymore.
      _disposeCurrentCamera();
      _fetchCameras();
    }
  }

  void _showInSnackBar(String message) {
    _scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 1),
    ));
  }

  void _onCameraClosing(CameraClosingEvent event) {
    if (mounted) {
      _showInSnackBar('Camera is closing');
    }
  }

  Future<void> _disposeCurrentCamera() async {
    if (_cameraId >= 0 && isinitialized) {
      try {
        await CameraPlatform.instance.dispose(_cameraId);

        if (mounted) {
          setState(() {
            profileimage = null;

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
      profileimage = file;
    });
  }

  Widget _buildPreview() {
    return CameraPlatform.instance.buildPreview(_cameraId);
  }

  void _showCameraDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                constraints: const BoxConstraints(
                  maxHeight: 250,
                ),
                child: Transform.flip(
                  flipX: true,
                  child: AspectRatio(
                    aspectRatio: _previewSize!.width / _previewSize!.height,
                    child: _buildPreview(),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {
                           _disposeCurrentCamera();
                      Navigator.pop(context);
                    },
                    child: Text("Cancel"),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      // if (_cameraController != null && _cameraController!.value.isInitialized) {
                      //   final image = await _cameraController!.takePicture();
                      //   Navigator.pop(context, image.path); // Return the captured image path
                      // }
                    },
                    child: Text("Capture"),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PageControllers>(builder: (controller) {
      return SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () {
                        _initializeCamera(
                            isfront: false, isback: false, isprofilecam: true);
                      },
                      child: Container(
                        height: 130,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey[700]!,
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add_a_photo_rounded),
                              SizedBox(
                                height: 16,
                              ),
                              Text("Capture a Profile Photo")
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        _buildTextField('Applicant Name', _nameController),
                        _buildTextField(
                            'Parent/Guardian Name', _parentNameController),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: _buildDropdownField(
                        'ID Proof', idProofs, _selectedIdProof, (value) {
                      setState(() {
                        _selectedIdProof = value;
                      });
                    }),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(child: _buildTextField('ID No.', _idNoController)),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: _buildTextField('Email', _emailController,
                        validator: _emailValidator),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: _buildTextField('Mobile No.', _mobileController,
                        validator: _phoneValidator),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: _buildDateField('Period of Stay (From)', _fromDate,
                        (value) {
                      setState(() {
                        _fromDate = value;
                      });
                    }),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                      child: _buildTextField(
                          'Place of Stay in Manipur', _placeStayController)),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: _buildDropdownField(
                        'Purpose of Visit', purposes, _selectedPurpose,
                        (value) {
                      setState(() {
                        _selectedPurpose = value;
                      });
                    }),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                      child: _buildTextField(
                          'Purpose (if other)', _visitPurposeController)),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: _buildDateField('Date of Birth', _dob, (value) {
                      setState(() {
                        _dob = value;
                      });
                    }),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: _buildRadioGroup('Gender', genders, _selectedGender,
                        (value) {
                      setState(() {
                        _selectedGender = value;
                      });
                    }),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: _buildDropdownField('State', states, _selectedState,
                        (value) {
                      setState(() {
                        _selectedState = value;
                      });
                    }),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                      child: _buildTextField('District', _villageController)),
                ],
              ),
              _buildTextField('Village/Street', _villageController),
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                        'Nearest Police Station', _nearestpliceController),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(child: _buildTextField('Tehsil', _tehsilController)),
                ],
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () {
                  controller.changePage(2);
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(8)),
                  clipBehavior: Clip.antiAlias,
                  child: Center(
                      child: Text(
                    "Next",
                    style: TextStyle(color: Colors.white),
                  )),
                ),
              ),
            ],
          ).animate().fadeIn(duration: const Duration(milliseconds: 500)),
        ),
      );
    });
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {String? Function(String?)? validator}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
        validator: validator,
      ),
    );
  }

  Widget _buildDropdownField(String label, List<String> items,
      String? selectedValue, ValueChanged<String?> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            isDense: true,
            value: selectedValue,
            isExpanded: false,
            onChanged: onChanged,
            items: items
                .map((item) => DropdownMenuItem(value: item, child: Text(item)))
                .toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildDateField(String label, DateTime? selectedDate,
      ValueChanged<DateTime?> onDateSelected) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: () async {
          DateTime? date = await showDatePicker(
            context: context,
            initialDate: selectedDate ?? DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime.now().add(const Duration(days: 365)),
          );
          if (date != null) {
            onDateSelected(date);
          }
        },
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: label,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: Text(selectedDate != null
              ? '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}'
              : 'Select Date'),
        ),
      ),
    );
  }

  Widget _buildRadioGroup(String label, List<String> options,
      String? selectedValue, ValueChanged<String?> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Row(
            children: options
                .map((option) => Expanded(
                      child: RadioListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(option),
                        value: option,
                        groupValue: selectedValue,
                        onChanged: onChanged,
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  String? _emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email cannot be empty';
    }
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}\$');
    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  String? _phoneValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Mobile number cannot be empty';
    }
    final phoneRegex = RegExp(r'^\d{10}\$');
    if (!phoneRegex.hasMatch(value)) {
      return 'Enter a valid 10-digit mobile number';
    }
    return null;
  }
}
