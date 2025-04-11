import 'dart:developer';

import 'package:camera_windows_example/cons/constant.dart';
import 'package:camera_windows_example/cons/utils.dart';
import 'package:camera_windows_example/controller/managementcontroller.dart';
import 'package:camera_windows_example/controller/imagecapture.dart';
import 'package:camera_windows_example/controller/pagecontroller.dart';
import 'package:camera_windows_example/home/registrationpages/ilpformreplica.dart';
import 'package:camera_windows_example/models/permit.dart';
import 'package:camera_windows_example/widgets/customkeys.dart';
import 'package:camera_windows_example/widgets/receiptpermit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

class DocumentScanPage extends StatefulWidget {
  const DocumentScanPage({super.key});

  @override
  State<DocumentScanPage> createState() => _DocumentScanPageState();
}

class _DocumentScanPageState extends State<DocumentScanPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Get.find(Managementcontroller());
  }

  @override
  void dispose() {
   
    Get.find<PagenavControllers>().changeIdSelectionnoUpdate();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    PagenavControllers pagecon = Get.find<PagenavControllers>();

    return GetBuilder<Managementcontroller>(builder: (mngctrl) {
      return GetBuilder<PagenavControllers>(builder: (_) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  'Document Type Selection for Registration',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ).animate().fadeIn(),
                const SizedBox(height: 8),
                pagecon.IdSelection
                    ? Text(
                        'Please type in your Identification number.',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      ).animate().fadeIn().slideY(
                        begin: 0.5,
                        end: 0,
                        curve: Curves.easeIn,
                        duration: Duration(milliseconds: 700))
                    : Text(
                        'Choose the type of ID document you want to use for registration.',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      )
                        .animate()
                        .fadeIn()
                        .slideY(begin: 0.5, end: 0, curve: Curves.easeIn),
                const SizedBox(height: 100),
                pagecon.IdSelection
                    ? GetDocumentId()
                    : GridView.builder(
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 50,
                          mainAxisSpacing: 100,
                          childAspectRatio: 3.8,
                        ),
                        itemCount: mngctrl.getDocNames.length,
                        itemBuilder: (context, index) {
                          return _buildButton(
                                  context, mngctrl.getDocNames[index], index)
                              .animate()
                              .fadeIn(
                                  delay: Duration(milliseconds: index * 200))
                              .scaleXY(begin: 0.5, end: 1);
                        },
                      ),

                // const SizedBox(height: 100),
                // const Text(
                //   'Place the selected document on the scanning pad, ensuring it is clear and fully visible for a successful scan.',
                //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                //   textAlign: TextAlign.center,
                // ),
                const SizedBox(height: 100),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (pagecon.IdSelection) {
                        pagecon.changeIdSelection();
                        //return to front page if not active for 30 seconds
                      } else {
                        pagecon.setmainpageindex(ind: 0);
                        //return to front page if not active for 30 seconds
                      }
                      pagecon.listenPageChange();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 0, 183, 234),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 60, vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        const Text('Back', style: TextStyle(fontSize: 20)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      });
    });
  }

  Widget _buildButton(BuildContext context, String text, int docindex) {
    PagenavControllers pagecon = Get.find<PagenavControllers>();
    Managementcontroller mngctrl = Get.find<Managementcontroller>();
    Imagecontroller imgcon = Get.find<Imagecontroller>();

    return ElevatedButton(
      onPressed: () {
        pagecon.changeIdSelection();
        pagecon.setdocindex(ind: docindex);
        // pagecon.setmainpageindex(ind: 3);
        mngctrl.getDocumentDetails(docID: "", docType: text);

        //return to front page if not active for 30 seconds
        pagecon.listenPageChange();
        // imgcon.initializeCamera(
        //   isfront: true,
        //   isback: false,
        //   isprofilecam: false,
        // );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 0, 66, 234),
        foregroundColor: Colors.white,
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 25),
      ),
    );
  }
}

class GetDocumentId extends StatefulWidget {
  const GetDocumentId({
    super.key,
  });

  @override
  State<GetDocumentId> createState() => _GetDocumentIdState();
}

class _GetDocumentIdState extends State<GetDocumentId> {
  final TextEditingController docIdController = TextEditingController();
  final TextEditingController aadharotpController = TextEditingController();
  final FocusNode docFocus = FocusNode();
  final FocusNode otpFocus = FocusNode();
  final _formKey = GlobalKey<FormState>();
  final _formKeyotp = GlobalKey<FormState>();
  final GlobalKey _globlkey = GlobalKey();
  bool? isEmpty;
  bool isLoading = false;
  bool iskeyboardAlpha = true;
  bool isOtpscreen  = false;
  @override
  void initState() {
    super.initState();
    docFocus.requestFocus();
    String? s = Get.find<Managementcontroller>().getPermit!.idProof;
    if (s != null && s == "Aadhaar Card") {
      iskeyboardAlpha = false;
    }
  }

  void _onKeyTap(String key, int docind) {
    if (docind == 0) {
      if (docIdController.text.length < 12) {
        docIdController.text += key;
      }
    } else {
      docIdController.text += key;
    }
  }

    void _onKeyTapOtp(String key) {
   
      if (aadharotpController.text.length < 6) {
       aadharotpController.text += key;
      }
    
  }

  void _onBackspace() {
    final controller = docIdController;
    if (controller.text.isNotEmpty) {
      controller.text =
          controller.text.substring(0, controller.text.length - 1);
    }
  }

    void _onBackspaceotp() {
  
    if (aadharotpController.text.isNotEmpty) {
      aadharotpController.text =
          aadharotpController.text.substring(0, aadharotpController.text.length - 1);
    }
  }

  @override
  void dispose() {
    docIdController.dispose();
    aadharotpController.dispose();
    otpFocus.dispose();
    docFocus.dispose(); // Hide keyboard when the screen starts
    FocusManager.instance.primaryFocus?.unfocus();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Imagecontroller imgcon = Get.put(Imagecontroller());
    return GetBuilder<PagenavControllers>(builder: (pagectrl) {
      return GetBuilder<Managementcontroller>(builder: (mngctrl) {
        return AnimatedContainer(
          duration: Duration(milliseconds: 1000),
          height: pagectrl.IdSelection ? 800 : 0,
          width: double.maxFinite,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Colors.blue,
                Colors.blue.withValues(alpha: 0.2),
                Colors.blue.withValues(alpha: 0.0)
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
              // border: Border(
              //     top: BorderSide(color: Colors.white.withValues(alpha: 0.5)),
              //     right: BorderSide(color: Colors.white.withValues(alpha: 0.5)),
              //     left: BorderSide(color: Colors.white.withValues(alpha: 0.5))),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16), topRight: Radius.circular(16))),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child:isOtpscreen?Column(
             crossAxisAlignment: CrossAxisAlignment.center,
              children: [
               Row(
                
                 children: [
             
                   Expanded(
                     child: Center(
                       child: Text(
                          "Enter 6 Digit OTP",
                          style: TextStyle(color: Colors.white, fontSize: 24),
                        ),
                     ),
                   ),
                  
                    IconButton(onPressed: (){
                      setState(() {
                        isOtpscreen = false;
                        aadharotpController.clear();
                      });
                    }, icon:Icon(Icons.close,color: Colors.white,))
                 ],
               ),
                 SizedBox(
                  height: 20,
                ),
                SizedBox(
                    width: 600,
                    child: Form(
                      key: _formKeyotp,
                      child: TextFieldWidget(
                        counter:6,
                        errorSize: 24,
                        focusnode: otpFocus,
                        keytype: pagectrl.docindex == 0
                            ? TextInputType.number
                            : null,
                        fontSize: 30,
                        contentpadding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                        
                        controller: aadharotpController,
                        label: "OTP",
                        validator:(v){
                         if(v!=null && v.length==6 && v.isNumericOnly ){
                          return null;
                         }
                         return "OTP must be 6 digits";
                        }
                      ),
                    )),
                    SizedBox(height: 20,),
                   Text(
                        "*** A six digit OTP is sent to the mobile number link with your Aadhar",
                        style: TextStyle(color: Colors.grey[800], fontSize: 18),
                      ),
          SizedBox(height: 20,),
            Container(
                    // height: 400,
                    child: CustomKeyboard(
                  onKeyTap: (p0) {
                    _onKeyTapOtp(p0);
                  },
                  onBackspace: _onBackspaceotp,
                  onToggle: () {},
                  isAlpha: iskeyboardAlpha,
                  isCapital: true,
                )),
                      SizedBox(height: 20,),
                    ElevatedButton(onPressed: (){
                            if(_formKeyotp.currentState!.validate()){
                                //send otp and dss
                                pagectrl.setmainpageindex(ind: 2);
                            }

                    }, child:  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Verify",
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        mngctrl.isVeriflyloading
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: Center(
                                        child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ))),
                              )
                            : Icon(
                                Icons.check,
                                size: 30,
                                color: Colors.white,
                              )
                      ],
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 0, 66, 234),
                    foregroundColor: Colors.white,
                    textStyle: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),),
                    )
              ],
            ) : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Enter ${mngctrl.getPermit?.idProof ?? "Doucment"} Number",
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                    width: 600,
                    child: Form(
                      key: _formKey,
                      child: TextFieldWidget(
                        counter: mngctrl.getPermit?.idProof == "Aadhaar Card"
                            ? 12
                            : null,
                        errorSize: 24,
                        keytype: pagectrl.docindex == 0
                            ? TextInputType.number
                            : null,
                        fontSize: 30,
                        contentpadding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                        focusnode: docFocus,
                        controller: docIdController,
                        label: mngctrl.getPermit?.idProof ?? "Doc Id",
                        validator: pagectrl.docindex == 0
                            ? mngctrl.validateAadhar
                            : pagectrl.docindex == 2
                                ? mngctrl.validatePAN
                                :pagectrl.docindex==1?mngctrl.isValidDrivingLicense:mngctrl.isValidPassport,
                      ),
                    )),
                isEmpty == true
                    ? Text(
                        "Please enter a Valid Id Number",
                        style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      )
                    : SizedBox(),
                SizedBox(
                  height: 20,
                ),

                // SizedBox(
                //   height: 20,
                // ),
                // mngctrl.applicid != null
                //     ? RepaintBoundary(
                //         key: _globlkey,
                //         child: ReceiptWidget(
                //           applicantName: '',
                //           applicantId: mngctrl.applicid?.applicationNo ?? "",
                //         ))
                //     : SizedBox(),

                Container(
                    // height: 400,
                    child: CustomKeyboard(
                  onKeyTap: (p0) {
                    _onKeyTap(p0, pagectrl.docindex);
                  },
                  onBackspace: _onBackspace,
                  onToggle: () {},
                  isAlpha: iskeyboardAlpha,
                  isCapital: true,
                )),

                ElevatedButton(
                  onPressed: mngctrl.isVeriflyloading
                      ? null
                      : () async {

                          if (_formKey.currentState!.validate()) {
                            await mngctrl.verifydocid(
                                doctype: mngctrl.getPermit?.idProof ?? "",
                                docid: docIdController.text);
                    mngctrl.getDocumentDetails(
                                  docID: docIdController.text, docType:mngctrl.getPermit?.idProof ?? "" );
                              
                            // if the applicant already exists and the exit status is true
                            if (mngctrl.applicid == null ||
                                (mngctrl.applicid != null &&
                                    mngctrl.applicid!.statusExit != false)) {
                              if (mngctrl.applicid != null) {
                                mngctrl.addPermit(VisitorEntry(
                                  applcntDOB: mngctrl.applicid?.dob?.toIso8601String(),
                                  applcntDistrict:
                                      mngctrl.applicid?.district ?? "",
                                  applcntEmail: mngctrl.applicid?.email,
                                  applcntGender: mngctrl.applicid?.gender ?? "",
                                  applcntParent: mngctrl.applicid?.parentName,
                                  applcntMobile: mngctrl.applicid?.mobile,
                                  applcntPoliceStation:
                                      mngctrl.applicid?.policeStation,
                                  applcntName: mngctrl.applicid?.name,
                                  applcntHNo: mngctrl.applicid?.houseNo,
                                  idProof: mngctrl.getPermit?.idProof ?? "",
                                  idNo: docIdController.text,
                                  applcntState: mngctrl.applicid?.state,
                                  applcntTehsil: mngctrl.applicid?.tehsil,
                                  applcntVillage: mngctrl.applicid?.village,
                                  gateID: mngctrl.selectedGate?.id,
                                  entryType: "ONLINE",
                                  applcntAddress: mngctrl.applicid?.address,
                                ));
                             pagectrl.setmainpageindex(ind: 2);  
                              }else{
                                  if( mngctrl.getPermit?.idProof == "Aadhaar Card"){

                                        setState(() {
                                          isOtpscreen = true;
                                        });



                                  } else{

                                    pagectrl.setmainpageindex(ind: 2);
                                  }


                              }
                             
                            } else {
                              ///here is the exit status part if the user is not yet exited
                              ///instruct to go to the counter
                                      if (mngctrl.applicid != null) {
                                                    Get.dialog(AlertDialog(
                                                      content: RepaintBoundary(
                                                          key: _globlkey,
                                                          child: ReceiptWidget(
                                                              applicantName: mngctrl
                                                                      .getPermit
                                                                      ?.applcntName ??
                                                                  "NA",
                                                              applicantId: mngctrl.applicid!.applicationNo)),
                                                    ));}
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(
                                      'Applicant Already Exist',
                                      style: TextStyle(fontSize: 30),
                                    ),
                                    content: Text( 
                                      'You must first exit your Permit. Please ensure you have officially checked out before proceeding with a new application.',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('OK'),
                                      ),
                                    ],
                                  );
                                },
                              );

                              Future.delayed(Duration(seconds: 3)).then(
                                (value) async {
                                  print("nav Keys sdsd");
                                  await imgcon.saveReceipt(
                                      _globlkey,
                                      mngctrl.applicid?.applicationNo ?? "",
                                      // . Please ensure you have officially checked out before proceeding with a new application.
                                      "First exit your Permit");
                                  print("nav Keys");

                                  Get.back();
                                  Get.back();

                                  pagectrl.setmainpageindex(ind: 7);
                                },
                              );

                              /////dsadsadasd
                              log('already exist');
                              pagectrl.listenPageChange();
                            }
                          }
                          //   if (mngctrl.applicid!= null) {

                          //     String s = mngctrl.getPermit?.idProof ?? "";
                          //     mngctrl.getDocumentDetails(
                          //         docID: docIdController.text, docType: s);
                          //     pagectrl.setmainpageindex(ind: 2);
                          //     pagectrl.changeIdSelection();
                          //   } else {
                          //     // Get.dialog(AlertDialog(
                          //     //   content: RepaintBoundary(
                          //     //       key: _globlkey,
                          //     //       child: ReceiptWidget(
                          //     //           applicantName: '',
                          //     //           applicantId: mngctrl.applicid)),
                          //     // ));
                          //     showDialog(
                          //       context: context,
                          //       builder: (BuildContext context) {
                          //         return AlertDialog(
                          //           title: Text(
                          //             'Applicant Already Exist',
                          //             style: TextStyle(fontSize: 30),
                          //           ),
                          //           content: Text(
                          //             'Please collect the receipt and proceed to the counter for further processing.',
                          //             style: TextStyle(fontSize: 20),
                          //           ),
                          //           actions: [
                          //             TextButton(
                          //               onPressed: () {
                          //                 Navigator.of(context).pop();
                          //               },
                          //               child: Text('OK'),
                          //             ),
                          //           ],
                          //         );
                          //       },
                          //     );

                          //     Future.delayed(Duration(seconds: 2)).then(
                          //       (value) async {
                          //         print("nav Keys sdsd");
                          //         await imgcon.saveReceipt(
                          //             _globlkey, mngctrl.applicid?.applicationNo??"");
                          //         print("nav Keys");

                          //         Get.back();
                          //         Get.back();

                          //         pagectrl.setmainpageindex(ind: 7);
                          //       },
                          //     );

                          //     /////dsadsadasd
                          //     log('already exist');
                          //   }
                          // }
                          // pagectrl.listenPageChange();
                        },
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Verify",
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        mngctrl.isVeriflyloading
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: Center(
                                        child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ))),
                              )
                            : Icon(
                                Icons.check,
                                size: 30,
                                color: Colors.white,
                              )
                      ],
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 0, 66, 234),
                    foregroundColor: Colors.white,
                    textStyle: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ).animate().fadeIn();
      });
    });
  }
}
