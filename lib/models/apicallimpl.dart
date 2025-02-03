import 'dart:convert';
import 'package:http/http.dart' as http;
import 'apicall.dart';

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
  Future<Map<String, dynamic>> addPermit() async {
      final response = await http.post(Uri.parse(baseUrl));
  print("In response");
    if (response.statusCode == 200) {
      print(response.body);
      return jsonDecode(response.body); // Parsing JSON
    } else {
      throw Exception("Failed to load data");
    }
  }



  }
