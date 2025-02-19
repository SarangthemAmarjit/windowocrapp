import 'dart:typed_data';

import 'package:camera_windows_example/models/gate.dart';

import 'permit.dart';

abstract class ApiCall {
  Future<void> readPermit();
  Future<List<String>> getDocumentType();
  Future<List<Gate>> getAllGates();
  Future<Map<String,dynamic>> addPermit( Uint8List passportPhotoBytes, Uint8List idCardBytes,
  // {required String idProofs,
  //     required String idno,
  //     required String purposeVisits,
  //     required String placestay,
  //     required String visitDates,
  //     required String name,
  //     required String parentname,
  //     required String gender,
  //     required String dob,
  //     required String email,
  //     required String mobile,
  //     required String address,
  //     required String state,
  //     required String polstation,
  //     required String district,
  //     required String village,
  //     required String tehsl,
  //     required String applydistrict,
  //     required String pincode}
  VisitorEntry permit
      );
  Future<Map<String,dynamic>> detectFaces(Uint8List profileImage);

  Future<String> getallpremitprice();
}
