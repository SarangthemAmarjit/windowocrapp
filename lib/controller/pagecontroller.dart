import 'package:get/get.dart';

class PagenavControllers extends GetxController {
  int _mainpageindex = 0;
  int get mainpageindex => _mainpageindex;

  int _docindex = 0;
  int get docindex => _docindex;

  int page = 1;
  int regPage = 0;

  String? cardtype;

  void changePage(int index) {
    page = index;
    update();
  }

  void setdocindex({required int ind}) {
    _docindex = ind;
    update();
  }

  void setmainpageindex({required int ind}) {
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
