import 'package:camera_windows_example/widgets/paymentresultdialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child: ElevatedButton(
          onPressed: (){
            Get.dialog(Dialog(child: PaymentResultDialog(isSuccess: true, callback: () {  },),));
          },
          child: Text("Press"),
        ),
      )
    );
  }
}