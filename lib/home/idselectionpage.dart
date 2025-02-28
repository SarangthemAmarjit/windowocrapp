import 'dart:developer';

import 'package:camera_windows_example/cons/constant.dart';
import 'package:camera_windows_example/controller/managementcontroller.dart';
import 'package:camera_windows_example/controller/imagecapture.dart';
import 'package:camera_windows_example/controller/pagecontroller.dart';
import 'package:camera_windows_example/home/registrationpages/ilpformreplica.dart';
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
    Get.find<Managementcontroller>().applicidVerifynull();
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
                  pagecon.IdSelection? Text(
                  'Please type in your Identification number.',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ).animate().fadeIn().slideY(begin: 0.5,end: 0,curve: Curves.easeIn,duration: Duration(milliseconds: 700)) :  Text(
                  'Choose the type of ID document you want to use for registration.',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ).animate().fadeIn().slideY(begin: 0.5,end: 0,curve: Curves.easeIn),
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
  final FocusNode docFocus = FocusNode();
  final _formKey = GlobalKey<FormState>();
  bool? isEmpty;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    docFocus.requestFocus();
  }

  @override
  void dispose() {
    docIdController.dispose();
    docFocus.dispose();// Hide keyboard when the screen starts

    FocusManager.instance.primaryFocus?.unfocus();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey _globlkey = GlobalKey();
    Imagecontroller imgcon = Get.put(Imagecontroller());
    return GetBuilder<PagenavControllers>(builder: (pagectrl) {
      return GetBuilder<Managementcontroller>(builder: (mngctrl) {
        return AnimatedContainer(
          duration: Duration(milliseconds: 1000),
          height: pagectrl.IdSelection ? 500 : 0,
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
            child: Column(
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
                                : null,
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
                ElevatedButton(
                  onPressed: mngctrl.isVeriflyloading
                      ? null
                      : () async {
                          if (_formKey.currentState!.validate()) {
                            await mngctrl.verifydocid(
                                doctype: mngctrl.getPermit?.idProof ?? "",
                                docid: docIdController.text);
                            if (mngctrl.applicid.isNotEmpty &&
                                mngctrl.applicid == 'not found') {
                              String s = mngctrl.getPermit?.idProof ?? "";
                              mngctrl.getDocumentDetails(
                                  docID: docIdController.text, docType: s);
                              pagectrl.setmainpageindex(ind: 2);
                              pagectrl.changeIdSelection();
                            } else {
                              Get.dialog(AlertDialog(
                                content: RepaintBoundary(
                                    key: _globlkey,
                                    child: ReceiptWidget(
                                        applicantName: '',
                                        applicantId: mngctrl.applicid)),
                              ));
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(
                                      'Applicant Already Exist',
                                      style: TextStyle(fontSize: 30),
                                    ),
                                    content: Text(
                                      'Please collect the receipt and proceed to the counter for further processing.',
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

                              Future.delayed(Duration(seconds: 2)).then(
                                (value) async {
                                  print("nav Keys sdsd");
                                  await imgcon.saveReceipt(
                                      _globlkey, mngctrl.applicid);
                                  print("nav Keys");

                                  Get.back();
                                  Get.back();
                                  
                                  pagectrl.setmainpageindex(ind: 7);
                                },
                              );

                              /////dsadsadasd
                              log('already exist');
                            }
                          }
                          pagectrl.listenPageChange();
                        },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Verify"),
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
                            : SizedBox()
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
                // SizedBox(
                //   height: 20,
                // ),
                mngctrl.applicid.isEmpty
                    ? SizedBox()
                    : RepaintBoundary(
                        key: _globlkey,
                        child: ReceiptWidget(
                            applicantName: '', applicantId: mngctrl.applicid)),
              ],
            ),
          ),
        ).animate().fadeIn();
      });
    });
  }
}
