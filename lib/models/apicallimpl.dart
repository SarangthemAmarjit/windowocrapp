import 'dart:convert';
import 'dart:typed_data';
import 'package:camera_windows_example/models/gate.dart';
import 'package:http/http.dart' as http;
import '../cons/constant.dart';
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
Future<Map<String,dynamic>> addPermit( Uint8List passportPhotoBytes, Uint8List idCardBytes,
// {required String idProofs,
//       required String idno,
//       required String purposeVisits,
//       required String placestay,
//       required String visitDates,
//       required String name,
//       required String parentname,
//       required String gender,
//       required String dob,
//       required String email,
//       required String mobile,
//       required String address,
//       required String state,
//       required String polstation,
//       required String district,
//       required String village,
//       required String tehsl,
//       required String applydistrict,
//       required String pincode}
VisitorEntry permit
      
      ) async {
  var headers = {
    'X-Key': 'hfuygf765r76yu',
  };

  var request = http.MultipartRequest('POST', Uri.parse('$api/api/Kiosk/submit'));
  


//  request.fields.addAll({
//   'ID_Proof': idProofs,
//   'ID_No': idno,
//   'Category': "",
//   'Purpose_Visit': purposeVisits,
//   'PlaceOfStay': placestay,
//   'VisitDate': visitDates,
//   'Applcnt_Name': name,
//   'Applcnt_Parent': parentname,
//   'Applcnt_Gender': gender,
//   'Applcnt_DOB': dob,
//   'Applcnt_Email': email,
//   'Applcnt_Mobile': mobile,
//   'Applcnt_Address': address,
//   'Applcnt_State': state,
//   'Applcnt_PoliceStation': polstation,
//   'Applcnt_District': district,
//   'Applcnt_Village': village,
//   'Applcnt_HNo':"",
//   'Applcnt_Tehsil': tehsl,
//   'Gate_ID': gate,
//   'EntryType': "Temporary Permit",
//   'Apply_District_ID': applydistrict,
//   'ResidingPeriod':"15",
//   'Landmark': "",
//   'District': applydistrict,
//   'PinCode':pincode,
// });
  print("Permit in apicallfinctions:\n\n ${permit.toJson().toString()}");
  
  request.fields.addAll(permit.toJson());

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
    print("${response.reasonPhrase} ${response.statusCode}");
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
     final response = await http.get(Uri.parse("$api/api/kiosk/getactivegates"));
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
     final response = await http.get(Uri.parse("$api/api/kiosk/getallidtype"));
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
        'GET', Uri.parse('$api/api/kiosk/getallfees'));

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
