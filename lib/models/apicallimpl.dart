import 'dart:convert';
import 'dart:typed_data';
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
  
  // Adding fields from the Admission model to the request
  request.fields.addAll(permit.toJson());
  // Add files to the request using bytes instead of path
  request.files.add(http.MultipartFile.fromBytes('PassportPhoto', passportPhotoBytes, filename: 'passportPhoto.jpg'));
  request.files.add(http.MultipartFile.fromBytes('IdCard', idCardBytes, filename: 'idCard.jpg'));

  // Adding headers
  request.headers.addAll(headers);

  // Sending the request
  http.StreamedResponse response = await request.send();

  // Handling the response
  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
    return {"Added":200};
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



  



  }
