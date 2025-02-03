import 'package:camera_windows_example/models/apicall.dart';
import 'package:camera_windows_example/models/apicallimpl.dart';
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

}