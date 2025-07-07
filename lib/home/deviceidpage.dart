import 'dart:io';

import 'package:camera_windows_example/controller/managementcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfigSaverWidget extends StatefulWidget {
  const ConfigSaverWidget({super.key});

  @override
  State<ConfigSaverWidget> createState() => _ConfigSaverWidgetState();
}

class _ConfigSaverWidgetState extends State<ConfigSaverWidget> {
  final TextEditingController _deviceIdController = TextEditingController();
  final TextEditingController _printercontroller = TextEditingController();
  final TextEditingController _apicontroller = TextEditingController();
  String gateId = "";
  String gatename = "";
  late final Future<void> _loadFuture;

  @override
  void initState() {
    super.initState();
    _loadFuture = _loadConfig();
  }

  @override
  void dispose() {
    _deviceIdController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  Future<String> _getFilePath() async {
    return '${Directory.current.path}/config.txt';
  }

  Future<void> _saveToFile() async {
    final deviceId = _deviceIdController.text.trim();
    final printer = _printercontroller.text.trim();
    final baseurl = _apicontroller.text.trim();

    if (deviceId.isEmpty || gateId.isEmpty || printer.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter all fields.')),
      );
      return;
    }

    try {
      final path = await _getFilePath();
      final file = File(path);
      final content = 'device_id=$deviceId\ngate_id=$gateId\nilpapi=$baseurl\nprinter=$printer';
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
            gateId = line.split('=')[1];
          }
        }
      }
    } catch (e) {
      debugPrint('Error loading config: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Managementcontroller>(builder: (mngctrl) {
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
                      Row(
                        children: [
                          Icon(Icons.install_desktop),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            'First Time Installation',
                            style: TextTheme.of(context)
                                .bodyLarge
                                ?.copyWith(fontWeight: FontWeight.bold, fontSize: 24),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        'Before continuing the application please set Device Id and Gate Id for the application.\n  > Device ID must be unique for all kiosk devices.\n  > Gate Id is the unique Id assign to each ILP Gates.',
                        style: TextTheme.of(context).bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold, fontSize: 16, color: Colors.grey[600]),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        'Please enter configuration file'.capitalize!,
                        style: TextTheme.of(context).bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold, fontSize: 16, color: Colors.grey),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Enter Device Id'),
                                TextField(
                                  controller: _deviceIdController,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Select Gate "),
                                SizedBox(
                                  height: 8,
                                ),
                                DropdownButton(
                                  hint: Text(gatename),
                                  items: mngctrl.getAllgate
                                      .map((e) => DropdownMenuItem(
                                            value: e,
                                            child: Text(e.name),
                                          ))
                                      .toList(),
                                  onChanged: (v) {
                                    setState(() {
                                      gateId = v!.id;
                                      gatename = v.name;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Printer Name "),
                          TextField(
                            controller: _printercontroller,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: _saveToFile,
                        child: Center(child: const Text('Save & Continue')),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    });
  }
}
