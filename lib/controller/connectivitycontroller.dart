import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class Connectivitycontroller extends GetxController{

   RxBool isConnectivity = RxBool(false);
 
 final Connectivity _connectivity = Connectivity();
  StreamSubscription<List<ConnectivityResult>>? connectivitySubscription;


    Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    isConnectivity.value = result.contains(ConnectivityResult.none);
  }
@override
  void onInit() {
    super.onInit();
     initConnectivity();
    connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<void> initConnectivity() async {
    late List<ConnectivityResult> result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      return;
    }
    return _updateConnectionStatus(result);
  }

}