import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:camera_windows_example/cons/apis.dart';
import 'package:camera_windows_example/models/aadharotpresponse.dart';
import 'package:camera_windows_example/models/aadharverificationresult.dart';
import 'package:camera_windows_example/models/gate.dart';
import 'package:camera_windows_example/models/ilpmodel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'apicall.dart';
import 'paymentresponse.dart';
import 'permit.dart';
import 'permitprice.dart';
import 'permitverifymodel.dart';

class ApicallImpl extends ApiCall {
  static const String baseUrl =
      "https://jsonplaceholder.typicode.com/posts"; // Replace with your API URL
  final String key = "KJBSDLFJHOGHDFJKSJBVKJBZCVB354S3F4VKJKJSDCV654SDV";
  @override
  Future<void> readPermit() async {
    final response = await http.get(Uri.parse(baseUrl));
    debugPrint("In response");
    if (response.statusCode == 200) {
      debugPrint(response.body);
      return jsonDecode(response.body); // Parsing JSON
    } else {
      throw Exception("Failed to load data");
    }
  }

  @override
  Future<Map<String, dynamic>> addPermit(Uint8List passportPhotoBytes,
      Uint8List idCardBytes, Uint8List SignPhoto, VisitorEntry permit) async {
    var headers = {
      'X-Key': key,
    };

    var request =
        http.MultipartRequest('POST', Uri.parse('$localapi/api/Kiosk/submit'));

    debugPrint(
        "Permit in apicallfinctions post :\n\n ${permit.toJson().toString()}");

    request.fields.addAll(permit.toJson());

    request.files.add(http.MultipartFile.fromBytes(
        'PassportPhoto', passportPhotoBytes,
        filename: 'passportPhoto.jpg'));
    request.files.add(http.MultipartFile.fromBytes('IdCard', idCardBytes,
        filename: 'idCard.jpg'));
    request.files.add(http.MultipartFile.fromBytes('SignPhoto', SignPhoto,
        filename: 'signature.jpg'));

    // Adding headers
    request.headers.addAll(headers);

    try {
      // Sending the request
      http.StreamedResponse response = await request.send();

      // Handling the response
      if (response.statusCode == 200) {
        var json = jsonDecode(await response.stream.bytesToString());
        String? applicant = json["applicationId"];
        return json;
      } else {
        debugPrint("${response.reasonPhrase} ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Error in addPermit: $e");
    }
    return {"Failed": 0};
  }

  @override
  Future<Map<String, dynamic>> updatePermit(
      Uint8List passportPhotoBytes,
      Uint8List idCardBytes,
      Uint8List SignPhoto,
      VisitorEntry permit,
      String applicantNo) async {
    var headers = {
      'X-Key': key,
    };

    var request = http.MultipartRequest(
        'POST', Uri.parse('$localapi/api/Kiosk/update?appno=${applicantNo}'));

    debugPrint(
        "Permit in apicallfinctions updates :\n\n ${permit.toJson().toString()}");

    request.fields.addAll(permit.toJson());

    request.files.add(http.MultipartFile.fromBytes(
        'PassportPhoto', passportPhotoBytes,
        filename: 'passportPhoto.jpg'));
    request.files.add(http.MultipartFile.fromBytes('IdCard', idCardBytes,
        filename: 'idCard.jpg'));
    request.files.add(http.MultipartFile.fromBytes('SignPhoto', SignPhoto,
        filename: 'signature.jpg'));

    // Adding headers
    request.headers.addAll(headers);

    try {
      // Sending the request
      http.StreamedResponse response = await request.send();

      // Handling the response
      if (response.statusCode == 200) {
        var json = jsonDecode(await response.stream.bytesToString());
        String? applicant = json["applicationId"];
        debugPrint("in update api ss ${response.statusCode}");
        return {json["message"] ?? "message": applicant};
      } else {
        debugPrint("${response.reasonPhrase} ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Error in updatePermit: $e");
    }
    return {"Failed": 0};
  }

  @override
  Future<Map<String, dynamic>> detectFaces(Uint8List profileImage) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('http://127.0.0.1:8000/detect_faces/'));
    try {
      request.files.add(await http.MultipartFile.fromBytes('file', profileImage,
          filename: 'passportPhoto.jpg'));

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        debugPrint(await response.stream.bytesToString());
        return jsonDecode(response.stream.first.toString());
      } else {
        debugPrint(response.reasonPhrase);
        return {"Failed": 0};
      }
    } on Exception catch (e) {
      // TODO
      debugPrint("Error in detect face api: $e");
      return {"error": 0};
    }
  }

  @override
  Future<List<Gate>> getAllGates() async {
    try {
      final response = await http.get(headers: {
        'X-Key': key,
      }, Uri.parse("$localapi/api/kiosk/getactivegates"));
      debugPrint("In response gates:  ");
      if (response.statusCode == 200) {
        debugPrint(response.body);
        final respo = jsonDecode(response.body) as List<dynamic>;
        return respo.map((e) => Gate.fromJson(e)).toList(); // Parsing JSON
      } else {
        debugPrint("${response.statusCode}");
        return [];
      }
    } on Exception catch (e) {
      return [];
      // TODO
    }
  }

  @override
  Future<List<String>> getDocumentType() async {
    try {
      final response = await http
          .get(Uri.parse("$localapi/api/kiosk/getallidtype"), headers: {
        'X-Key': key,
      });
      debugPrint("In response");
      if (response.statusCode == 200) {
        debugPrint(response.body);
        final respo = jsonDecode(response.body) as List<dynamic>;
        return respo.map((e) => e.toString()).toList(); // Parsing JSON
      } else {
        return [];
      }
    } on Exception catch (e) {
      return [];
      // TODO
    }
  }

  @override
  Future<List<PermitPriceModel>> getallpremitprice() async {
    try {
      final response =
          await http.get(Uri.parse("$localapi/api/kiosk/getallfees"), headers: {
        'X-Key': key,
      });
      if (response.statusCode == 200) {
        debugPrint(response.body);
        final respo = jsonDecode(response.body) as List<dynamic>;
        return respo
            .map((e) => PermitPriceModel.fromJson(e))
            .toList(); // Parsing JSON
      } else {
        return [];
      }
    } on Exception catch (e) {
      // TODO
      return [];
    }
  }

  @override
  Future<PermitApplication?> verifydoc(
      {required String doctype, required String idnumber}) async {
    // var headers = {'Content-Type': 'application/json'};
    // var request = http.Request('POST',
    //     Uri.parse('https://ilpdemo.cubeten.com/api/kiosk/checkdocument'));

    // request.body = json.encode({"IdType": doctype, "IdNumber": idnumber});

    // request.headers.addAll(headers);

    // http.StreamedResponse response = await request.send();
    final response = await http.post(
        Uri.parse('$localapi/api/kiosk/checkdocument'),
        body: json.encode({"IdType": doctype, "IdNumber": idnumber}),
        headers: {
          'Content-Type': 'application/json',
          'X-Key': key,
        });
    if (response.statusCode == 200) {
      debugPrint("shfjfh");
      debugPrint(response.body);
      var appliid = PermitApplication.fromJson(jsonDecode(response.body));
      debugPrint("application ID:${appliid.applicationNo}");
      return appliid;
    } else {
      debugPrint(response.reasonPhrase);
      return null;
    }
  }

  @override
  Future<Map<String, IlPmodel?>> fetchPermitData(String permitnum) async {
    IlPmodel? d;
    try {
      final response = await http.get(headers: {
        'Content-Type': 'application/json',
        'X-Key': key,
      }, Uri.parse('$permitapi$permitnum'));
      debugPrint(response.statusCode.toString());
      if (response.statusCode >= 200 && response.statusCode < 300) {
        log("response.body : " + response.body);
        d = IlPmodel.fromJson(json.decode(response.body));
        debugPrint("d " + d.toJson().toString());
        // Assuming this function is parsing the response
        return {"Permit Fetch": d};
      } else {
        String s = response.statusCode > 400 && response.statusCode < 500
            ? response.statusCode == 401
                ? "Unauthorized"
                : "Permit not found"
            : response.statusCode >= 500
                ? "Error Fetching data from the server"
                : "Some failure oocured when fetching data";
        return {s: null};
      }
    } catch (e) {
      log(e.toString());
      return {"Failed to fetch permit": null};
    }
  }

  Future<PaymentResponse?> sendPayment(Payment payment) async {
    final url = Uri.parse('$localapi/api/kiosk/callback');
    debugPrint("to send payment data: ${payment.toJson()}");
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'X-Key': key,
        },
        body: jsonEncode(payment.toJson()),
      );
      debugPrint("payments ::    ${response.statusCode} --  ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        return PaymentResponse.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 400) {
        debugPrint('Bad Request: ${response.body}');
      } else {
        debugPrint(
            'Failed to send payment: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      debugPrint('Error gett payment: $e');
    }
    return null;
  }

  Future<OtpResponse?> aadharOtpResponse(
      String aadharid, String referenceId) async {
    final url = Uri.parse('https://your-api-endpoint.com/otp-request');

    final headers = {
      'Content-Type': 'application/json',
      'x-parse-rest-api-id': 'YOUR_API_ID',
      'x-parse-application-id': 'YOUR_APP_ID',
      'x-parse-rest-api-key': 'YOUR_API_KEY',
    };

    final body = jsonEncode({
      "reference_id": referenceId,
      "source": aadharid,
    });

    final response = await http.post(url, headers: headers, body: body);
    try {
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return OtpResponse.fromJson(json);
      } else {
        debugPrint('HTTP error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      debugPrint('HTTP error: ${e}');
      return null;
    }
  }

  Future<AadhaarVerificationResult?> aadharVerification(String otp,
      String referencdId, String transactionId, String timestamp) async {
    final url =
        Uri.parse('https://your-api-endpoint.com/aadhaar_xml_verify_otp');

    final headers = {
      'Content-Type': 'application/json',
    };

    final body = jsonEncode({
      "reference_id": referencdId,
      "transaction_id": transactionId,
      "otp": otp,
    });

    final response = await http.post(url, headers: headers, body: body);

    try {
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['status'] == 'success') {
          return AadhaarVerificationResult.fromJson(data['result']);
        } else {
          debugPrint(
              "OTP verification failed: ${data['error']} (${data['error_code']})");
          return null;
        }
      } else {
        debugPrint("HTTP Error: ${response.statusCode}");
        return null;
      }
    } on Exception catch (e) {
      // TODO
      debugPrint("Error on call ${e}");
      return null;
    }
  }
}
