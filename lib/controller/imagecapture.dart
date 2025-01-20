import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Imagecontroller extends GetxController{
 Size? _previewSize;
 Size? get previewsize=>_previewSize;
  int? _cameraid ;
  int? get cameraid=>_cameraid;

  void setcameraid({required int id,required Size size}){
    _cameraid = id;
    _previewSize = size;
    update();
  }
}