import 'dart:io';

import 'package:camera_windows_example/cons/utils.dart';
import 'package:camera_windows_example/controller/imagecapture.dart';
import 'package:camera_windows_example/controller/managementcontroller.dart';
import 'package:camera_windows_example/controller/paymentcontroller.dart';
import 'package:camera_windows_example/home/registrationpages/linkpage.dart';
import 'package:camera_windows_example/home/registrationpages/succespage.dart';
import 'package:camera_windows_example/payment/successpage.dart';
import 'package:camera_windows_example/widgets/bannercard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import '../../cons/constant.dart';
import '../../controller/pagecontroller.dart';
import '../../widgets/receiptpermit.dart';

class PaymentDetails extends StatelessWidget {
  PaymentDetails({super.key});
  final GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    GetxTapController gcontroller = Get.put(GetxTapController());
    return GetBuilder<Managementcontroller>(builder: (mngctrl) {
      return GetBuilder<Imagecontroller>(builder: (imgcon) {
        return GetBuilder<PagenavControllers>(builder: (controller) {
          return GetBuilder<GetxTapController>(builder: (_) {
            return gcontroller.ispaymentprocessstarted
                ? Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 400,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Center(
                          child: SizedBox(
                            height: 150,
                            width: 150,
                            child: Image.asset('assets/images/processing.gif'),
                          ),
                        ),
                      ),
                    ],
                  )
                : Center(
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
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 120,
                                            width: 120,
                                            clipBehavior: Clip.antiAlias,
                                            decoration: BoxDecoration(
                                                color: Colors.grey[300],
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            child: imgcon.profileImage != null
                                                ? Image.memory(
                                                    imgcon.profileImage!,
                                                    height: 120,
                                                    width: 120,
                                                    fit: BoxFit.contain,
                                                  )
                                                : Center(
                                                    child: Icon(
                                                      Icons.photo,
                                                      color: Colors.grey,
                                                      size: 40,
                                                    ),
                                                  ),
                                          ),
                                          //            Container(
                                          //   height: 120,
                                          //   width: 120,
                                          //   clipBehavior: Clip.antiAlias,
                                          //   decoration: BoxDecoration(
                                          //       color: Colors.grey[300],
                                          //       borderRadius:
                                          //           BorderRadius.circular(8)),
                                          //   child: imgcon.idCardimage!= null
                                          //       ? Image.memory(
                                          //         imgcon.idCardimage!,
                                          //         // height: 300,
                                          //         // width:300,
                                          //         fit: BoxFit.cover,

                                          //       )
                                          //       : Center(
                                          //           child: Icon(
                                          //             Icons.photo,
                                          //             color: Colors.grey,
                                          //             size: 40,
                                          //           ),
                                          //         ),
                                          // ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                mngctrl.getPermit
                                                        ?.applcntName ??
                                                    "NA",
                                                style: TextStyle(
                                                    fontSize: 24,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Row(
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      TextLabel(
                                                          text: (mngctrl
                                                                  .getPermit
                                                                  ?.idProof ??
                                                              "NA")),
                                                      BannerContainer(
                                                          padding:
                                                              EdgeInsets.all(8),
                                                          margin:
                                                              EdgeInsets.zero,
                                                          text: mngctrl
                                                                  .getPermit
                                                                  ?.idNo ??
                                                              "NA",
                                                          color: Colors.green),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    width: 40,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      TextLabel(text: "Gender"),
                                                      TextSubtitle(
                                                        text: mngctrl.getPermit
                                                                ?.applcntGender ??
                                                            "NA",
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    width: 60,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      TextLabel(text: "D.O.B"),
                                                      TextSubtitle(
                                                          text: getDate(
                                                              dateTime: mngctrl
                                                                      .getPermit
                                                                      ?.applcntDOB ??
                                                                  "")),
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
                                                TextLabel(
                                                    text: "Parent's Name"),
                                                TextSubtitle(
                                                  text: mngctrl.getPermit
                                                          ?.applcntParent ??
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
                                                TextLabel(text: "Email"),
                                                TextSubtitle(
                                                  text: mngctrl.getPermit
                                                          ?.applcntEmail ??
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
                                                    text: mngctrl.getPermit
                                                            ?.applcntMobile ??
                                                        "NA"),
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
                                                  text: mngctrl.getPermit
                                                          ?.applcntState ??
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
                                                TextLabel(text: "District"),
                                                TextSubtitle(
                                                  text: mngctrl.getPermit
                                                          ?.district ??
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
                                                TextLabel(text: "Address"),
                                                TextSubtitle(
                                                  text: mngctrl.getPermit
                                                          ?.applcntAddress ??
                                                      "NA",
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
                                                TextLabel(
                                                    text:
                                                        "Nearest Police Station"),
                                                TextSubtitle(
                                                  text: mngctrl.getPermit
                                                          ?.applcntPoliceStation ??
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
                                                TextLabel(text: "Tehsil"),
                                                TextSubtitle(
                                                  text: mngctrl.getPermit
                                                          ?.applcntTehsil ??
                                                      "NA",
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: SizedBox(),
                                          ),
                                        ],
                                      ),
                                      // Divider(),
                                      // TextLabel( text: "Documents"),
                                      // SizedBox(height: 10,),
                                      //   Row(
                                      //   children: [
                                      //     Expanded(
                                      //       child: Column(
                                      //         crossAxisAlignment:
                                      //             CrossAxisAlignment.start,
                                      //         children: [
                                      //           TextLabel(
                                      //               text: "Signature"),
                                      //             SizedBox(height: 10,),
                                      //          imgcon.signature!=null? Image.memory(imgcon.signature!,width: 150,height: 70,fit: BoxFit.contain,):Container(

                                      //            decoration: BoxDecoration(color: Colors.grey),
                                      //            height: 100,
                                      //            width: 300,
                                      //            child: Center(child: Text("sig empty"),),
                                      //          )
                                      //         ],
                                      //       ),
                                      //     ),
                                      //     Expanded(
                                      //       child: Column(
                                      //         crossAxisAlignment:
                                      //             CrossAxisAlignment.start,
                                      //         children: [
                                      //                    TextLabel(
                                      //               text: "Receipt"),
                                      //             SizedBox(height: 10,),
                                      //          imgcon.receipt!=null? Image.memory(imgcon.receipt!,width: 30,height: 70,fit: BoxFit.contain,):Container(

                                      //            decoration: BoxDecoration(color: Colors.grey),
                                      //            height: 100,
                                      //            width: 300,
                                      //            child: Center(child: Text("Receipt empty"),),
                                      //          )
                                      //         ],
                                      //       ),
                                      //     ),
                                      //     Expanded(
                                      //       child: Column(
                                      //         crossAxisAlignment:
                                      //             CrossAxisAlignment.start,
                                      //         children: [

                                      //         ],
                                      //       ),
                                      //     ),
                                      //   ],
                                      // ),
                                      Divider(),

                                      Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                TextLabel(
                                                    text: "Period Of Stay"),
                                                TextSubtitle(
                                                  text: '30 days',
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                TextLabel(
                                                    text: "Starting Date"),
                                                TextSubtitle(
                                                    text: getDate(
                                                        dateTime: mngctrl
                                                                .getPermit
                                                                ?.visitDate ??
                                                            "")),
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
                                                  text: mngctrl.getPermit
                                                          ?.purposeVisit ??
                                                      "NA",
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextLabel(text: "Place of Stay"),
                                          TextSubtitle(
                                            text: mngctrl
                                                    .getPermit?.placeOfStay ??
                                                "NA",
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
                            PaymentCard(
                              mngctrl: mngctrl,
                            ).animate().fadeIn(
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
    });
  }
}

class PaymentCard extends StatefulWidget {
  const PaymentCard({
    super.key,
    required this.mngctrl,
  });
  final Managementcontroller mngctrl;

  @override
  State<PaymentCard> createState() => _PaymentCardState();
}

class _PaymentCardState extends State<PaymentCard> {
  final GlobalKey _globlkey = GlobalKey();
  bool isload = false;
  @override
  Widget build(BuildContext context) {
    GetxTapController gcontroller = Get.put(GetxTapController());
    return GetBuilder<PagenavControllers>(builder: (pagectrl) {
      return GetBuilder<Imagecontroller>(builder: (imgcon) {
        return GetBuilder<Managementcontroller>(builder: (mngctrl) {
          return GetBuilder<GetxTapController>(builder: (_) {
            return Container(
              width: double.infinity,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BannerContainer(
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
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
                                child: Text("30 Days",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold))),
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
                              getDate(
                                  dateTime: mngctrl.getPermit?.visitDate ?? ""),
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
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
                              getDate(
                                  dateTime: mngctrl.getPermit?.visitDate ?? "",
                                  duration: 15),
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
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
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
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
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        )),
                      ],
                    ),
                  ),
                  ButtonCard(
                      title: "Register Permit",
                      onpress: () async {
                        if (onlinePayment == false) {
                          setState(() {
                            isload = true;
                          });

                          String? s = await mngctrl.addtemporaryPermit(
                            true,
                            imgcon.profileImage!,
                            imgcon.idCardimage!,
                            imgcon.signature!,
                            address: mngctrl.getPermit?.applcntAddress ?? "",
                            applydistrict: mngctrl.getPermit?.district ?? "",
                            districtss:
                                mngctrl.getPermit?.applcntDistrict ?? "",
                            dob: mngctrl.getPermit?.applcntDOB ?? "",
                            email: mngctrl.getPermit?.applcntEmail ?? "",
                            gender: mngctrl.getPermit?.applcntGender ?? "",
                            idProofs: mngctrl.getPermit?.idProof ?? "",
                            idno: mngctrl.getPermit?.idNo ?? "",
                            mobile: mngctrl.getPermit?.applcntMobile ?? "",
                            name: mngctrl.getPermit?.applcntName ?? "",
                            parentname: mngctrl.getPermit?.applcntParent ?? "",
                            pincode: mngctrl.getPermit?.pinCode ?? "",
                            placestay: mngctrl.getPermit?.placeOfStay ?? "",
                            polstation:
                                mngctrl.getPermit?.applcntPoliceStation ?? "",
                            purposeVisits:
                                mngctrl.getPermit?.purposeVisit ?? "",
                            state: mngctrl.getPermit?.applcntState ?? "",
                            tehsl: mngctrl.getPermit?.applcntTehsil ?? "",
                            village: mngctrl.getPermit?.applcntVillage ?? "",
                            visitDates: DateTime.now(),
                            localres: mngctrl.getPermit?.lrName ?? 'NA',
                            localnearestpol:
                                mngctrl.getPermit?.nearestPS ?? "NA",
                          );

                          setState(() {
                            isload = false;
                          });

                          if (s != null) {
                            Get.dialog(AlertDialog(
                              content: RepaintBoundary(
                                  key: _globlkey,
                                  child: ReceiptWidget(
                                      applicantName:
                                          mngctrl.getPermit?.applcntName ??
                                              "NA",
                                      applicantId: s)),
                            ));
                            Future.delayed(Duration(seconds: 3)).then(
                              (value) async {
                                print("nav Keys sdsd");
                                await imgcon.saveReceipt(_globlkey, s);
                                print("nav Keys");

                                Get.back();

                                pagectrl.setmainpageindex(ind: 4);
                              },
                            );
                          }
                        } else {
                          showDialog(
                              context: context,
                              builder: (c) {
                                return StatefulBuilder(builder: (context, sta) {
                                  return AlertDialog(
                                    insetPadding: EdgeInsets.all(16),
                                    content: Container(
                                      width: 600,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Payment Options",
                                                style: TextStyle(fontSize: 24),
                                              ),
                                              IconButton(
                                                  onPressed: () {
                                                    Get.back();
                                                  },
                                                  icon: Icon(Icons.close))
                                            ],
                                          ),
                                          isload
                                              ? Padding(
                                                  padding: const EdgeInsets.all(
                                                      32.0),
                                                  child: Column(
                                                    children: [
                                                      CircularProgressIndicator(),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      Text(
                                                        "Creating Permit. Please Wait",
                                                        style: TextStyle(
                                                            fontSize: 20),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              : SizedBox()
                                        ],
                                      ),
                                    ),
                                    actions: isload
                                        ? null
                                        : [
                                            ButtonCard(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 8),
                                                icon: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 8.0),
                                                  child: Icon(
                                                    Icons
                                                        .currency_rupee_outlined,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                title: "Pay at ILP Counter ",
                                                onpress: () async {
                                                  sta(() {
                                                    isload = true;
                                                  });

                                                  String? s = await mngctrl
                                                      .addtemporaryPermit(
                                                    true,
                                                    imgcon.profileImage!,
                                                    imgcon.idCardimage!,
                                                    imgcon.signature!,
                                                    address: mngctrl.getPermit
                                                            ?.applcntAddress ??
                                                        "",
                                                    applydistrict: mngctrl
                                                            .getPermit
                                                            ?.district ??
                                                        "",
                                                    districtss: mngctrl
                                                            .getPermit
                                                            ?.applcntDistrict ??
                                                        "",
                                                    dob: mngctrl.getPermit
                                                            ?.applcntDOB ??
                                                        "",
                                                    email: mngctrl.getPermit
                                                            ?.applcntEmail ??
                                                        "",
                                                    gender: mngctrl.getPermit
                                                            ?.applcntGender ??
                                                        "",
                                                    idProofs: mngctrl.getPermit
                                                            ?.idProof ??
                                                        "",
                                                    idno: mngctrl
                                                            .getPermit?.idNo ??
                                                        "",
                                                    mobile: mngctrl.getPermit
                                                            ?.applcntMobile ??
                                                        "",
                                                    name: mngctrl.getPermit
                                                            ?.applcntName ??
                                                        "",
                                                    parentname: mngctrl
                                                            .getPermit
                                                            ?.applcntParent ??
                                                        "",
                                                    pincode: mngctrl.getPermit
                                                            ?.pinCode ??
                                                        "",
                                                    placestay: mngctrl.getPermit
                                                            ?.placeOfStay ??
                                                        "",
                                                    polstation: mngctrl
                                                            .getPermit
                                                            ?.applcntPoliceStation ??
                                                        "",
                                                    purposeVisits: mngctrl
                                                            .getPermit
                                                            ?.purposeVisit ??
                                                        "",
                                                    state: mngctrl.getPermit
                                                            ?.applcntState ??
                                                        "",
                                                    tehsl: mngctrl.getPermit
                                                            ?.applcntTehsil ??
                                                        "",
                                                    village: mngctrl.getPermit
                                                            ?.applcntVillage ??
                                                        "",
                                                    visitDates: DateTime.now(),
                                                    localres: mngctrl.getPermit
                                                            ?.lrName ??
                                                        'NA',
                                                    localnearestpol: mngctrl
                                                            .getPermit
                                                            ?.nearestPS ??
                                                        "NA",
                                                  );

                                                  sta(() {
                                                    isload = false;
                                                  });
                                                  Get.back();
                                                  
                          if (s != null) {
                            Get.dialog(AlertDialog(
                              content: RepaintBoundary(
                                  key: _globlkey,
                                  child: ReceiptWidget(
                                      applicantName:
                                          mngctrl.getPermit?.applcntName ??
                                              "NA",
                                      applicantId: s)),
                            ));
                            Future.delayed(Duration(seconds: 3)).then(
                              (value) async {
                                print("nav Keys sdsd");
                                await imgcon.saveReceipt(_globlkey, s);
                                print("nav Keys");

                                Get.back();
                                  pagectrl.pageIncremeter(4);
                                pagectrl.setmainpageindex(ind: 4);
                              },
                            );
                          }

                                                  // Get.back();
                                                  // send permit to api
                                                }),
                                            ButtonCard(
                                                icon: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 8.0),
                                                  child: Icon(
                                                    Icons.money_sharp,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 8),
                                                title: "Pay Online",
                                                onpress: () async {
                                                  sta(() {
                                                    isload = true;
                                                  });

                                                String? s = await mngctrl
                                                      .addtemporaryPermit(
                                                    false,
                                                    imgcon.profileImage!,
                                                    imgcon.idCardimage!,
                                                    imgcon.signature!,
                                                    address: mngctrl.getPermit
                                                            ?.applcntAddress ??
                                                        "",
                                                    applydistrict: mngctrl
                                                            .getPermit
                                                            ?.district ??
                                                        "",
                                                    districtss: mngctrl
                                                            .getPermit
                                                            ?.applcntDistrict ??
                                                        "",
                                                    dob: mngctrl.getPermit
                                                            ?.applcntDOB ??
                                                        "",
                                                    email: mngctrl.getPermit
                                                            ?.applcntEmail ??
                                                        "",
                                                    gender: mngctrl.getPermit
                                                            ?.applcntGender ??
                                                        "",
                                                    idProofs: mngctrl.getPermit
                                                            ?.idProof ??
                                                        "",
                                                    idno: mngctrl
                                                            .getPermit?.idNo ??
                                                        "",
                                                    mobile: mngctrl.getPermit
                                                            ?.applcntMobile ??
                                                        "",
                                                    name: mngctrl.getPermit
                                                            ?.applcntName ??
                                                        "",
                                                    parentname: mngctrl
                                                            .getPermit
                                                            ?.applcntParent ??
                                                        "",
                                                    pincode: mngctrl.getPermit
                                                            ?.pinCode ??
                                                        "",
                                                    placestay: mngctrl.getPermit
                                                            ?.placeOfStay ??
                                                        "",
                                                    polstation: mngctrl
                                                            .getPermit
                                                            ?.applcntPoliceStation ??
                                                        "",
                                                    purposeVisits: mngctrl
                                                            .getPermit
                                                            ?.purposeVisit ??
                                                        "",
                                                    state: mngctrl.getPermit
                                                            ?.applcntState ??
                                                        "",
                                                    tehsl: mngctrl.getPermit
                                                            ?.applcntTehsil ??
                                                        "",
                                                    village: mngctrl.getPermit
                                                            ?.applcntVillage ??
                                                        "",
                                                    visitDates: DateTime.now(),
                                                    localres: mngctrl.getPermit
                                                            ?.lrName ??
                                                        'NA',
                                                    localnearestpol: mngctrl
                                                            .getPermit
                                                            ?.nearestPS ??
                                                        "NA",
                                                  );
                                                  sta(() {
                                                    isload = false;
                                                  });
                                                  if(s!=null){
                                                    mngctrl.setOnlineApplId(s);
                                                 gcontroller.initNdpsPayment(
                                                  transId: mngctrl.getPermit?.transactionId??"",
                                                    context: context,
                                                    responseHashKey: gcontroller
                                                        .responseHashKey,
                                                    responseDecryptionKey:
                                                        gcontroller
                                                            .responseDecryptionKey,
                                                    amount: mngctrl
                                                        .allpermitprices[0].fee
                                                        .toString(),
                                                    address: 'fsdfsdf',
                                                    name: 'amarjit',
                                                  );
                                                  }else{
                                                    Get.back();
                                                    Get.dialog(AlertDialog(content: Text("Failed to add permit.\nTry again"),
                                                    actions: [
                                                      ButtonCard(title: "Try again", onpress: (){
                                                        pagectrl.setmainpageindex(ind: 0);
                                                        pagectrl.listenPageChange();
                                                      })
                                                    ],
                                                    ));
                                                  }
                                      
                                                }),
                                          ],
                                  )
                                      .animate()
                                      .scaleXY(begin: 0.5, end: 1)
                                      .fadeIn();
                                });
                              });

                          // Get.to(() => Successpages());
                        }
                      })
                ],
              ),
            );
          });
        });
      });
    });
  }
}

class ButtonCard extends StatelessWidget {
  const ButtonCard({
    super.key,
    required this.title,
    required this.onpress,
    this.padding,
    this.icon,
    this.ver,
    this.conwidth,
  });
  final String title;
  final VoidCallback onpress;
  final EdgeInsets? padding;
  final Widget? icon;
  final double? ver;
  final double? conwidth;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          padding ?? EdgeInsets.symmetric(horizontal: 16, vertical: ver ?? 16),
      child: InkWell(
        onTap: onpress,
        child: Container(
          width: conwidth ?? double.infinity,
          padding: EdgeInsets.all(32),
          decoration: BoxDecoration(
              color: Colors.green, borderRadius: BorderRadius.circular(8)),
          clipBehavior: Clip.antiAlias,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon ?? SizedBox(),
              Text(
                title,
                style: TextStyle(color: Colors.white, fontSize: 26),
              ),
            ],
          ),
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