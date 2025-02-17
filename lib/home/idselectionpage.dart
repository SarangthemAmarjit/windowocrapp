import 'package:camera_windows_example/cons/constant.dart';
import 'package:camera_windows_example/controller/managementcontroller.dart';
import 'package:camera_windows_example/controller/imagecapture.dart';
import 'package:camera_windows_example/controller/pagecontroller.dart';
import 'package:camera_windows_example/home/registrationpages/ilpformreplica.dart';
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
    Get.put(Managementcontroller());
  }
  @override
  Widget build(BuildContext context) {
    PagenavControllers pagecon = Get.put(PagenavControllers());

    return GetBuilder<Managementcontroller>(
      builder: (mngctrl) {
        return GetBuilder<PagenavControllers>(builder: (_) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    'Document Type Selection for Scanning',
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ).animate().fadeIn(),
                  const SizedBox(height: 8),
                  Text(
                    'Choose the type of ID document you want to scan for verification.',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 100),
                  pagecon.IdSelection
                      ? GetDocumentId()
                      :  GridView.builder(
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
                                .fadeIn(delay: Duration(milliseconds: index * 200))
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
        
                        if(pagecon.IdSelection){
                            pagecon.changeIdSelection();
                        }else{
        
                        pagecon.setmainpageindex(ind: 0);
                        }
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
      }
    );
  }

  Widget _buildButton(BuildContext context, String text, int docindex) {
    PagenavControllers pagecon = Get.put(PagenavControllers());
    Managementcontroller mngctrl = Get.find<Managementcontroller>();
    Imagecontroller imgcon = Get.put(Imagecontroller());

    return ElevatedButton(
      onPressed: () {
        pagecon.changeIdSelection();
        pagecon.setdocindex(ind: docindex);
        // pagecon.setmainpageindex(ind: 3);
        mngctrl.getDocumentDetails(docID: "12034885", docType: text);
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
  final TextEditingController docId = TextEditingController();
  bool? isEmpty;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PagenavControllers>(builder: (pagectrl) {
      return GetBuilder<Managementcontroller>(builder: (mngctrl) {
        return AnimatedContainer(
          duration: Duration(milliseconds: 1000),
          height: pagectrl.IdSelection ? 300 : 0,
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
                    width: 300,
                    child: TextFieldWidget(
                      controller: docId,
                      label: mngctrl.getPermit?.idProof ?? "Doc Id",
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
                  onPressed: () {
                    if (docId.text.isEmpty) {
                      setState(() {
                        isEmpty = true;
                      });
                    } else {
                      setState(() {
                        isEmpty = false;
                      });

                      mngctrl.getDocumentDetails(
                          docID: docId.text,
                          docType: mngctrl.getPermit?.idProof ?? "");
                      pagectrl.setmainpageindex(ind: 3);
                      pagectrl.changeIdSelection();
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text("Verify"),
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
                )
              ],
            ),
          ),
        ).animate().fadeIn();
      });
    });
  }
}
