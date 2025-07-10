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
  GetxTapController();
  String? _validationError;
  String? get validationError => _validationError;

  String? _errortitletext;
  String? get errortitletext => _errortitletext;

  String? _errorgazettetype;
  String? get errorgazettetype => _errorgazettetype;

  String _atomTokenId = '';
  String get atomTokenId => _atomTokenId;

  String _transacid = '';
  String get transacid => _transacid;

  String transactiondate = '';
  String transactiontime = '';

  final List<String> _alldepartmentlist = [];
  List<String> get alldepartmentlist => _alldepartmentlist;

  String _publishTilldate = '';

  DateTime _publishTillinitialdate = DateTime.now();

  String _publishfromdate = '01-01-1950';

  DateTime _publishfrominitialdate = DateTime(1950, 01, 01);

  //Server Error
  bool _isserverok = true;
  bool get isserverok => _isserverok;

  bool _istextexpanded = false;
  bool get istextexpanded => _istextexpanded;

  bool _isfiltersearch = false;
  bool get isfiltersearch => _isfiltersearch;

  bool _ispaymentinfosend = true;
  bool get ispaymentinfosend => _ispaymentinfosend;

  //
  String searchtextvalue = '';

  String _billingdropdownvalue = '';
  String _postaldropdownvalue = '';

  String get billingdropdownvalue => _billingdropdownvalue;
  String get postaldropdownvalue => _postaldropdownvalue;

  int? _gazettid;
  int? get gazettid => _gazettid;

  int _paginationindex = 0;
  int get paginationindex => _paginationindex;

  bool _isloading = true;
  bool _isdataempty = false;

  bool _ischecked = false;
  File? _imagefile;

  //
  var isDataLoading = false.obs;

  String get publishTilldate => _publishTilldate;
  String get publishFromdate => _publishfromdate;
  DateTime get publishTillinitialdate => _publishTillinitialdate;
  DateTime get publishFrominitialdate => _publishfrominitialdate;

  bool get isloading => _isloading;
  bool get isdataempty => _isdataempty;
  bool get ischecked => _ischecked;

  File? get imagefile => _imagefile;

  //
  bool _isfocusontextfield = false;
  bool get isfocusontextfield => _isfocusontextfield;

  bool? _isdownloadedfile;
  bool? get isdownloadedfile => _isdownloadedfile;

  bool _ispaymentprocessstarted = false;
  bool get ispaymentprocessstarted => _ispaymentprocessstarted;

  @override
  void onwebviewcreated() {
    _isloading = true;
    update();
  }

  resetloading() {
    _ispaymentprocessstarted = false;
    update();
  }
  // P A Y M E N T   GATEWAY

  // merchant configuration data
  final String login = "684703"; //"445842"; //mandatory
  final String password = "0e464700"; //mandatory
  final String prodid = 'ILP'; //mandatory
  final String requestHashKey = '750fa5f3c01f9a4b3e'; //mandatory
  final String responseHashKey = 'd5110c2964f4ae7bbd'; //mandatory
  final String requestEncryptionKey = 'C11CB813ACE571A313DBF397B8F8057E'; //mandatory
  final String responseDecryptionKey = '789257B2A0EFA675273732B9E07747BD'; //mandatory
  // final String txnid =
  //     'test240223'; // mandatory // this should be unique each time
  final String clientcode = "01950075"; //mandatory
  final String txncurr = "INR"; //mandatory
  final String mccCode = "9399"; //mandatory
  final String merchType = "R"; //mandatory// final String amount = "1.00"; //mandat
  final String mode = "live"; // change live for production

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

  static const req_EncKey = 'C11CB813ACE571A313DBF397B8F8057E';
  static const req_Salt = 'C11CB813ACE571A313DBF397B8F8057E';
  static const res_DecKey = '789257B2A0EFA675273732B9E07747BD';
  static const res_Salt = '789257B2A0EFA675273732B9E07747BD';

  final String paymentDomainURL = "https://payment1.atomtech.in/ots/aipay/auth";
  // final String auth_API_url =
  //     "https://payment1.atomtech.in/ots/aipay/auth"; // prod

  final String returnUrl = "https://payment.atomtech.in/mobilesdk/param"; //return url uat
  // final String returnUrl =
  //     "https://payment.atomtech.in/mobilesdk/param"; ////return url production
////////

  // merchant configuration data
  // final String login = "317159"; //"445842"; //mandatory
  // final String password = 'Test@123'; //mandatory
  // final String prodid = 'NSE'; //mandatory
  // final String requestHashKey = 'KEY123657234'; //mandatory
  // final String responseHashKey = 'KEYRESP123657234'; //mandatory
  // final String requestEncryptionKey =
  //     'A4476C2062FFA58980DC8F79EB6A799E'; //mandatory
  // final String responseDecryptionKey =
  //     '75AEF0FA1B94B3C10D4F5B268F757F11'; //mandatory
  // // final String txnid =
  // //     'test240223'; // mandatory // this should be unique each time
  // final String clientcode = "NAVIN"; //mandatory
  // final String txncurr = "INR"; //mandatory
  // final String mccCode = "5499"; //mandatory
  // final String merchType = "R"; //mandatory
  // // final String amount = "1.00"; //mandatory

  // final String mode = "uat"; // change live for production

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

  // static const req_EncKey = 'A4476C2062FFA58980DC8F79EB6A799E';
  // static const req_Salt = 'A4476C2062FFA58980DC8F79EB6A799E';
  // static const res_DecKey = '75AEF0FA1B94B3C10D4F5B268F757F11';
  // static const res_Salt = '75AEF0FA1B94B3C10D4F5B268F757F11';

  // final String paymentd = "https://caller.atomtech.in/ots/aipay/auth"; // uat
  // final String paymentDomainURL =
  //     "https://paynetzuat.atomtech.in/ots/aipay/auth"; // uat
  // // final String auth_API_url =
  // //     "https://payment1.atomtech.in/ots/aipay/auth"; // prod

  // final String returnUrl =
  //     "https://pgtest.atomtech.in/mobilesdk/param"; //return url uat
  // // final String returnUrl =
  // //     "https://payment.atomtech.in/mobilesdk/param"; ////return url production

  final String payDetails = '';

  final password22 = Uint8List.fromList(utf8.encode(req_EncKey));
  final salt = Uint8List.fromList(utf8.encode(req_Salt));
  final resPassword = Uint8List.fromList(utf8.encode(res_DecKey));
  final resSalt = Uint8List.fromList(utf8.encode(res_Salt));
  final iv = Uint8List.fromList([0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]);

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
      required String responseHashKey,
      required String responseDecryptionKey,
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
        responseHashKey: responseHashKey,
        responseDecryptionKey: responseDecryptionKey,
        name: name,
        email: email,
        number: number,
        amount: amount,
        clientid: clientcodeok,
        address: address);
  }

  _getEncryptedPayUrl(
      {required BuildContext context,
      required String responseHashKey,
      required String responseDecryptionKey,
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
        log('200');
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
                    '{"atomTokenId" : "$_atomTokenId","merchId": "$login","emailId": $email,"mobileNumber":$number, "returnUrl":"$returnUrl"}';
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
    //     .whenComplete(() {
    //   _ispaymentprocessstarted = false;
    //   update();
    // });
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
        printUsbReceiptWindows(barcodes, s, "The online payment failed to process");
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
    payDetails['amount'] = '2';
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

  // void sendpaymentinfo({
  //   required int gazetteId,
  //   required String postalname,
  //   required String fulladdress,
  //   required String pincode,
  //   required int totalprice,
  //   required String enteredby,
  //   required String remark,
  // }) async {
  //   gettransactionid();
  //   log('1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111');
  //   try {
  //     final response = await http.post(
  //         Uri.parse('http://10.10.1.139:8099/api/Billings/MakePayment'),
  //         headers: {
  //           'Content-Type': 'application/json', // Set the Content-Type header
  //         },
  //         body: jsonEncode(
  //           {
  //             "gazetteId": gazetteId,
  //             "fullname": postalname,
  //             "fulladdress": fulladdress,
  //             "district": _postaldropdownvalue,
  //             "pincode": pincode,
  //             "totalprice": totalprice,
  //             "namebill": _billingnamecontroller.text,
  //             "addressbill": _billingaddresscontroller.text,
  //             "districtbill": _billingdropdownvalue,
  //             "pincodebill": _billingpincodecontroller.text,
  //             "enteredby": enteredby,
  //             "remark": remark,
  //             "transactionid": _transacid
  //           },
  //         ));

  //     if (response.statusCode == 200) {
  //       log('Done Post Successfully');
  //     } else {
  //       debugPrint('Failedrerer to Getdata.');
  //       //  _isserverok = false;
  //     }
  //     return null;
  //   } catch (e) {
  //     // _isserverok = false;

  //     log('init log $e');
  //   }
  // }

  // updatepaymentremark({
  //   required String transactionid,
  //   required String remark,
  // }) async {
  //   try {
  //     final queryParameters = {"transacid": transactionid};
  //     final response = await http.put(
  //       Uri.http(
  //           '10.10.1.139:8099', '/Billings/UpdatePayment', queryParameters), headers: {
  //       'Content-Type': 'application/json', // Set the Content-Type header
  //     },
  //       body: jsonEncode({
  //         "remark": remark,
  //       }),
  //     );

  //     if (response.statusCode == 200) {
  //       log('Done updated Successfully');
  //     } else {
  //       debugPrint('Failedrerer to Getdata.');
  //       //  _isserverok = false;
  //     }
  //     return null;
  //   } catch (e) {
  //     // _isserverok = false;

  //     debugPrint(e.toString());
  //   }
  // }
  updatepaymentremark(
      {required String transactionid,
      required String remark,
      required GlobalKey key,
      required String amount,
      required String paymentmethod}) async {
    _isdownloadedfile = null;
    update();

    try {
      debugPrint("In payment amount : $amount");
      Payment p = Payment(
          paymentId: transactionid,
          status: remark,
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

  /// G

  void gettransactionid(String transId) {
    _transacid = transId;
    update();
    debugPrint(_transacid);
  }

  // Downloadfile({required String trnxid}) async {
  //   _isdownloadedfile = false;
  //   update();

  //   try {
  //     final queryParameters = {"transacId": trnxid};
  //     final response = await http.get(
  //       Uri.http(
  //         '10.10.1.139:8099', // host and port
  //         '/api/gazettes/download', // path
  //         queryParameters, // query parameters
  //       ),
  //     );

  //     if (response.statusCode == 200) {
  //       const filePath = 'storage/emulated/0/Download/gazette_file.pdf';

  //       // Write the file to the document directory
  //       File file = File(filePath);
  //       await file.writeAsBytes(response.bodyBytes).then((value) {
  //         // NotificationService().showDownloadNotification(payLoad: value.path);
  //       });

  //       debugPrint('File downloaded to: $filePath');

  //       _isdownloadedfile = true;
  //       // ignore: use_build_context_synchronously
  //       update();

  //       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //           backgroundColor: Colors.green,
  //           content: Text('Downloaded File Successfully')));
  //     } else {
  //       _isdownloadedfile = null;
  //       update();

  //       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //           backgroundColor: Colors.red,
  //           content: Text('Download Fail Check Network')));
  //       debugPrint('Failedrerer to Getdata.');
  //       //  _isserverok = false;
  //     }
  //     return null;
  //   } catch (e) {
  //     _isdownloadedfile = null;
  //     update();
  //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //         backgroundColor: Colors.red,
  //         content: Text('Download Fail Newtwork Error')));
  //     // _isserverok = false;

  //     debugPrint(e.toString());
  //   }
  // }

  // checkdownloadpath() async {
  //   String downloadFolderPath = await getDownloadDirectoryPath();
  //   log('Download folder path: $downloadFolderPath');
  // }

  // getDownloadfile({required String trnxid}) async {
  //   final plugin = DeviceInfoPlugin();
  //   final android = await plugin.androidInfo;

  //   final status = android.version.sdkInt < 30
  //       ? await Permission.storage.request()
  //       : await Permission.manageExternalStorage.request();

  //   if (status.isGranted) {
  //     debugPrint("Storage permission granted");
  //     Downloadfile(trnxid: trnxid);
  //   } else if (status.isDenied) {
  //     debugPrint("Storage permission denied");
  //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //         backgroundColor: Colors.red,
  //         content: Text('Error Storage Permission Denied')));
  //   } else if (status.isPermanentlyDenied) {
  //     debugPrint("Storage permission permanently denied");
  //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //         backgroundColor: Colors.red,
  //         content: Text('Error Storage Permission Denied permanently')));
  //     // Consider showing a dialog or opening the app settings to enable the permission
  //   }
  // }

  // getDownloadReciept(
  //     {required String paymentname, required String amount}) async {
  //   final plugin = DeviceInfoPlugin();
  //   final android = await plugin.androidInfo;
  //   log('Android SDK Version :${android.version.sdkInt}');
  //   final status = android.version.sdkInt < 30
  //       ? await Permission.storage.request()
  //       : await Permission.manageExternalStorage.request();

  //   if (status.isGranted) {
  //     debugPrint("Storage permission granted");

  //     final imageFile =
  //         await getImageFileFromAssets('assets/images/reciept.png');
  //     final image = pw.MemoryImage(File(imageFile.path).readAsBytesSync());
  //     final pdf = pw.Document();

  //     // Add your desired widget to the PDF
  //     pdf.addPage(pw.Page(
  //       build: (pw.Context context2) {
  //         log('dsdsdsnew');
  //         return pw.Center(
  //           child: pw.Column(
  //             mainAxisAlignment: pw.MainAxisAlignment.center,
  //             children: [
  //               pw.Image(image, height: 150),
  //               pw.SizedBox(
  //                 height: 30,
  //               ),
  //               pw.Padding(
  //                   padding: const pw.EdgeInsets.symmetric(horizontal: 45),
  //                   child: pw.Container(
  //                       decoration: pw.BoxDecoration(border: pw.Border.all()),
  //                       width: MediaQuery.of(context).size.width,
  //                       padding: const pw.EdgeInsets.symmetric(horizontal: 20),
  //                       child: pw.Column(
  //                         children: [
  //                           pw.Text(
  //                             'Payment Reciept',
  //                             style: pw.TextStyle(
  //                               fontSize: 26,
  //                               fontWeight: pw.FontWeight.bold,
  //                             ),
  //                           ),
  //                           pw.SizedBox(height: 20),
  //                           pw.Row(
  //                             mainAxisAlignment:
  //                                 pw.MainAxisAlignment.spaceBetween,
  //                             children: [
  //                               pw.Text(
  //                                 'Payee Name: ',
  //                                 style: const pw.TextStyle(fontSize: 18),
  //                               ),
  //                               pw.Text(
  //                                 _billingnamecontroller.text,
  //                                 style: const pw.TextStyle(fontSize: 18),
  //                               ),
  //                             ],
  //                           ),
  //                           pw.SizedBox(height: 10),
  //                           pw.Row(
  //                             mainAxisAlignment:
  //                                 pw.MainAxisAlignment.spaceBetween,
  //                             children: [
  //                               pw.Text(
  //                                 'Amount Paid: ',
  //                                 style: const pw.TextStyle(fontSize: 18),
  //                               ),
  //                               pw.Text(
  //                                 amount,
  //                                 style: const pw.TextStyle(fontSize: 18),
  //                               ),
  //                             ],
  //                           ),
  //                           pw.SizedBox(height: 10),
  //                           pw.Row(
  //                             mainAxisAlignment:
  //                                 pw.MainAxisAlignment.spaceBetween,
  //                             children: [
  //                               pw.Text(
  //                                 'Transaction ID:',
  //                                 style: const pw.TextStyle(fontSize: 18),
  //                               ),
  //                               pw.Text(
  //                                 _transacid,
  //                                 style: const pw.TextStyle(fontSize: 18),
  //                               ),
  //                             ],
  //                           ),
  //                           pw.SizedBox(height: 10),
  //                           pw.Row(
  //                             mainAxisAlignment:
  //                                 pw.MainAxisAlignment.spaceBetween,
  //                             children: [
  //                               pw.Text(
  //                                 'Payment Method: ',
  //                                 style: const pw.TextStyle(fontSize: 18),
  //                               ),
  //                               pw.Text(
  //                                 paymentname,
  //                                 style: const pw.TextStyle(fontSize: 18),
  //                               ),
  //                             ],
  //                           ),
  //                           pw.SizedBox(height: 10),
  //                           pw.Row(
  //                             mainAxisAlignment:
  //                                 pw.MainAxisAlignment.spaceBetween,
  //                             children: [
  //                               pw.Text(
  //                                 'Transaction Date: ',
  //                                 style: const pw.TextStyle(fontSize: 18),
  //                               ),
  //                               pw.Text(
  //                                 transactiondate,
  //                                 style: const pw.TextStyle(fontSize: 18),
  //                               ),
  //                             ],
  //                           ),
  //                           pw.SizedBox(height: 10),
  //                         ],
  //                       )))
  //             ],
  //           ),
  //         );
  //       },
  //     ));

  //     // Save the PDF to a file
  //     const filePath = 'storage/emulated/0/Download/paymentreciept.pdf';
  //     final file = File(filePath);

  //     await file.writeAsBytes(await pdf.save()).then((value) {
  //       // NotificationService().showDownloadNotification(payLoad: value.path);
  //     });
  //   } else if (status.isDenied) {
  //     debugPrint("Storage permission denied");
  //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //         backgroundColor: Colors.red,
  //         content: Text('Error Storage Permission Denied')));
  //   } else if (status.isPermanentlyDenied) {
  //     debugPrint("Storage permission permanently denied");
  //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //         backgroundColor: Colors.red,
  //         content: Text('Error Storage Permission Denied permanently')));
  //     // Consider showing a dialog or opening the app settings to enable the permission
  //   }
  // }

  // Future<String> getDownloadDirectoryPath() async {
  //   Directory? externalDir = await getExternalStorageDirectory();
  //   if (externalDir != null) {
  //     return '${externalDir.path}/Download';
  //   } else {
  //     throw 'Could not access external storage directory';
  //   }
  // }

  // Future<File> getImageFileFromAssets(String path) async {
  //   final byteData = await rootBundle.load(path);

  //   final tempFile = File('${(await getTemporaryDirectory()).path}/$path');
  //   await tempFile.create(recursive: true);
  //   await tempFile.writeAsBytes(byteData.buffer.asUint8List(), flush: true);

  //   return tempFile;
  // }
}
