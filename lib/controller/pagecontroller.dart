import 'dart:async';

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
  Timer? _timer;

  void listenPageChange() {
    //     if(_mainpageindex!=0){g
    //       if(_timer!=null){
    //         _timer!.cancel();
    //       }
    //         if(_mainpageindex==2){
    //  _timer = Timer(Duration(seconds: 40),(){

    //    setmainpageindex(ind: 0);
    //  });
    //         }else{

    //        _timer = Timer(Duration(seconds: 30),(){
    //           setmainpageindex(ind: 0);
    //        });

    //         }

    //     }else{
    //            if(_timer!=null){
    //         _timer!.cancel();
    //       }
    //     }
  }

  void changePage(int index) {
    page = index;
    update();
  }

  void changeIdSelection() {
    IdSelection = !IdSelection;
    update();
  }

  void changeIdSelectionnoUpdate() {
    IdSelection = false;
  }

  void setdocindex({required int ind}) {
    _docindex = ind;
    update();
  }

  void setmainpageindex({required int ind}) {
    if (page != 1) {
      page = 1;
    }
    _mainpageindex = ind;
    update();
  }

  void setmainpageindexnoupdate({required int ind}) {
    if (page != 1) {
      page = 1;
    }
    _mainpageindex = ind;
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

  void reset() {
    IdSelection = false;
    page = 1;
    regPage = 0;
    _docindex = 0;
    cardtype = null;
    _mainpageindex = 0;
  }
}
