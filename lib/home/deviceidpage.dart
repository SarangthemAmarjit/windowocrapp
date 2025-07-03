import 'dart:io';

import 'package:camera_windows_example/controller/managementcontroller.dart';
import 'package:camera_windows_example/home/registrationpages/ilpformreplica.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/customkeys.dart';

class ConfigSaverWidget extends StatefulWidget {
  const ConfigSaverWidget({super.key});

  @override
  State<ConfigSaverWidget> createState() => _ConfigSaverWidgetState();
}

class _ConfigSaverWidgetState extends State<ConfigSaverWidget> {
  final TextEditingController _deviceIdController = TextEditingController();
  final TextEditingController _gateIdController = TextEditingController();

  Map<String, TextEditingController>? controllers;

  final _focusNodes = {
    'deviceid': FocusNode(),
    'gateid': FocusNode(),
    // 'idNo': FocusNode(),
    // 'email': FocusNode(),
    // 'mobile': FocusNode(),
    // 'placeStay': FocusNode(),
    // 'visitPurpose': FocusNode(),
    // 'nearestPolice': FocusNode(),
    // 'village': FocusNode(),
    // 'district': FocusNode(),
    // 'tehsil': FocusNode(),
    // 'localPincode': FocusNode(),
    // 'localPoliceStation': FocusNode(),
    // 'localResidenceName': FocusNode(),
  };

  late final Future<void> _loadFuture;

  @override
  void initState() {
    super.initState();
    _loadFuture = _loadConfig();
  }

  @override
  void dispose() {
    _deviceIdController.dispose();
    _gateIdController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  Future<String> _getFilePath() async {
    return '${Directory.current.path}/config.txt';
  }

  Future<void> _saveToFile() async {
    final deviceId = _deviceIdController.text.trim();
    final gateId = _gateIdController.text.trim();

    if (deviceId.isEmpty || gateId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter both fields.')),
      );
      return;
    }

    try {
      final path = await _getFilePath();
      final file = File(path);
      final content = 'device_id=$deviceId\ngate_id=$gateId';
      await file.writeAsString(content);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Configuration saved at $path')),
      );
      await Get.find<Managementcontroller>().loadDeviceConfig();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving file: $e')),
      );
    }
  }

  Future<void> _loadConfig() async {
    try {
      final path = await _getFilePath();
      final file = File(path);

      if (await file.exists()) {
        final lines = await file.readAsLines();

        for (var line in lines) {
          if (line.startsWith('device_id=')) {
            _deviceIdController.text = line.split('=')[1];
          } else if (line.startsWith('gate_id=')) {
            _gateIdController.text = line.split('=')[1];
          }
        }
      }
    } catch (e) {
      debugPrint('Error loading config: $e');
    }
  }

  void _onKeyTap(String key) {
    if (_activeField != null && controllers != null) {
      if (_activeField == 'email') {
        controllers![_activeField]!.text += key;
      } else {
        String d = controllers?[_activeField]?.text ?? "";
        d += key;
        controllers![_activeField]!.text = d.capitalize!;
      }
    }
  }

  void _onBackspace() {
    if (_activeField != null && controllers != null) {
      final controller = controllers![_activeField]!;
      if (controller.text.isNotEmpty) {
        controller.text = controller.text.substring(0, controller.text.length - 1);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loadFuture,
      builder: (context, snapshot) {
        return Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 600, minHeight: 400),
            child: Container(
              padding: EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('First Time Installation'),
                    SizedBox(
                      height: 16,
                    ),
                    Text('Please enter configuration file'),
                    TextFieldWidget(
                      controller: _deviceIdController,
                      label: 'Device ID',
                    ),
                    TextFieldWidget(
                      controller: _gateIdController,
                      label: 'Gate ID',
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: _saveToFile,
                      child: Center(child: const Text('Save Config')),
                    ),
                    CustomKeyboard(
                      onKeyTap: _onKeyTap,
                      onBackspace: _onBackspace,
                      onToggle: _toggleKeyboard,
                      isAlpha: !isKeyboardnum,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
