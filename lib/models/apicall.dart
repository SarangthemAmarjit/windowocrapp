import 'dart:typed_data';

import 'package:camera_windows_example/models/gate.dart';
import 'package:camera_windows_example/models/ilpmodel.dart';

import 'paymentresponse.dart';
import 'permit.dart';
import 'permitprice.dart';

abstract class ApiCall {
  Future<void> readPermit();
  Future<List<String>> getDocumentType();
  Future<List<Gate>> getAllGates();
  Future<Map<String, dynamic>> addPermit(Uint8List passportPhotoBytes,
      Uint8List idCardBytes, Uint8List signPhoto, VisitorEntry permit);
  Future<Map<String, dynamic>> detectFaces(Uint8List profileImage);

  Future<List<PermitPriceModel>> getallpremitprice();
  Future<Map<String, IlPmodel?>> fetchPermitData(String permitnum);
  Future<String> verifydoc({required String doctype, required String idnumber});
  Future<PaymentResponse?> sendPayment(Payment payment);
}
