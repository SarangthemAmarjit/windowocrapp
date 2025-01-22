import 'package:get/get.dart';

import '../cons/constant.dart';

class Managementcontroller extends GetxController{

    String gender = genders[0];



    void changeGender(String gen){
        gender = gen;
        update();

    }

}