import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';
import 'package:camera_windows_example/cons/apis.dart';
import 'package:camera_windows_example/models/gate.dart';
import 'package:camera_windows_example/models/ilpmodel.dart';
import 'package:http/http.dart' as http;
import '../cons/constant.dart';
import 'apicall.dart';
import 'permit.dart';

class ApicallImpl extends ApiCall {
  static const String baseUrl =
      "https://jsonplaceholder.typicode.com/posts"; // Replace with your API URL
  @override
  Future<void> readPermit() async {
    final response = await http.get(Uri.parse(baseUrl));
    print("In response");
    if (response.statusCode == 200) {
      print(response.body);
      return jsonDecode(response.body); // Parsing JSON
    } else {
      throw Exception("Failed to load data");
    }
  }

@override
Future<Map<String,dynamic>> addPermit( Uint8List passportPhotoBytes, Uint8List idCardBytes,Uint8List SignPhoto,
VisitorEntry permit
      
      ) async {
  var headers = {
    'X-Key': 'hfuygf765r76yu',
  };

  var request = http.MultipartRequest('POST', Uri.parse('$localapi/api/Kiosk/submit'));
  
  print("Permit in apicallfinctions:\n\n ${permit.toJson().toString()}");
  
  request.fields.addAll(permit.toJson());

  request.files.add(http.MultipartFile.fromBytes('PassportPhoto', passportPhotoBytes, filename: 'passportPhoto.jpg'));
  request.files.add(http.MultipartFile.fromBytes('IdCard', idCardBytes, filename: 'idCard.jpg'));
  request.files.add(http.MultipartFile.fromBytes('SignPhoto', idCardBytes, filename: 'idCard.jpg'));

  // Adding headers
  request.headers.addAll(headers);

  // Sending the request
  http.StreamedResponse response = await request.send();

  // Handling the response
  if (response.statusCode == 200) {
    var json = jsonDecode(await response.stream.bytesToString());
    String? applicant = json["applicationId"];
    return {json["message"]??"message":applicant};
    // return  {jsonDecode( response.stream.bytesToString().toString())["message"]??"message":jsonDecode( response.stream.first.toString())["applicationId"]??null};
  } else {
    print("${response.reasonPhrase} ${response.statusCode}");
  }
      return {"Failed":0};
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
        print(await response.stream.bytesToString());
        return jsonDecode(response.stream.first.toString());
      } else {
        print(response.reasonPhrase);
        return {"Failed": 0};
      }
    } on Exception catch (e) {
      // TODO
      print("Error in detect face api: $e");
      return {"error": 0};
    }
  }

  @override
  Future<List<Gate>> getAllGates() async {
    final response = await http
        .get(Uri.parse("https://ilpdemo.cubeten.com/api/kiosk/getactivegates"));
    print("In response");
    if (response.statusCode == 200) {
      print(response.body);
      final respo = jsonDecode(response.body) as List<dynamic>;
      return respo.map((e) => Gate.fromJson(e)).toList(); // Parsing JSON
    } else {
      throw Exception("Failed to load data");
    }
  }

  @override
  Future<List<String>> getDocumentType() async {
    final response = await http
        .get(Uri.parse("https://ilpdemo.cubeten.com/api/kiosk/getallidtype"));
    print("In response");
    if (response.statusCode == 200) {
      print(response.body);
      final respo = jsonDecode(response.body) as List<dynamic>;
      return respo.map((e) => e.toString()).toList(); // Parsing JSON
    } else {
      throw Exception("Failed to load data");
    }
  }

  @override
  Future<String> getallpremitprice() async {
    var request = http.Request(
        'GET', Uri.parse('$localapi/api/kiosk/getallfees'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String alldata = await response.stream.bytesToString();
      return alldata;
    } else {
      print(response.reasonPhrase);
      return 'Error';
    }
  }

  @override
  Future<Map<String, IlPmodel?>> fetchPermitData(String permitnum) async {
    IlPmodel? d;
    try {
      final response = await http.get(Uri.parse('$permitapi$permitnum'));
      print(response.statusCode.toString());
      if (response.statusCode >= 200 && response.statusCode < 300) {
        log("response.body : " + response.body);
        d = IlPmodel.fromJson(json.decode(response.body));
        print("d " + d.toJson().toString());
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
}