import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:camera_windows_example/cons/printimages.dart';
import 'package:camera_windows_example/controller/managementcontroller.dart';
import 'package:camera_windows_example/controller/pagecontroller.dart';
import 'package:camera_windows_example/payment/PaymentPage.dart';
import 'package:camera_windows_example/payment/atom_pay_helper.dart';
import 'package:camera_windows_example/widgets/receiptpermit.dart';
import 'package:cryptography/cryptography.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../home/landingpage.dart';
import '../models/paymentresponse.dart';

class GetxTapController extends GetxController {
  String _atomTokenId = '';
  String get atomTokenId => _atomTokenId;

  String _transacid = '';
  String get transacid => _transacid;

  // merchant configuration data
  // PaymentConfig config = paymentconfigModel;
  // merchant configuration data
  // final String login = "684703"; //"445842"; //mandatory
  // final String password = "0e464700"; //mandatory
  // final String prodid = 'ILP'; //mandatory
  // final String requestHashKey = '750fa5f3c01f9a4b3e'; //mandatory
  // final String responseHashKey = 'd5110c2964f4ae7bbd'; //mandatory
  // final String requestEncryptionKey = 'C11CB813ACE571A313DBF397B8F8057E'; //mandatory
  // final String responseDecryptionKey = '789257B2A0EFA675273732B9E07747BD'; //mandatory
  // // final String txnid =
  // //     'test240223'; // mandatory // this should be unique each time
  // final String clientcode = "01950075"; //mandatory
  // final String txncurr = "INR"; //mandatory
  // final String mccCode = "9399"; //mandatory
  // final String merchType = "R"; //mandatory// final String amount = "1.00"; //mandat
  // final String mode = "live"; // change live for production

  // // final String custFirstName = 'test'; //optional
  // // final String custLastName = 'user'; //optional
  // // final String mobile = '8888888888'; //optional
  // // final String email = 'test@gmail.com'; //optional
  // // final String address = 'mumbai'; //optional
  // final String custacc = '639827'; //optional
  // final String udf1 = "udf1"; //optional
  // final String udf2 = "udf2"; //optional
  // final String udf3 = "udf3"; //optional
  // final String udf4 = "udf4"; //optional
  // final String udf5 = "udf5"; //optional

  // static const req_EncKey = 'C11CB813ACE571A313DBF397B8F8057E';
  // static const req_Salt = 'C11CB813ACE571A313DBF397B8F8057E';
  // static const res_DecKey = '789257B2A0EFA675273732B9E07747BD';
  // static const res_Salt = '789257B2A0EFA675273732B9E07747BD';

  // final String paymentDomainURL = "https://payment1.atomtech.in/ots/aipay/auth";
  // // final String auth_API_url =
  // //     "https://payment1.atomtech.in/ots/aipay/auth"; // prod

  // final String returnUrl = "https://payment.atomtech.in/mobilesdk/param"; //return url uat
  // final String returnUrl =
  //     "https://payment.atomtech.in/mobilesdk/param"; ////return url production
////////

  // merchant configuration data
  final String login = "317159"; //"445842"; //mandatory
  final String password = 'Test@123'; //mandatory
  final String prodid = 'NSE'; //mandatory
  final String requestHashKey = 'KEY123657234'; //mandatory
  final String responseHashKey = 'KEYRESP123657234'; //mandatory
  final String requestEncryptionKey = 'A4476C2062FFA58980DC8F79EB6A799E'; //mandatory
  final String responseDecryptionKey = '75AEF0FA1B94B3C10D4F5B268F757F11'; //mandatory
  // final String txnid =
  //     'test240223'; // mandatory // this should be unique each time
  final String clientcode = "NAVIN"; //mandatory
  final String txncurr = "INR"; //mandatory
  final String mccCode = "5499"; //mandatory
  final String merchType = "R"; //mandatory
  // final String amount = "1.00"; //mandatory

  final String mode = "uat"; // change live for production

  // final String custFirstName = 'test'; //optional
  // final String custLastName = 'user'; //optional
  // final String mobile = '8888888888'; //optional
  // final String email = 'test@gmail.com'; //optional
  // final String address = 'mumbai'; //optional
  final String custacc = '639827'; //optional
  final String udf1 = "udf1"; //optional
  final String udf2 = "udf2"; //optional
  final String udf3 = "udf3"; //optional
  final String udf4 = "udf4"; //optional
  final String udf5 = "udf5"; //optional

  static const req_EncKey = 'A4476C2062FFA58980DC8F79EB6A799E';
  static const req_Salt = 'A4476C2062FFA58980DC8F79EB6A799E';
  static const res_DecKey = '75AEF0FA1B94B3C10D4F5B268F757F11';
  static const res_Salt = '75AEF0FA1B94B3C10D4F5B268F757F11';

  final String paymentd = "https://caller.atomtech.in/ots/aipay/auth"; // uat
  final String paymentDomainURL = "https://paynetzuat.atomtech.in/ots/aipay/auth"; // uat
  final String auth_API_url = "https://payment1.atomtech.in/ots/aipay/auth"; // prod

  final String returnUrl = "https://pgtest.atomtech.in/mobilesdk/param"; //return url uat
  // // final String returnUrl =
  // //     "https://payment.atomtech.in/mobilesdk/param"; ////return url production

  final String payDetails = '';

  final password22 = Uint8List.fromList(utf8.encode(req_EncKey));
  final salt = Uint8List.fromList(utf8.encode(req_Salt));
  final resPassword = Uint8List.fromList(utf8.encode(res_DecKey));
  final resSalt = Uint8List.fromList(utf8.encode(res_Salt));
  final iv = Uint8List.fromList([0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]);

  bool _ispaymentinfosend = true;
  bool get ispaymentinfosend => _ispaymentinfosend;

  bool _isloading = true;
  bool _isdataempty = false;

  bool _ischecked = false;
  File? _imagefile;

  //
  var isDataLoading = false.obs;

  bool get isloading => _isloading;
  bool get isdataempty => _isdataempty;
  bool get ischecked => _ischecked;

  File? get imagefile => _imagefile;

  bool _ispaymentprocessstarted = false;
  bool get ispaymentprocessstarted => _ispaymentprocessstarted;

  resetloading() {
    _ispaymentprocessstarted = false;
    update();
  }

  Future<String> encrypt22(String text) async {
    debugPrint('Input text for encryption: $text');

    try {
      final pbkdf2 = Pbkdf2(
        macAlgorithm: Hmac.sha1(), // Match SHA1 from C# code
        iterations: 65536,
        bits: 256, // Deriving 256-bit key
      );

      final derivedKey = await pbkdf2.deriveKey(
        secretKey: SecretKey(password22), // Password as secret
        nonce: salt, // Salt value
      );

      final keyBytes = (await derivedKey.extractBytes()).sublist(0, 16); // Extract 128-bit key
      debugPrint(
          'Derived AES key: ${keyBytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join()}');

      final aesCbc = AesCbc.with128bits(
        macAlgorithm: MacAlgorithm.empty,
        paddingAlgorithm: PaddingAlgorithm.pkcs7,
      );

      final secretBox = await aesCbc.encrypt(
        utf8.encode(text),
        secretKey: SecretKey(keyBytes),
        nonce: iv,
      );

      final encryptedHex =
          secretBox.cipherText.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
      debugPrint('Encrypted output (hex): $encryptedHex');

      return encryptedHex;
    } catch (e, stackTrace) {
      debugPrint('Encryption error: $e');
      debugPrint('Stack trace: $stackTrace');
      rethrow;
    }
  }

  //Encrypt Function
  Future<String> encrypt(String text) async {
    debugPrint('Input text for encryption: $text');
    try {
      final pbkdf2 = Pbkdf2(
        macAlgorithm: Hmac.sha512(),
        iterations: 65536,
        bits: 256,
      );

      final derivedKey = await pbkdf2.deriveKey(
        secretKey: SecretKey(password22),
        nonce: salt,
      );

      final keyBytes = await derivedKey.extractBytes();
      debugPrint('Derived key bytes: $keyBytes');

      final aesCbc = AesCbc.with256bits(
        macAlgorithm: MacAlgorithm.empty,
        paddingAlgorithm: PaddingAlgorithm.pkcs7,
      );

      final secretBox = await aesCbc.encrypt(
        utf8.encode(text),
        secretKey: SecretKey(keyBytes),
        nonce: iv,
      );

      final hexOutput = secretBox.cipherText.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
      debugPrint('Encrypted hex output: $hexOutput');
      return hexOutput;
    } catch (e, stackTrace) {
      debugPrint('Encryption error: $e');
      debugPrint('Stack trace: $stackTrace');
      rethrow;
    }
  }

  //Decrypt Function
  Future<String> decrypt(String hexCipherText) async {
    try {
      // debugPrint('Input hex for decryption: $hexCipherText');

      // Convert hex string to bytes
      List<int> cipherText = [];
      for (int i = 0; i < hexCipherText.length; i += 2) {
        String hex = hexCipherText.substring(i, i + 2);
        cipherText.add(int.parse(hex, radix: 16));
      }
      debugPrint('Cipher text bytes: $cipherText');

      final pbkdf2 = Pbkdf2(
        macAlgorithm: Hmac.sha512(),
        iterations: 65536,
        bits: 256,
      );

      final derivedKey = await pbkdf2.deriveKey(
        secretKey: SecretKey(resPassword),
        nonce: resSalt, // Use the same salt as in encryption
      );

      final keyBytes = await derivedKey.extractBytes();

      final aesCbc = AesCbc.with256bits(
        macAlgorithm: MacAlgorithm.empty,
        paddingAlgorithm: PaddingAlgorithm.pkcs7,
      );

      final secretBox = SecretBox(
        cipherText,
        nonce: iv, // Use the same IV as in encryption
        mac: Mac.empty,
      );
      // debugPrint('SecretBox: $secretBox');

      final decryptedBytes = await aesCbc.decrypt(
        secretBox,
        secretKey: SecretKey(keyBytes),
      );

      final decryptedText = utf8.decode(decryptedBytes);
      // debugPrint('Decrypted text: $decryptedText');
      return decryptedText;
    } catch (e, stackTrace) {
      debugPrint('Decryption error: $e');
      debugPrint('Stack trace: $stackTrace');
      rethrow;
    }
  }

  void initNdpsPayment(
      {required BuildContext context,
      required String name,
      required String transId,
      required String amount,
      required String email,
      required String clientcodeok,
      required String number,
      required String address}) {
    _ispaymentprocessstarted = true;
    gettransactionid(transId);
    _getEncryptedPayUrl(
        context: context,
        name: name,
        email: email,
        number: number,
        amount: amount,
        clientid: clientcodeok,
        address: address);
  }

  _getEncryptedPayUrl(
      {required BuildContext context,
      required String name,
      required String email,
      required String number,
      required String amount,
      required String clientid,
      required String address}) async {
    String reqJsonData = _getJsonPayloadData(
      name: name,
      amount: amount,
      address: address,
      email: email,
      number: number,
      clientid: clientid,
    );
    log("All Data before sending for encrypt : " + reqJsonData);

    try {
      final String encDataR = await encrypt(reqJsonData);
      String authEncryptedString = encDataR.toString();
      // here is result.toString() parameter you will receive encrypted string
      // debugPrint("generated encrypted string: '$authEncryptedString'");
      _getAtomTokenId(context, authEncryptedString, email: email, number: number);
    } on PlatformException catch (e) {
      debugPrint("Failed to get encryption string: '${e.message}'.");
    }
  }

//"https://caller.atomtech.in/ots/aipay/auth"
  _getAtomTokenId(context, authEncryptedString,
      {required String email, required String number}) async {
    var request = http.Request('POST', Uri.parse(paymentDomainURL));
    request.bodyFields = {'encData': authEncryptedString, 'merchId': login};

    http.StreamedResponse response = await request.send();
    try {
      if (response.statusCode == 200) {
        log('payment encryption:  200');
        var authApiResponse = await response.stream.bytesToString();
        final split = authApiResponse.trim().split('&');
        final Map<int, String> values = {for (int i = 0; i < split.length; i++) i: split[i]};
        try {
          final splitTwo = values[1]!.split('=');
          if (splitTwo[0] == 'encData') {
            final encDataPart = split.firstWhere((element) => element.startsWith('encData'));
            final encryptedData = encDataPart.split('=')[1];
            final extractedData = ['encData', encryptedData];
            try {
              final decryptedData = await decrypt(extractedData[1]);
              // debugPrint(decryptedData.toString()); // to read full response
              var respJsonStr = decryptedData.toString();
              Map<String, dynamic> jsonInput = jsonDecode(respJsonStr);
              if (jsonInput["responseDetails"]["txnStatusCode"] == 'OTS0000') {
                _atomTokenId = jsonInput["atomTokenId"].toString();
                update();
                // debugPrint("atomTokenId: $_atomTokenId");
                final String payDetails =
                    '{"atomTokenId" : "$_atomTokenId","merchId": "${login}","emailId": $email,"mobileNumber":$number, "returnUrl":"${returnUrl}"}';
                _openNdpsPG(payDetails, context, responseHashKey, responseDecryptionKey);
              } else {
                debugPrint("Problem in auth API response");
              }
            } on PlatformException catch (e) {
              debugPrint("Failed to decrypt: '${e.message}'.");
            }
          }
        } catch (e) {
          Get.dialog(AlertDialog(
              content: Text(
            "Failed to process online payment.Please Go at the counter",
          )));
          Future.delayed(Duration(seconds: 3)).then((v) {
            Get.back();
          });
          paymnetFailedCallback();
          debugPrint("Failed to decrypt data: '${e}'.");
        }
      }
    } on Exception catch (e) {
      paymnetFailedCallback();

      debugPrint("Failed to decrypt data: '${e}'.");
    }
  }

  _openNdpsPG(payDetails, BuildContext context, responseHashKey, responseDecryptionKey) {
    Get.to(PaymentFinalPage(mode, payDetails, responseHashKey, responseDecryptionKey));
  }

  Future<void> paymnetFailedCallback() async {
    String? s = Get.find<Managementcontroller>().onlineAplicant;
    if (s != null) {
      GlobalKey key = GlobalKey();
      Get.dialog(AlertDialog(
        content: RepaintBoundary(key: key, child: ReceiptWidget(applicantName: "", applicantId: s)),
      ));
      await Future.delayed(Duration(seconds: 2));
      RenderRepaintBoundary boundary =
          key.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage();
      debugPrint("nav Keys image in save receipt");
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List barcodes = byteData!.buffer.asUint8List();
      Get.back();
      try {
        String printers = Get.find<Managementcontroller>().printername ?? "CUSTOM K80";
        printUsbReceiptWindows(printers, barcodes, s, "The online payment failed to process");
      } catch (e) {
        debugPrint("Printere Exception");
      }
      _ispaymentprocessstarted = false;
      update();
      Get.find<PagenavControllers>().setmainpageindex(ind: 6);
      Get.offAll(() => LandingPage());
    }
  }

  _getJsonPayloadData(
      {required String name,
      required String amount,
      required String address,
      required String email,
      required String clientid,
      required String number}) {
    var payDetails = {};
    payDetails['login'] = login;
    payDetails['password'] = password;
    payDetails['prodid'] = prodid;
    payDetails['custFirstName'] = name;
    payDetails['custLastName'] = '';
    payDetails['amount'] = amount;
    // payDetails['mobile'] = '+913234656543';
    payDetails['mobile'] = number;
    payDetails['address'] = address;
    // payDetails['email'] = 'fsdfs@gmail.com';
    payDetails['email'] = email;
    payDetails['txnid'] = _transacid;
    payDetails['custacc'] = custacc;
    payDetails['requestHashKey'] = requestHashKey;
    payDetails['responseHashKey'] = responseHashKey;
    payDetails['requestencryptionKey'] = requestEncryptionKey;
    payDetails['responseencypritonKey'] = responseDecryptionKey;
    payDetails['clientcode'] = clientid;
    payDetails['txncurr'] = txncurr;
    payDetails['mccCode'] = mccCode;
    payDetails['merchType'] = merchType;
    payDetails['returnUrl'] = returnUrl;
    payDetails['mode'] = mode;
    payDetails['udf1'] = udf1;
    payDetails['udf2'] = udf2;
    payDetails['udf3'] = udf3;
    payDetails['udf4'] = udf4;
    payDetails['udf5'] = udf5;
    String jsonPayLoadData = getRequestJsonData(payDetails);
    return jsonPayLoadData;
  }

  updatepaymentremark(
      {required String transactionid,
      required String remark,
      required GlobalKey key,
      required String amount,
      required String processingfee,
      required String paymentmethod}) async {
    try {
      debugPrint("In payment amount : $amount");
      Payment p = Payment(
          paymentId: transactionid,
          status: remark,
          processingfee: double.tryParse(processingfee) ?? 0,
          deviceId: 1,
          amount: double.tryParse(amount) ?? 100,
          method: paymentmethod);
      await Get.find<Managementcontroller>().addPayments(p, key);
    } catch (e) {
      _ispaymentinfosend = false;
      update();
      debugPrint(e.toString());
    }
  }

  void gettransactionid(String transId) {
    _transacid = transId;
    update();
    debugPrint(_transacid);
  }
}
