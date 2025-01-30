import 'package:camera_windows_example/models/apicall.dart';
import 'package:camera_windows_example/models/apicallimpl.dart';
import 'package:get/get.dart';

import '../cons/constant.dart';

class Managementcontroller extends GetxController{

    String gender = genders[0];
    final ApiCall apicall = ApicallImpl();


    void changeGender(String gen){
        gender = gen;
        update();

    }

    void readPermit(){
        apicall.readPermit();

    }

}