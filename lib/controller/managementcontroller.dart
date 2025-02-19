import 'package:camera_windows_example/cons/utils.dart';
import 'package:camera_windows_example/models/apicall.dart';
import 'package:camera_windows_example/models/apicallimpl.dart';
import 'package:camera_windows_example/models/permit.dart';
import 'package:camera_windows_example/models/permitprice.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../cons/constant.dart';
import '../models/gate.dart';

class Managementcontroller extends GetxController{
  
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
  VisitorEntry? get getPermit=> _permit;
  List<String> _docnames = [];
  List<String> get getDocNames =>_docnames;
  Gate? _selectedGate;
  Gate? get selectedGate=>_selectedGate;
  List<Gate> _allGates = [];
  List<Gate>  get getAllgate => _allGates;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
getallGates();
getallDocs();

  }
    void changeGender(String gen){
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

    void readPermit(){
        apicall.readPermit();

    }


  

    Future<void> getallGates()async{
        _allGates = await apicall.getAllGates();
        if(_allGates.isNotEmpty){

          _selectedGate = _allGates.firstWhereOrNull((element) => element.name =="Imphal Airport",);
        }

        update();
    } 




    Future<void> getallDocs()async{
        _docnames = await apicall.getDocumentType();
        update();
    } 
    //get document verification details from api
    Future<void>  getDocumentDetails({required String docID,required String docType})async{
      isLoading = true;
      update();
      //fetch doc from api
      _permit = VisitorEntry(idProof: docType,idNo: docID);  
      isLoading = false;
      update();

    }


    Future<void> addtemporaryPermit(bool isCash) async {
  
//       VisitorEntry dummyVisitor = VisitorEntry(
//   // idProof: "Aadhar",
//   idProof:"sdsfd",
//   idNo: "1234-5678-91992",
//   category: "General",
//   purposeVisit: "Tourism",
//   placeOfStay: "Hotel XYZ",
//   visitDate: "2025-02-19",
//   applcntName: "John Doe",
//   applcntParent: "Robert Doe",
//   applcntGender: "Male",
//   applcntDOB: DateTime.now().toIso8601String(),
//   applcntEmail: "johndoe@example.com",
//   applcntMobile: "9876543210",
//   applcntAddress: "123 Main Street",
//   applcntState: "Manipur",
//   applcntPoliceStation: "Imphal PS",
//   applcntDistrict: "Imphal West",
//   applcntVillage: "Nagamapal",
//   applcntHNo: "12A",
//   applcntTehsil: "Imphal",
//   gateID: "7",
//   entryType: "Visitor",
//   applyDistrictID: "D123",
//   residingPeriod: "7 Days",
//   landmark: "Near City Tower",
//   district: "Imphal West",
//   pinCode: "",
//   amount: '100',
//   // transactionId:"Cash" 
//     transactionId:generateRandomString(12)
// );
//   // print("Permits : ${permit.toJson().toString() }");
 


_permit?.amount = "100";
_permit?.transactionId = generateRandomString(12);
print(" permit to post: ${_permit!.toJson().toString()}");

        String passportpath = 'assets/images/Kanglashanew1.png';
        String idcardpath = 'assets/images/Kanglashanew1.png';
        Uint8List passport = await getImageAssetBytes(passportpath);
        Uint8List idcard = await getImageAssetBytes(idcardpath);
        Map<String?,dynamic> d =  await apicall.addPermit(_permit!,passport,idcard);
       
 
         print('$d $isLoading');

         Get.dialog(AlertDialog(content: Text(d.entries.first.key??"no messae"),));
        
   }

   Future<void> paywithcash(VisitorEntry permit) async {
        String passportpath = 'assets/images/Kanglashanew1.png';
        String idcardpath = 'assets/images/Kanglashanew1.png';
        Uint8List passport = await getImageAssetBytes(passportpath);
        Uint8List idcard = await getImageAssetBytes(idcardpath);
        Map<String,dynamic> d =  await apicall.addPermit(permit,passport,idcard);
        print('$d $isLoading');
    }
    

  void addPermit (VisitorEntry? permits){
        _permit = permits;
        update();
  }
    
  void removePermits(){
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
}
