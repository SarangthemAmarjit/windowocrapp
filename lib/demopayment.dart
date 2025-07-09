import 'dart:convert';
import 'dart:developer';

import 'package:camera_windows_example/cons/utils.dart';
import 'package:camera_windows_example/controller/paymentcontroller.dart';
import 'package:camera_windows_example/payment/atom_pay_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;

class Paymentdemo extends StatelessWidget {
  // merchant configuration data
  final String login = "317157"; //mandatory
  final String password = 'Test@123'; //mandatory
  final String prodid = 'NSE'; //mandatory
  final String requestHashKey = 'KEY1234567234'; //mandatory
  final String responseHashKey = 'KEYRESP123657234'; //mandatory
  final String requestEncryptionKey =
      'A4476C2062FFA58980DC8F79EB6A799E'; //mandatory
  final String responseDecryptionKey =
      '75AEF0FA1B94B3C10D4F5B268F757F11'; //mandatory
  final String txnid =
      'test240223'; // mandatory // this should be unique each time
  final String clientcode = "NAVIN"; //mandatory
  final String txncurr = "INR"; //mandatory
  final String mccCode = "5499"; //mandatory
  final String merchType = "R"; //mandatory
  final String amount = "1.00"; //mandatory

  final String mode = "uat"; // change live for production

  final String custFirstName = 'test'; //optional
  final String custLastName = 'user'; //optional
  final String mobile = '8888888888'; //optional
  final String email = 'test@gmail.com'; //optional
  final String address = 'mumbai'; //optional
  final String custacc = '639827'; //optional
  final String udf1 = "udf1"; //optional
  final String udf2 = "udf2"; //optional
  final String udf3 = "udf3"; //optional
  final String udf4 = "udf4"; //optional
  final String udf5 = "udf5"; //optional

  final String authApiUrl = "https://caller.atomtech.in/ots/aipay/auth"; // uat

  // final String auth_API_url =
  //     "https://payment1.atomtech.in/ots/aipay/auth"; // prod

  final String returnUrl =
      "https://pgtest.atomtech.in/mobilesdk/param"; //return url uat
  // final String returnUrl =
  //     "https://payment.atomtech.in/mobilesdk/param"; ////return url production

  final String payDetails = '';

  const Paymentdemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GetxTapController gcontroller = Get.put(GetxTapController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('NDPS Sample App'),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => gcontroller.initNdpsPayment(
                email: "assa@gmail.com",
                number: "3214234356",
                transId: generateRandomString(12),
                context: context,
                responseHashKey: gcontroller.responseHashKey,
                responseDecryptionKey: gcontroller.responseDecryptionKey,
                amount: "100",
                address: 'fsdfsdf',
                name: 'amarjit',
              ),
              child: const Text('Open'),
            ),
          ],
        ),
      ),
    );
  }
}
