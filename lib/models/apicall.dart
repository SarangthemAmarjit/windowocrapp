import 'dart:typed_data';

import 'permit.dart';

abstract class ApiCall{

  Future<void> readPermit();
  Future<Map<String,dynamic>> addPermit(VisitorEntry permit, Uint8List passportPhotoBytes, Uint8List idCardBytes);
  Future<Map<String,dynamic>> detectFaces(Uint8List profileImage);

}