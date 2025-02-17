import 'dart:typed_data';

import 'package:camera_windows_example/models/gate.dart';

import 'permit.dart';

abstract class ApiCall {
  Future<void> readPermit();
  Future<List<String>> getDocumentType();
  Future<List<Gate>> getAllGates();
  Future<Map<String,dynamic>> addPermit(VisitorEntry permit, Uint8List passportPhotoBytes, Uint8List idCardBytes);
  Future<Map<String,dynamic>> detectFaces(Uint8List profileImage);

  Future<String> getallpremitprice();
}
