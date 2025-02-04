import 'dart:typed_data';

import 'package:camera_windows_example/models/apicall.dart';
import 'package:camera_windows_example/models/apicallimpl.dart';
import 'package:camera_windows_example/models/permit.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../cons/constant.dart';

class Managementcontroller extends GetxController{
    String? idCard;
    String gender = genders[0];
    final ApiCall apicall = ApicallImpl();
  String? state;
  String? purpose;

    void changeGender(String gen){
        gender = gen;
        update();

    }

    void changePurpose(String purs){
      purpose = purs;
      update();
    }

    void changeState(String stat){
        state = stat;
        update();
    }

    void readPermit(){
        apicall.readPermit();

    }

    void getIdCard(String id){
      idCard = id;
      update();
    }

    Future<void> addtemporaryPermit(VisitorEntry permit) async {
        String passportpath = 'assets/images/Kanglashanew1.png';
        String idcardpath = 'assets/images/Kanglashanew1.png';
        Uint8List passport = await getImageAssetBytes(passportpath);
        Uint8List idcard = await getImageAssetBytes(idcardpath);
        Map<String,dynamic> d =  await apicall.addPermit(permit,passport,idcard);
        print(d);
   }

    Future<Uint8List> getImageAssetBytes(String assetPath) async {
  // Load the asset as bytes from memory
  ByteData byteData = await rootBundle.load(assetPath);
  return byteData.buffer.asUint8List();
}

}