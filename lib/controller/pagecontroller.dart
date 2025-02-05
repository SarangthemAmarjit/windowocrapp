import 'package:get/get.dart';

class PagenavControllers extends GetxController {
  int _mainpageindex = 0;
  int get mainpageindex => _mainpageindex;

  int page = 1;
  int regPage = 0;

  String? cardtype;

  void changePage(int index) {
    page = index;
    update();
  }

  void setmainpageindex({required int ind}) {
    if(page!=1){
      page=1;
    }
    _mainpageindex = ind;
    update();
  }

  void changeDashboardPage(int reg) {
    regPage = reg;
    page = 1;
    update();
  }

  void selectCard(String cardtypes) {
    cardtype = cardtypes;
    update();
  }
}
