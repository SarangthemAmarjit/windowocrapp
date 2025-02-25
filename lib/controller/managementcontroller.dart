import 'dart:developer';

import 'package:camera_windows_example/cons/printimages.dart';
import 'package:camera_windows_example/cons/utils.dart';
import 'package:camera_windows_example/models/apicall.dart';
import 'package:camera_windows_example/models/apicallimpl.dart';
import 'package:camera_windows_example/models/ilpmodel.dart';
import 'package:camera_windows_example/models/permit.dart';
import 'package:camera_windows_example/models/permitprice.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../cons/constant.dart';
import '../models/gate.dart';
import '../widgets/receiptpermit.dart';

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

  List<String> _docnames = [];
  List<String> get getDocNames => _docnames;

  String _applicid = '';
  String get applicid => _applicid;

  Gate? _selectedGate;
  Gate? get selectedGate => _selectedGate;

  List<Gate> _allGates = [];
  List<Gate> get getAllgate => _allGates;

  bool _ispressverified = false;
  bool get ispressverified => _ispressverified;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getpermitprice();
    getallGates();
    getallDocs();
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

  Future<void> getallGates() async {
    _allGates = await apicall.getAllGates();
    if (_allGates.isNotEmpty) {
      _selectedGate = _allGates.firstWhereOrNull(
        (element) => element.name == "Imphal Airport",
      );
    }
    Future<void> getallGates() async {
      _allGates = await apicall.getAllGates();
      if (_allGates.isNotEmpty) {
        _selectedGate = _allGates.firstWhereOrNull(
          (element) => element.name == "Imphal Airport",
        );
      }

      update();
    }

    update();
  }

  void verifydocid({required String doctype, required String docid}) async {
    var appid = await apicall.verifydoc(doctype: doctype, idnumber: docid);

    _applicid = appid;
    update();
  }

  Future<void> getallDocs() async {
    _docnames = await apicall.getDocumentType();
    update();
  }

  getpermitprice() async {
    var allprice = await apicall.getallpremitprice();
    _allpermitprices = permitPriceModelFromJson(allprice);
    update();
  }

  //get document verification details from api
  Future<void> getDocumentDetails(
      {required String docID, required String docType}) async {
    isLoading = true;
    update();
    //fetch doc from api
    _permit = VisitorEntry(idProof: docType, idNo: docID);
    isLoading = false;
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
        category: "General",
        purposeVisit: purposeVisits,
        placeOfStay: placestay,
        visitDate: DateTime(visitDates.year, visitDates.month, visitDates.day)
            .toIso8601String(),
        // visitDate: visitDates,
        applcntName: name,
        applcntParent: parentname,
        applcntGender: gender,
        applcntDOB: DateTime.now().toIso8601String(),
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
        amount: '100',
        lrName: localres,
        nearestPS: localnearestpol,
        // transactionId:"Cash"
        transactionId: isCash ? "CASH" : generateRandomString(12));
    print(" permit to post: ${dummyVisitor.toJson().toString()}");

    Map<String?, dynamic> ds =
        await apicall.addPermit(passport, idcard, signature, dummyVisitor);
    print('$ds $isLoading');
    if (isCash) {
      //dialog for printing cash payments and going to counter
      Get.dialog(AlertDialog(
        content: Text(ds.entries.first.value ?? "no messae"),
      ));

      //ffhdjf

      // printImageDirectly("Microsoft Print to PDF",);
      // printUsbReceiptWindows(passport,ds.entries.first.value);
    }

    return ds.entries.first.value;
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
}
