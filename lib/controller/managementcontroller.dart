import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:camera_windows_example/cons/printimages.dart';
import 'package:camera_windows_example/cons/utils.dart';
import 'package:camera_windows_example/controller/imagecapture.dart';
import 'package:camera_windows_example/controller/pagecontroller.dart';
import 'package:camera_windows_example/models/apicall.dart';
import 'package:camera_windows_example/models/apicallimpl.dart';
import 'package:camera_windows_example/models/ilpmodel.dart';
import 'package:camera_windows_example/models/permit.dart';
import 'package:camera_windows_example/models/permitprice.dart';
import 'package:camera_windows_example/widgets/paymentresultdialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../cons/constant.dart';
import '../models/gate.dart';
import '../models/paymentresponse.dart';
import '../models/permitverifymodel.dart';

class Managementcontroller extends GetxController {
  String gender = genders[0];
  ApiCall? apicall = ApicallImpl();
  String? state;
  String? purpose;
  bool isCheckFaces = false;
  String facesDetect = "";
  bool isLoading = false;
  List<PermitPriceModel> _allpermitprices = [];
  List<PermitPriceModel> get allpermitprices => _allpermitprices;
  VisitorEntry? _permit;
  VisitorEntry? get getPermit => _permit;
  // VisitorEntry? currentPermit;
  List<String> _docnames = [];
  List<String> get getDocNames => _docnames;
  PermitApplication? _applicid;
  PermitApplication? get applicid => _applicid;
  String? onlineAplicant;
  // Gate? _selectedGate;
  // Gate? get selectedGate => _selectedGate;
  List<Gate> _allGates = [];
  List<Gate> get getAllgate => _allGates;
  PaymentResponse? paymentresult;
  bool _ispressverified = false;
  bool get ispressverified => _ispressverified;
  bool isVeriflyloading = false;
  Timer? timer;
  bool isloading = false;
  PermitPriceModel? _permitPrice;
  PermitPriceModel? get getPermitPrice => _permitPrice;
  String? deviceId;
  String? gateId;
  String? ilpapi;
  String? printername;
  bool isdeviceCheck = false;
  bool isUserAlreadyexist = false;
  @override
  void onInit() {
    super.onInit();
    loadDatas();
  }

  Future<String> _getFilePath() async {
    return '${Directory.current.path}/config.txt';
  }

  Future<void> loadDatas() async {
    await loadDeviceConfig();
    await getpermitprice();
    await getallGates();
    await schedulerForGetdocs();
  }

  Future<void> loadDeviceConfig() async {
    isdeviceCheck = true;
    update();
    try {
      final path = await _getFilePath();
      final file = File(path);

      if (await file.exists()) {
        final lines = await file.readAsLines();

        for (var line in lines) {
          if (line.startsWith('device_id=')) {
            deviceId = line.split('=')[1];
          } else if (line.startsWith('gate_id=')) {
            gateId = line.split('=')[1];
          } else if (line.startsWith('printer=')) {
            printername = line.split('=')[1];
          }
        }
      }

      debugPrint('deviceId:  $deviceId');
      debugPrint('gateid:  $gateId');
      debugPrint('ilpapi:  $ilpapi');
      debugPrint('printername:  $printername');
    } catch (e) {
      debugPrint('Error loading config: $e');
    }

    isdeviceCheck = false;
    update();
  }

  void changeGender(String gen) {
    gender = gen;
    update();
  }

  void changePurpose(String purs) {
    purpose = purs;
    update();
  }

  void changeState(String stat) {
    state = stat;
    update();
  }

  void readPermit() {
    apicall!.readPermit();
  }

  void setOnlineApplId(String? s) {
    onlineAplicant = s;
    update();
  }

  String? validateAadhar(String? value) {
    log(value.toString());
    if (value == null || value.isEmpty) {
      return 'Aadhar number is required';
    }
    if (!RegExp(r'^\d{12}$').hasMatch(value)) {
      return 'Enter a valid 12-digit Aadhar number';
    }
    return null;
  }

  String? validatePAN(String? value) {
    if (value == null || value.isEmpty) {
      return 'PAN number is required';
    }
    if (!RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$').hasMatch(value)) {
      return 'Enter a valid PAN number (e.g., ABCDE1234F)';
    }
    return null;
  }

  String? isValidDrivingLicense(String? value) {
    if (value == null || value.isEmpty) {
      return 'Driving License number is required';
    }
    final regex = RegExp(r'^[A-Za-z]{2}\d{13}$');
    if (!regex.hasMatch(value)) {
      return "Enter a valid Driving license (e.g: MN0619981234567)";
    }
    return null;
  }

  String? isValidPassport(String? value) {
    if (value == null || value.isEmpty) {
      return 'Pssport ID is required';
    }
    final regex = RegExp(r'^[a-zA-Z0-9]+$');
    if (!(regex.hasMatch(value) && value.length > 6)) {
      return "Enter a valid ID. Must be > 6 letters and alphanumeric";
    }
    return null;
  }

  Future<void> getallGates() async {
    _allGates = await apicall!.getAllGates();

    // if (_allGates.isNotEmpty) {
    //   _selectedGate = _allGates.firstWhereOrNull(
    //     (element) => element.name == "Imphal Airport",
    //   );
    // }
    // print("Selected gate = ${_selectedGate?.id} ${_selectedGate?.name}}");
    update();
  }

  void setverifybuttonbool(bool isfinish) {
    _ispressverified = isfinish;
    update();
  }

  Future<Map<String, int>> verifydocid(
      {required String doctype, required String docid}) async {
    isVeriflyloading = true;
    String applicationId = '';
    int response = -1;
    update();
    try {
      var appid = await apicall!.verifydoc(doctype: doctype, idnumber: docid);
      response = appid['status'];
      print("INVERFIY DOC:$response");
      // print(" doctype: $doctype  dociDno.: $docid");
      // print("Appid : ${appid?.toJson().toString()}");
      if (appid['status'] == 200) {
        isUserAlreadyexist = true;
        _applicid = appid['data'];
        state = _applicid?.state;
        applicationId = _applicid!.applicationNo;
      }
    } catch (e) {
      applicationId = '';
      response = -1;
    }
    isVeriflyloading = false;
    update();
    print("in status of update: $response");
    return {applicationId: response};
  }

  Future<void> getallDocs() async {
    isloading = true;
    update();
    _docnames = await apicall!.getDocumentType();
    isloading = false;
    update();
  }

  Future<void> getallDocscheck() async {
    _docnames = await apicall!.getDocumentType();
    getpermitprice();
    getallGates();
    update();
  }

  Future<void> schedulerForGetdocs() async {
    await getallDocs();
    if (_docnames.isEmpty) {
      // start checking if the server is live periodically
      //to check if the server is down and check for if the server is okay and running
      timer = Timer.periodic(Duration(seconds: 4), (_) async {
        // print("in timers");
        if (_docnames.isNotEmpty) {
          if (timer != null) {
            timer!.cancel();
            // print("get timer cancel");
          }
        }
        await getallDocscheck();
      });
    } else {
      // print("no timer initialise");
    }
  }

  getpermitprice() async {
    // print("fdjhkfh");
    _allpermitprices = await apicall!.getallpremitprice();
    _allpermitprices.map((e) => print(" permit prices : ${e.toJson()} "));
    _permitPrice = _allpermitprices.firstWhereOrNull(
      (element) => element.permitName.toLowerCase().contains("temporary"),
    );
    // print("_permit : ${_permitPrice?.toJson()}");
    update();
  }

  //get document verification details from api
  Future<void> getDocumentDetails(
      {required String docID, required String docType}) async {
    //fetch doc from api
    _permit = VisitorEntry(idProof: docType, idNo: docID);

    update();
  }

  Future<Map<String, dynamic>> addtemporaryPermit(
    bool isCash,
    Uint8List passport,
    Uint8List idcard,
    Uint8List signature,
  ) async {
    try {
      _permit!.transactionId = isCash ? "CASH" : generateRandomString(12);
      _permit!.amount = _permitPrice!.fee.toString();
      _permit!.deviceId = deviceId!;

      if (_applicid != null && _applicid!.applicationNo.isNotEmpty) {
        Map<String?, dynamic> ds = await apicall!.updatePermit(
            passport, idcard, signature, _permit!, _applicid!.applicationNo);
        // print('$ds $isLoading');
        String? appid = ds["applicationId"];
        var orderid = ds["orderId"];
        _permit!.transactionId = isCash ? "CASH" : ds['transactionId'];
        String? message = ds['message'];
        onlineAplicant = appid;
        update();
        return ds.entries.first.value == 0
            ? {}
            : ds.entries.first.value == 409
                ? {
                    'message':
                        "A permit has already been issued to the applicant and cannot be issued again"
                  }
                : {'appid': appid, 'orderid': orderid};
      } else {
        Map<String?, dynamic> ds =
            await apicall!.addPermit(passport, idcard, signature, _permit!);
        // print('$ds $isLoading');
        String? appid = ds["applicationId"];
        var orderid = ds["orderId"];
        _permit!.transactionId = ds['transactionId'];
        onlineAplicant = appid;
        // currentPermit = _permit;
        update();
        // log('Return Orderid map : ' + ds.toString());
        return ds.entries.first.value == 0
            ? {}
            : ds.entries.first.value == 409
                ? {
                    'message':
                        "A permit has already been issued to the applicant and cannot be issued again"
                  }
                : {'appid': appid, 'orderid': orderid};
      }
    } catch (e) {
      return {};
    }
  }

  void addPermit(VisitorEntry? permits) {
    _permit = permits;
    update();
  }

  Future<Uint8List> getImageAssetBytes(String assetPath) async {
    // Load the asset as bytes from memory
    ByteData byteData = await rootBundle.load(assetPath);
    return byteData.buffer.asUint8List();
  }

  void fetchPermitById(String permitnnum) async {
    update();
    Map<String, IlPmodel?> x = await apicall!.fetchPermitData(permitnnum);
    update();
  }

  Future<void> addPayments(Payment pays, GlobalKey key) async {
    try {
      Payment payment = Payment(
          paymentId: pays.paymentId,
          method: pays.method,
          status: pays.status,
          amount: pays.amount,
          processingfee: pays.processingfee,
          deviceId: int.tryParse(deviceId!) ?? 0,
          gateId: int.tryParse(gateId!));
      // print(payment.toJson().toString());

      PaymentResponse? payres = await apicall!.sendPayment(payment);

      if (payres != null) {
        paymentresult = payres;
        update();

        Get.dialog(
            barrierDismissible: pays.status.toLowerCase() != 'success',
            Dialog(
              child: PaymentResultDialog(
                amount: pays.amount,
                isSuccess: pays.status.toLowerCase() == 'success',
                callback: () async {},
              ),
            ));
        if (payres.permitNo != null && payres.permitNo!.isNotEmpty) {
          await Future.delayed(Duration(milliseconds: 2000));
          await Get.find<Imagecontroller>()
              .saveReceiptimages(key, printername ?? "CUSTOM K80");
          Future.delayed(Duration(milliseconds: 2000));
          Get.back();
          Get.find<PagenavControllers>().setmainpageindex(ind: 5);
        } else {
          printUsbReceiptWindowsonline(onlineAplicant ?? "", "",
              {payres.transactionId ?? "": payres.date ?? ""},
              deviceId: deviceId ?? '',
              printername: printername ?? "CUSTOM K80");
          Get.find<PagenavControllers>().setmainpageindex(ind: 6);
        }
      } else {
        printUsbReceiptWindowsonline(onlineAplicant ?? "", "",
            {pays.paymentId: DateFormat('dd/MM/yyyy').format(DateTime.now())},
            printername: printername ?? "CUSTOM K80", deviceId: deviceId ?? '');
        Get.find<PagenavControllers>().setmainpageindex(ind: 6);
      }

      update();
    } catch (e) {
      printUsbReceiptWindowsonline(onlineAplicant ?? "", "",
          {pays.paymentId: DateFormat('dd/MM/yyyy').format(DateTime.now())},
          printername: printername ?? "CUSTOM K80", deviceId: deviceId ?? '');
      Get.find<PagenavControllers>().setmainpageindex(ind: 6);
    }
  }

  void disposeAll() {
    gender = genders[0];
    state = null;
    purpose = null;
    isCheckFaces = false;
    facesDetect = "";
    isLoading = false;
    isLoading = false;
    onlineAplicant = null;
    _permit = null;
    paymentresult = null;
    // currentPermit = null;
    _applicid = null;
    isUserAlreadyexist = false;
  }
}
