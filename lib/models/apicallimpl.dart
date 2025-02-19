import 'dart:convert';
import 'dart:typed_data';
import 'package:camera_windows_example/models/gate.dart';
import 'package:http/http.dart' as http;
import 'apicall.dart';
import 'permit.dart';

class ApicallImpl extends ApiCall{
  static const String baseUrl = "https://jsonplaceholder.typicode.com/posts"; // Replace with your API URL
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
Future<Map<String,dynamic>> addPermit(VisitorEntry permit, Uint8List passportPhotoBytes, Uint8List idCardBytes) async {
  var headers = {
    'X-Key': 'hfuygf765r76yu',
  };

  var request = http.MultipartRequest('POST', Uri.parse('https://ilpdemo.cubeten.com/api/Kiosk/submit'));
  

 
 
 request.fields.addAll({
  'ID_Proof': "Aadhar" ?? '',
  'ID_No': permit.idNo ?? '',
  'Category': permit.category ?? '',
  'Purpose_Visit': permit.purposeVisit ?? '',
  'PlaceOfStay': permit.placeOfStay ?? '',
  'VisitDate': permit.visitDate ?? '',
  'Applcnt_Name': permit.applcntName ?? '',
  'Applcnt_Parent': permit.applcntParent ?? '',
  'Applcnt_Gender': permit.applcntGender ?? '',
  'Applcnt_DOB': permit.applcntDOB ?? '',
  'Applcnt_Email': permit.applcntEmail ?? '',
  'Applcnt_Mobile': permit.applcntMobile ?? '',
  'Applcnt_Address': permit.applcntAddress ?? '',
  'Applcnt_State': permit.applcntState ?? '',
  'Applcnt_PoliceStation': permit.applcntPoliceStation ?? '',
  'Applcnt_District': permit.applcntDistrict ?? '',
  'Applcnt_Village': permit.applcntVillage ?? '',
  'Applcnt_HNo': permit.applcntHNo ?? '',
  'Applcnt_Tehsil': permit.applcntTehsil ?? '',
  'Gate_ID': permit.gateID ?? '',
  'EntryType': permit.entryType ?? '',
  'Apply_District_ID': permit.applyDistrictID ?? '',
  'ResidingPeriod': permit.residingPeriod ?? '',
  'Landmark': permit.landmark ?? '',
  'District': permit.district ?? '',
  'PinCode': permit.pinCode ?? '',
});
  request.files.add(http.MultipartFile.fromBytes('PassportPhoto', passportPhotoBytes, filename: 'passportPhoto.jpg'));
  request.files.add(http.MultipartFile.fromBytes('IdCard', idCardBytes, filename: 'idCard.jpg'));

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
    print(response.reasonPhrase);
  }
      return {"Failed":0};
}

  @override
  Future<Map<String, dynamic>> detectFaces(Uint8List profileImage) async {
   var request = http.MultipartRequest('POST', Uri.parse('http://127.0.0.1:8000/detect_faces/'));
try {
  request.files.add(await http.MultipartFile.fromBytes('file',profileImage, filename: 'passportPhoto.jpg'));
  
  http.StreamedResponse response = await request.send();
  
  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
    return  jsonDecode( response.stream.first.toString());
  }
  else {
    print(response.reasonPhrase);
    return {"Failed":0};
  }
} on Exception catch (e) {
  // TODO
  print("Error in detect face api: $e");
  return {"error":0};
}
  }

  @override
  Future<List<Gate>> getAllGates() async {
     final response = await http.get(Uri.parse("https://ilpdemo.cubeten.com/api/kiosk/getactivegates"));
  print("In response");
    if (response.statusCode == 200) {
      print(response.body);
      final respo = jsonDecode(response.body )as List<dynamic>;
      return respo.map((e) => Gate.fromJson(e)).toList(); // Parsing JSON
    } else {
      throw Exception("Failed to load data");
    }
  }

  @override
  Future<List<String>> getDocumentType() async {
     final response = await http.get(Uri.parse("https://ilpdemo.cubeten.com/api/kiosk/getallidtype"));
  print("In response");
    if (response.statusCode == 200) {
      print(response.body);
      final respo = jsonDecode( response.body) as List<dynamic>;
      return respo.map((e) => e.toString()).toList(); // Parsing JSON
    } else {
      throw Exception("Failed to load data");
    }
  }


  @override
  Future<String> getallpremitprice() async {
    var request = http.Request(
        'GET', Uri.parse('https://ilpdemo.cubeten.com/api/kiosk/getallfees'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String alldata = await response.stream.bytesToString();

      return alldata;
    } else {
      print(response.reasonPhrase);
      return 'Error';
    }
  }

  



  }
