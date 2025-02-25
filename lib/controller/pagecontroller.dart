import 'package:get/get.dart';

class PagenavControllers extends GetxController {
  int _mainpageindex = 0;
  int get mainpageindex => _mainpageindex;

  int _docindex = 0;
  int get docindex => _docindex;

  int page = 1;
  int regPage = 0;

  String? cardtype;

  /// for changing between id card and id number enter fields in ID Selection page
  bool IdSelection = false;


  void changePage(int index) {
    page = index;
    update();
  }

  void changeIdSelection(){
    IdSelection = !IdSelection;
    update();
  }
  
  
  void setdocindex({required int ind}) {
    _docindex = ind;
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


  void reset(){
    IdSelection = false;
    page = 1;
    regPage = 0;
    _docindex = 0;
    cardtype  = null;
     _mainpageindex = 0;
  }


}
