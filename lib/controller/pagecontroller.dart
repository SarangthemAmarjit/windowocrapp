import 'package:get/get.dart';

class PageControllers extends GetxController{

    int page = 1;
    int regPage = 0;

    String? cardtype;

    void changePage(int index){
    page = index;
    update();      
    }



    void changeDashboardPage(int reg){
      regPage = reg;
      page = 1;
      update();
    }


    void selectCard(String cardtypes){
      cardtype = cardtypes;
      update();

    }

}