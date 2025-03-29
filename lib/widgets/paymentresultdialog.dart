import 'package:camera_windows_example/controller/managementcontroller.dart';
import 'package:camera_windows_example/home/registrationpages/paymentdetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

class PaymentResultDialog extends StatelessWidget {

  final bool isSuccess;
  final VoidCallback callback;
  const PaymentResultDialog({super.key, required this.isSuccess, required this.callback});



  @override
  Widget build(BuildContext context) {
    return GetBuilder<Managementcontroller>(
      builder: (mngctrl) {
        return Container(
            height: 600,
            width: 400,
            padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
           
          //   gradient: isSuccess? LinearGradient(
          //     begin: Alignment.topCenter,
          //     end: Alignment.bottomCenter,
          //     colors: 
              
          // [Colors.white, Colors.green[300]!,Colors.green[700]!,Colors.green[300]!] 
              
          //     ):null
              ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                   SizedBox(height: 20,),
               CircleAvatar(
                radius: 50,
                backgroundColor: isSuccess? Colors.green[300]:Colors.red[300],
                child: Center(child: Icon(isSuccess? Icons.check:Icons.close,size: 60,color: Colors.white,))).animate().scaleXY(begin:0.3,end: 1,curve: Curves.bounceOut,duration: Duration(milliseconds: 700)),
                SizedBox(height: 20,),
              Text(isSuccess?"Payment successfully processed":"Payment Failed to Process",style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold,),textAlign: TextAlign.center,),
              isSuccess? Text("Your payment of Rs ${mngctrl.getPermitPrice?.fee} for the ${mngctrl.getPermitPrice?.permitName} is successfull. Please wait while we generate your receipt.",style: TextStyle(fontSize: 24),textAlign: TextAlign.center,):SizedBox(),
             SizedBox(height: 40,)
              //  isSuccess?    ButtonCard(title: "Continue", onpress:callback):  Row(
              //     children: [
              //        Expanded(
              //         child: ButtonCard(
              //           padding: EdgeInsets.symmetric(vertical: 8,horizontal:8),
              //           icon: Icon(Icons.refresh), 
              //           title: "Retry", onpress: (){
                        
              //         }),
              //       ),
        
              //     ],
              //   )
              ],
            ),
        );
      }
    );
  }
}