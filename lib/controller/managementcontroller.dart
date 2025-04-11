import 'dart:async';
import 'dart:developer';

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

import '../cons/constant.dart';
import '../home/landingpage.dart';
import '../models/gate.dart';
import '../models/paymentresponse.dart';
import '../models/permitverifymodel.dart';

class Managementcontroller extends GetxController {
  String gender = genders[0];
  final ApiCall apicall = ApicallImpl();
  String? state;
  String? purpose;
  bool isCheckFaces = false;
  String facesDetect = "";
  bool isLoading = false;
  List<PermitPriceModel> _allpermitprices = [];
  List<PermitPriceModel> get allpermitprices => _allpermitprices;
  VisitorEntry? _permit;
  VisitorEntry? get getPermit => _permit;
  VisitorEntry? currentPermit;

  List<String> _docnames = [];
  List<String> get getDocNames => _docnames;

  PermitApplication?_applicid;
  PermitApplication? get applicid => _applicid;
  String? onlineAplicant;
  Gate? _selectedGate;
  Gate? get selectedGate => _selectedGate;

  List<Gate> _allGates = [];
  List<Gate> get getAllgate => _allGates;
  PaymentResponse? paymentresult;
  bool _ispressverified = false;
  bool get ispressverified => _ispressverified;
  bool isVeriflyloading = false;
  Timer?  timer;
  bool isloading =false;
  PermitPriceModel? _permitPrice;
  PermitPriceModel?  get getPermitPrice=>  _permitPrice;
  @override
  void onInit() {
    super.onInit();
    getpermitprice();
    getallGates();
    schedulerForGetdocs();
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
    apicall.readPermit();
  }

  void setOnlineApplId(String? s){
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
 if( !regex.hasMatch(value)){
  return "Enter a valid Driving license (e.g: MN0619981234567)";
 }
 return null;
  
}


String? isValidPassport(String? value) {
      if (value == null || value.isEmpty) {
      return 'Pssport ID is required';
    }
  final regex = RegExp(r'^[a-zA-Z0-9]+$');
  if(! (regex.hasMatch(value) && value.length > 6)){
     return "Enter a valid ID. Must be > 6 letters and alphanumeric"; 
  }
  return null;
}

  Future<void> getallGates() async {
    _allGates = await apicall.getAllGates();

    if (_allGates.isNotEmpty) {
      _selectedGate = _allGates.firstWhereOrNull(
      
        (element) => element.name == "Imphal Airport",
      );

  
    }
          print("Selected gate = ${_selectedGate?.id } ${_selectedGate?.name}}");
    update();
  }

  void setverifybuttonbool(bool isfinish) {
    _ispressverified = isfinish;
    update();
  }



  Future<String> verifydocid(
      {required String doctype, required String docid}) async {
    isVeriflyloading = true;
    update();
    try {
      var appid = await apicall.verifydoc(doctype: doctype, idnumber: docid);
      print(" doctype: $doctype  dociDno.: $docid");
      print("Appid : ${appid?.toJson().toString()}");
      _applicid = appid;
      state = _applicid?.state; 
      isVeriflyloading = false;
      update();
      return _applicid!.applicationNo;
    } catch (e) {
      print(e);
      _applicid = null;
    }
    isVeriflyloading = false;
    update();
    return '';
  }




  Future<void> getallDocs() async {
    isloading = true;
    update();
    _docnames = await apicall.getDocumentType();
    isloading = false;
    update();
  }

  Future<void> getallDocscheck() async {
    _docnames = await apicall.getDocumentType();
    update();
  }

    Future<void> schedulerForGetdocs() async {
      await getallDocs();
      if(_docnames.isEmpty){
        // start checking if the server is live periodically
      //to check if the server is down and check for if the server is okay and running
        timer = Timer.periodic(Duration(seconds: 4), (_) async {
            print("in timers");
          if(_docnames.isNotEmpty){
            if(timer!=null){
              timer!.cancel();
              print("get timer cancel");
            }
          }
             await getallDocscheck();
        });

      }else{
        print("no timer initialise");
      }

    }


  getpermitprice() async {
    print("fdjhkfh");
   _allpermitprices = await apicall.getallpremitprice();
    _allpermitprices.map((e) =>print(" permit prices : ${e.toJson()} "));   
    _permitPrice = _allpermitprices.firstWhereOrNull((element) => element.permitName.toLowerCase().contains("temporary"),);
    print("_permit : ${_permitPrice?.toJson()}");
    update();
  }

  //get document verification details from api
  Future<void> getDocumentDetails(
      {required String docID, required String docType}) async {

    //fetch doc from api
    _permit = VisitorEntry(idProof: docType, idNo: docID);
   
    update();
  }



  Future<String?> addtemporaryPermit(
      bool isCash, Uint8List passport, Uint8List idcard, Uint8List signature,
      {required String idProofs,
      required String idno,
      required String purposeVisits,
      required String placestay,
      required DateTime visitDates,
      required String name,
      required String parentname,
      required String gender,
      required String dob,
      required String email,
      required String mobile,
      required String address,
      required String state,
      required String polstation,
      required String districtss,
      required String village,
      required String tehsl,
      required String applydistrict,
      required String pincode,
      required String localres,
      required String localnearestpol}) async {
    VisitorEntry dummyVisitor = VisitorEntry(
        // idProof: "Aadhar",
        idProof: idProofs,
        idNo: idno,
        category: purpose,
        purposeVisit: purposeVisits,
        placeOfStay: placestay,
        visitDate:DateTime.now().toIso8601String(),
        // visitDate: visitDates,
        applcntName: name,
        applcntParent: parentname,
        applcntGender: gender,
        applcntDOB: dob,
        applcntEmail: email,
        applcntMobile: mobile,
        applcntAddress: address,
        applcntState: state,
        applcntPoliceStation: polstation,
        applcntDistrict: districtss,
        applcntVillage: village,
        applcntHNo: "",
        applcntTehsil: tehsl,
        gateID: _selectedGate?.id ?? "",
        entryType: "Online",
        applyDistrictID: "",
        residingPeriod: "30",
        landmark: "",
        district: applydistrict,
        pinCode: pincode,
        amount: _permitPrice?.fee.toString(),
        lrName: localres,
        nearestPS: localnearestpol,
        // transactionId:"Cash"
        transactionId: isCash ? "CASH" : generateRandomString(12));
        _permit!.transactionId = isCash ? "CASH" : generateRandomString(12);
        _permit!.amount = _permitPrice?.fee.toString();
        // print(":::::::::::");
        // print("TransactionID ::: ${_permit?.transactionId} ${_applicid?.applicationNo} ");
        // print(":::::::::::");
     
     
      _permit!.transactionId = dummyVisitor.transactionId;
   
      
    print(" permit to post: ${_permit?.toJson().toString()}");
    currentPermit = _permit;
    update();
    

    if(_applicid!=null && _applicid!.applicationNo.isNotEmpty){
  Map<String?, dynamic> ds = await apicall.updatePermit(passport, idcard, signature, _permit!,_applicid!.applicationNo);
     print('$ds $isLoading');
   return ds.entries.first.value==0?null:ds.entries.first.value;
    }else{
 Map<String?, dynamic> ds =
        await apicall.addPermit(passport, idcard, signature, _permit!);
    print('$ds $isLoading');
return ds.entries.first.value==0?null:ds.entries.first.value;
    }

  }

  void addPermit(VisitorEntry? permits) {
    _permit = permits;
    update();
  }

  void removePermits() {
    _permit = null;
  }

  Future<Uint8List> getImageAssetBytes(String assetPath) async {
    // Load the asset as bytes from memory
    ByteData byteData = await rootBundle.load(assetPath);
    return byteData.buffer.asUint8List();
  }

  Future<void> detectFaces(Uint8List face) async {
    print("Capturing and checking datas . Sending API");
    isCheckFaces = true;
    facesDetect = "";
    update();

    Map<String, dynamic> res = await apicall.detectFaces(face);
    facesDetect = res.entries.first.value.toString();
    isCheckFaces = false;
    update();
  }

  void fetchPermitById(String permitnnum) async {
    // isFetchPermit = true;
    // currentPermit = permit;
    update();
    Map<String, IlPmodel?> x = await apicall.fetchPermitData(permitnnum);
    // _currentPermitData = x.entries.first.value;

    // fetchPermitmessage = x.entries.first.key;
    // isFetchPermit = false;
    // _addressloc = await getAddressFromLatLng(
    //     double.tryParse(permit.latitude ?? '') ?? 0,
    //     double.tryParse(permit.longitude ?? '') ?? 0);

    update();
    // log("_currentPermitData : " +
    //     _currentPermitData!.applicantCategory.toString());
  }

  Future<void> addPayments(Payment pays,GlobalKey key)async{
  

    PaymentResponse? payres =   await apicall.sendPayment(pays);
   
    if(payres!=null && payres.permitNo.isNotEmpty){
         paymentresult = payres;
         update();
      
          Get.dialog(
        barrierDismissible:pays.status.toLowerCase() !='success',
          Dialog( 
          
            child: PaymentResultDialog(isSuccess: pays.status.toLowerCase()=='success', callback: () async {
   

           },),));
       if(payres.permitNo.isNotEmpty){

 
  await Future.delayed(Duration(milliseconds: 2000));
  
    
    await Get.find<Imagecontroller>().saveReceiptimages(key);
    Future.delayed(Duration(milliseconds: 2000));
    Get.back();
    Get.find<PagenavControllers>().setmainpageindex(ind:5);
                            Get.offAll(()=>LandingPage());
  
  }else{
    printUsbReceiptWindowsonline( onlineAplicant??"",payres?.permitNo??"");


     Get.find<PagenavControllers>().setmainpageindex(ind:6);
     Get.offAll(()=>LandingPage());
    }
      setOnlineApplId(null);

  }else{
    printUsbReceiptWindowsonline( onlineAplicant??"",payres?.permitNo??"");
     setOnlineApplId(null);
      Get.find<PagenavControllers>().setmainpageindex(ind:6);
     Get.offAll(()=>LandingPage());
    }
  
    update();
  }

  void disposeAll() {
    gender = genders[0];
    state = null;
    purpose = null;
    isCheckFaces = false;
    facesDetect = "";
    isLoading = false;
    onlineAplicant = null;
    _permit = null;
    paymentresult = null;
    currentPermit = null;
    _applicid = null;
  }
}
