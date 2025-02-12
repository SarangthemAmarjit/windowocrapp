import 'dart:io';

import 'package:camera_windows_example/controller/imagecapture.dart';
import 'package:camera_windows_example/controller/managementcontroller.dart';
import 'package:camera_windows_example/home/printpage.dart';
import 'package:camera_windows_example/widgets/bannercard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

import '../../cons/constant.dart';
import '../../controller/pagecontroller.dart';
import 'linkpage.dart';

class PaymentDetails extends StatelessWidget {
  const PaymentDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Managementcontroller>(builder: (mngctrl) {
      return GetBuilder<Imagecontroller>(builder: (imgcon) {
        return GetBuilder<PagenavControllers>(builder: (controller) {
          return Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 800),
              child: Container(
                margin: EdgeInsets.all(16),
                // padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        spreadRadius: 2,
                      )
                    ]),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Verify Details",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8)),
                                    child: imgcon.profileimage != null
                                        ? Transform.flip(
                                            flipX: true,
                                            child: Image.file(
                                              height: 120,
                                              width: 120,
                                              fit: BoxFit.contain,
                                              File(imgcon.profileimage!.path),
                                            ),
                                          )
                                        : SizedBox(),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        mngctrl.visitorEntry?.applcntName ?? "",
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              TextLabel(
                                                  text: (mngctrl.visitorEntry
                                                          ?.idProof ??
                                                      "")),
                                              BannerContainer(
                                                  padding: EdgeInsets.all(8),
                                                  margin: EdgeInsets.zero,
                                                  text: mngctrl
                                                          .visitorEntry?.idNo ??
                                                      "",
                                                  color: Colors.green),
                                            ],
                                          ),
                                          SizedBox(
                                            width: 40,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              TextLabel(text: "Gender"),
                                              TextSubtitle(
                                                text: mngctrl.visitorEntry
                                                        ?.applcntGender ??
                                                    "",
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: 60,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              TextLabel(text: "D.O.B"),
                                              TextSubtitle(
                                                text: mngctrl.visitorEntry
                                                        ?.applcntDOB ??
                                                    "",
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Divider(),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextLabel(text: "Parent's Name"),
                                        TextSubtitle(
                                          text: mngctrl.visitorEntry
                                                  ?.applcntParent ??
                                              "",
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextLabel(text: "Email"),
                                        TextSubtitle(
                                          text: mngctrl
                                                  .visitorEntry?.applcntEmail ??
                                              "NA",
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextLabel(text: "Phone"),
                                        TextSubtitle(
                                            text: mngctrl.visitorEntry
                                                    ?.applcntMobile ??
                                                ""),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextLabel(text: "State"),
                                        TextSubtitle(
                                          text: mngctrl
                                                  .visitorEntry?.applcntState ??
                                              "",
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextLabel(text: "Address"),
                                        TextSubtitle(
                                          text: mngctrl.visitorEntry
                                                  ?.applcntAddress ??
                                              "",
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextLabel(text: "Tehsil"),
                                        TextSubtitle(
                                          text: mngctrl.visitorEntry
                                                  ?.applcntTehsil ??
                                              "",
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextLabel(text: "Period Of Stay"),
                                        TextSubtitle(
                                          text: '15',
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextLabel(text: "Starting Date"),
                                        TextSubtitle(
                                          text:
                                              mngctrl.visitorEntry?.visitDate ??
                                                  "",
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextLabel(text: "Purpose"),
                                        TextSubtitle(
                                          text: mngctrl
                                                  .visitorEntry?.purposeVisit ??
                                              "",
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ).animate().fadeIn(
                        duration: Duration(milliseconds: 900),
                        delay: Duration(milliseconds: 300)),
                    SizedBox(
                      height: 20,
                    ),
                    Divider(),
                    PaymentCard().animate().fadeIn(
                        duration: Duration(milliseconds: 1200),
                        delay: Duration(milliseconds: 600)),
                  ],
                ),
              )
                  .animate()
                  .scaleXY(
                      begin: 0.7,
                      end: 1,
                      curve: Curves.easeInCubic,
                      duration: Duration(milliseconds: 600))
                  .fadeIn(duration: Duration(milliseconds: 500)),
            ),
          );
        });
      });
    });
  }
}

class PaymentCard extends StatelessWidget {
  const PaymentCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      //  height: 500,
      //  clipBehavior:Clip.antiAlias,
      // decoration: BoxDecoration(
      // // image: DecorationImage(image: AssetImage('assets/images/bg.png')),
      // color: Colors.green,
      // gradient: LinearGradient(colors: [Colors.green,Colors.green[900]!],
      // begin: Alignment.topLeft,
      // end: Alignment.bottomRight
      // )

      // ),
      child: Column(
        children: [
          // Container(
          //   width: double.infinity,
          //   height: 200,

          //   child: Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.center,

          //       children: [

          //         Text("Rs 2000",style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),),
          //       ],
          //     ),
          //   ),
          // ),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BannerContainer(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  margin: EdgeInsets.zero,
                  text: "Payments",
                  color: Colors.green,
                ),
                // Divider(),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Text(
                      "Permit Type",
                      style: TextStyle(fontSize: 18),
                    )),
                    Expanded(
                        flex: 3,
                        child: Divider(
                          endIndent: 80,
                          indent: 80,
                        )),
                    Expanded(
                        child: Text(
                      "Temporary Permit",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Text(
                      "Permit Validity",
                      style: TextStyle(fontSize: 18),
                    )),
                    Expanded(
                        flex: 3,
                        child: Divider(
                          endIndent: 80,
                          indent: 80,
                        )),
                    Expanded(
                        child: Text("15 Days",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold))),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Text(
                      "From",
                      style: TextStyle(fontSize: 18),
                    )),
                    Expanded(
                        flex: 3,
                        child: Divider(
                          endIndent: 80,
                          indent: 80,
                        )),
                    Expanded(
                        child: Text(
                      "22/1/2025",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Text(
                      "To",
                      style: TextStyle(fontSize: 18),
                    )),
                    Expanded(
                        flex: 3,
                        child: Divider(
                          endIndent: 80,
                          indent: 80,
                        )),
                    Expanded(
                        child: Text(
                      "22/2/2025",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Text(
                      "Amount",
                      style: TextStyle(fontSize: 18),
                    )),
                    Expanded(
                        flex: 3,
                        child: Divider(
                          endIndent: 80,
                          indent: 80,
                        )),
                    Expanded(
                        child: Text(
                      "$rupee 100",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )),
                  ],
                ),
                Divider(),
                SizedBox(
                  height: 10,
                ),
                Center(
                    child: Text(
                  "Total: $rupee 100",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                )),
              ],
            ),
          ),
        ButtonCard(title: "Pay Now", onpress:(){

              showDialog(context: context, builder: (c){
                return  AlertDialog(
                  
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Payment Options",style: TextStyle(fontSize: 24),),
                     IconButton(onPressed: (){
                      Get.back();
                     }, icon: Icon(Icons.close))
                    ],
                  ),
                  actions: [
                        ButtonCard(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          title: "Pay Cash ", onpress: (){}) ,
                        ButtonCard(
                             padding: EdgeInsets.symmetric(vertical: 8),
                          title: "Pay Online", onpress: (){}) ,
                  ],
                );
              });



              // Get.to(() => ReceiptPreviewPage());
        })
        ],
      ),
    );
  }
}

class ButtonCard extends StatelessWidget {
  const ButtonCard({
    super.key, required this.title, required this.onpress, this.padding,
  });
  final String title;
  final VoidCallback onpress;
  final EdgeInsets? padding;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding??EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: InkWell(
        onTap: onpress,
        child: Container(
         
          width: double.infinity,
          padding: EdgeInsets.all(32),
          decoration: BoxDecoration(
              color: Colors.green, borderRadius: BorderRadius.circular(8)),
          clipBehavior: Clip.antiAlias,
          child: Center(
              child: Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 26),
          )),
        ),
      ),
    );
  }
}

class TextSubtitle extends StatelessWidget {
  const TextSubtitle({
    super.key,
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }
}

class TextLabel extends StatelessWidget {
  const TextLabel({
    super.key,
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: 16),
    );
  }
}
