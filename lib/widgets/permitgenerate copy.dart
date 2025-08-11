import 'package:barcode_widget/barcode_widget.dart' show Barcode, BarcodeWidget;
import 'package:camera_windows_example/cons/utils.dart';
import 'package:camera_windows_example/controller/imagecapture.dart';
import 'package:camera_windows_example/controller/managementcontroller.dart';
import 'package:camera_windows_example/models/paymentresponse.dart';
import 'package:camera_windows_example/models/permit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../models/scannermodel.dart';

class PermitGenerateWidgetcopy extends StatefulWidget {
  const PermitGenerateWidgetcopy(
      {super.key,
      required this.applicantId,
      required this.keys,
      req,
      required this.paymentResponse});
  final PaymentResponse paymentResponse;
  final String applicantId;
  final GlobalKey keys;
  @override
  State<PermitGenerateWidgetcopy> createState() => _PermitGenerateWidgetState();
}

class _PermitGenerateWidgetState extends State<PermitGenerateWidgetcopy> {
  QrScannerModel? d;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    VisitorEntry? _permit = Get.find<Managementcontroller>().getPermit;
    d = QrScannerModel(
        applicantName: _permit?.applcntName ?? "",
        applicantParent: _permit?.applcntParent ?? "",
        dateOfIssue: DateTime.now(),
        idNo: _permit?.idNo ?? "",
        permitNo: widget.applicantId,
        hs: _permit?.applcntHNo ?? "",
        permitType: _permit?.entryType ?? "",
        placeOfStay: _permit?.placeOfStay ?? "",
        validUpto: DateTime.now().add(Duration(
            days: (int.tryParse(_permit?.residingPeriod ?? "30") ?? 30))));
  }

  @override
  Widget build(BuildContext context) {
    double dpi = MediaQuery.of(context).devicePixelRatio * 160; // DPI of screen
    double mmToDp(double mm) => (mm / 25.4) * dpi;

    return GetBuilder<Managementcontroller>(builder: (mngctrl) {
      return GetBuilder<Imagecontroller>(builder: (imgcon) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RepaintBoundary(
              key: widget.keys,
              child: SingleChildScrollView(
                child: ClipRect(
                  child: Container(
                    color: Colors.white,
                    width: mmToDp(90),
                    child: Column(
                      children: [
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     Image.asset(
                        //       'assets/images/ILPLOGOSS.png',
                        //       height: 80,
                        //       width: 80,
                        //     ),
                        //     Image.asset('assets/images/Kanglashaok.png',
                        //         height: 80, width: 80),
                        //   ],
                        // ),
                        // SizedBox(
                        //   height: 20,
                        // ),
                        // Text(
                        //   "INNER LINE PERMIT",
                        //   style: TextStyle(
                        //       fontSize: 36,
                        //       color: Colors.black,
                        //       fontWeight: FontWeight.bold),
                        // ),
                        // Text(
                        //   "GOVERNMENT OF MANIPUR",
                        //   style: TextStyle(
                        //       fontSize: 36,
                        //       color: Colors.black,
                        //       fontWeight: FontWeight.bold),
                        // ),
                        // SizedBox(
                        //   height: 20,
                        // ),
                        // Text(
                        //   "Temporary Permit",
                        //   style: TextStyle(fontSize: 36, color: Colors.black),
                        // ),
                        // Text(
                        //   "12/3/2025",
                        //   style: TextStyle(fontSize: 24, color: Colors.black),
                        // ),
                        // SizedBox(
                        //   height: 40,
                        // ),
                        Container(
                          margin: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16)),
                          height: mmToDp(270),
                          child: Transform.translate(
                            offset: Offset(0, -560),
                            child: Transform.rotate(
                              angle: 1.57,
                              child: Row(
                                children: [
                                  Container(
                                      width: mmToDp(100),
                                      height: mmToDp(80),
                                      child: Column(
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Image.asset(
                                                  'assets/images/Kanglashaok.png',
                                                  height: 100,
                                                  width: 100),
                                              Column(
                                                children: [
                                                  Text(
                                                    "INNER LINE PERMIT",
                                                    style: TextStyle(
                                                        fontSize: 36,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    "GOVERNMENT OF MANIPUR",
                                                    style: TextStyle(
                                                        fontSize: 36,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                          Divider(
                                            color: Colors.black,
                                            endIndent: 24,
                                          ),
                                          Row(
                                            children: [
                                              imgcon.profileImage != null
                                                  ? Center(
                                                      child: Image.memory(
                                                      imgcon.profileImage!,
                                                      height: mmToDp(25),
                                                      width: mmToDp(25),
                                                    ))
                                                  : SizedBox(),
                                              Expanded(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      16.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          BarcodeWidget(
                                                            barcode: Barcode
                                                                .code128(), // Barcode format
                                                            data:
                                                                '${widget.applicantId}',
                                                            width: mmToDp(50),
                                                            height: mmToDp(20),
                                                            drawText: true,

                                                            style: TextStyle(
                                                                fontSize: 24,
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      labeltext(
                                                        title:
                                                            "${mngctrl.currentPermit?.applcntName}",
                                                      ),
                                                      labeltext(
                                                        label: "S/O,D/o,/W/O:",
                                                        title:
                                                            "${mngctrl.currentPermit?.applcntParent}",
                                                      ),
                                                      labeltext(
                                                        label: "DOB: ",
                                                        title:
                                                            "${getDate(dateTime: mngctrl.currentPermit?.applcntDOB?.toIso8601String())}",
                                                      ),
                                                      labeltext(
                                                          label: "Address: ",
                                                          title:
                                                              "${mngctrl.currentPermit?.applcntState} ${mngctrl.currentPermit?.applcntDistrict} ${mngctrl.currentPermit?.applcntAddress} ${mngctrl.currentPermit?.applcntPoliceStation}"
                                                                  .capitalize!)
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      )),
                                  Container(
                                      width: mmToDp(100),
                                      height: mmToDp(80),
                                      child: Column(
                                        children: [
                                          Column(
                                            children: [
                                              Text(
                                                "TEMPORARY PERMIT",
                                                style: TextStyle(
                                                    fontSize: 36,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                "${widget.applicantId}",
                                                style: TextStyle(
                                                    fontSize: 36,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                            ],
                                          ),
                                          Divider(
                                            color: Colors.black,
                                            endIndent: 24,
                                          ),
                                          Row(
                                            children: [
                                              d != null
                                                  ? QrImageView(
                                                      data: d!
                                                          .toJson()
                                                          .toString(),
                                                      size: mmToDp(45),
                                                      embeddedImage: AssetImage(
                                                          'assets/manimap.jpeg'),
                                                      version: QrVersions.auto,
                                                    )
                                                  : SizedBox(),
                                              Expanded(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      16.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      labeltext(
                                                          label: 'Residing: ',
                                                          title:
                                                              "${mngctrl.currentPermit?.district} ${mngctrl.currentPermit?.placeOfStay} ${mngctrl.currentPermit?.pinCode} "),
                                                      labeltext(
                                                          label: "Purpose: ",
                                                          title:
                                                              "${mngctrl.currentPermit?.purposeVisit}"),
                                                      mngctrl.currentPermit
                                                                  ?.lrName !=
                                                              null
                                                          ? labeltext(
                                                              label: "LR: ",
                                                              title:
                                                                  "${mngctrl.currentPermit?.lrName} ${mngctrl.currentPermit?.lrPhone != null ? ', Ph No.:' : " "}${mngctrl.currentPermit?.lrPhone ?? ""}",
                                                            )
                                                          : SizedBox.shrink(),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'Date of Issue:\n${getDate(dateTime: d?.dateOfIssue?.toIso8601String())}',
                                                style: TextStyle(
                                                    fontSize: 22,
                                                    color: Colors.black),
                                              ),
                                              SizedBox(
                                                width: 30,
                                              ),
                                              Text(
                                                  'Date of Expiry:\n${getDate(dateTime: d?.validUpto?.toIso8601String())}',
                                                  style: TextStyle(
                                                      fontSize: 22,
                                                      color: Colors.black)),
                                            ],
                                          )
                                        ],
                                      )),
                                  Container(
                                    height: mmToDp(80),
                                    child: Column(
                                      children: [
                                        Transform.rotate(
                                            angle: 1.54,
                                            child: Icon(Icons.cut)),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          height: mmToDp(75),
                                          width: 1,
                                          color: Colors.black,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: mmToDp(60),
                                    height: mmToDp(80),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 60,
                                          ),
                                          Text(
                                              "Receipt: #${widget.paymentResponse.orderId}",
                                              style: TextStyle(
                                                  fontSize: 26,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold)),

                                          Divider(
                                            color: Colors.black,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Type",
                                                  style: TextStyle(
                                                      fontSize: 30,
                                                      color: Colors.black)),
                                              Text("Temporary Permit",
                                                  style: TextStyle(
                                                      fontSize: 30,
                                                      color: Colors.black))
                                            ],
                                          ),

                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Permit Fee",
                                                  style: TextStyle(
                                                      fontSize: 30,
                                                      color: Colors.black)),
                                              Text(
                                                  "${mngctrl.getPermitPrice?.fee.toStringAsFixed(2)}",
                                                  style: TextStyle(
                                                      fontSize: 30,
                                                      color: Colors.black))
                                            ],
                                          ),

                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Processing Fee",
                                                  style: TextStyle(
                                                      fontSize: 30,
                                                      color: Colors.black)),
                                              Text(
                                                  "${(widget.paymentResponse.amount! - (mngctrl.getPermitPrice != null ? mngctrl.getPermitPrice!.fee : 0.0)).toStringAsFixed(2)}",
                                                  style: TextStyle(
                                                      fontSize: 30,
                                                      color: Colors.black))
                                            ],
                                          ),

                                          // Divider(
                                          //   color: Colors.black,
                                          // ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Total",
                                                  style: TextStyle(
                                                      fontSize: 30,
                                                      color: Colors.black)),
                                              Text(
                                                  "${widget.paymentResponse.amount?.toStringAsFixed(2)}",
                                                  style: TextStyle(
                                                      fontSize: 30,
                                                      color: Colors.black))
                                            ],
                                          ),
                                          SizedBox(
                                            height: 40,
                                          ),
                                          Text(
                                            "This is an electronically generated Inner Line Permit Card, hence no signature or seal is required.",
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.black),
                                            textAlign: TextAlign.center,
                                          ),
                                          Text(
                                              "https://manipurilponline.mn.gov.in/",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.black),
                                              textAlign: TextAlign.center),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        // Column(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: [

                        //     imgcon.profileImage != null
                        //         ? Center(
                        //             child: Image.memory(
                        //             imgcon.profileImage!,
                        //             height: mmToDp(35),
                        //             width: mmToDp(35),
                        //           ))
                        //         : SizedBox(),

                        //   ],
                        // ),
                        // SizedBox(height: 20),

                        // /// QR Code

                        // SizedBox(height: 20),
                        // Row(
                        //   children: [
                        //     Icon(Icons.cut),
                        //     Expanded(
                        //         child: Divider(
                        //       color: Colors.black,
                        //     )),
                        //   ],
                        // ),

                        SizedBox(height: 20),
                        // Row(
                        //   children: [
                        //     Icon(Icons.cut),
                        //     Expanded(
                        //         child: Divider(
                        //       color: Colors.black,
                        //     )),
                        //   ],
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.all(16.0),
                        //   child: Column(
                        //     children: [
                        //       Text("Receipt: #${widget.paymentResponse.orderId}",
                        //           style:
                        //               TextStyle(fontSize: 36, color: Colors.black)),
                        //       // Spacer(),
                        //       Row(
                        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //         children: [
                        //           Text("Type",
                        //               style: TextStyle(
                        //                   fontSize: 30, color: Colors.black)),
                        //           Text("Temporary Permit",
                        //               style: TextStyle(
                        //                   fontSize: 30, color: Colors.black))
                        //         ],
                        //       ),

                        //       Row(
                        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //         children: [
                        //           Text("Permit Fee",
                        //               style: TextStyle(
                        //                   fontSize: 30, color: Colors.black)),
                        //           Text("${mngctrl.getPermitPrice?.fee}",
                        //               style: TextStyle(
                        //                   fontSize: 30, color: Colors.black))
                        //         ],
                        //       ),

                        //       Row(
                        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //         children: [
                        //           Text("Processing Fee",
                        //               style: TextStyle(
                        //                   fontSize: 30, color: Colors.black)),
                        //           Text(
                        //               "${widget.paymentResponse.amount - (mngctrl.getPermitPrice != null ? mngctrl.getPermitPrice!.fee : 0.0)}",
                        //               style: TextStyle(
                        //                   fontSize: 30, color: Colors.black))
                        //         ],
                        //       ),

                        //       Divider(
                        //         color: Colors.black,
                        //       ),
                        //       Row(
                        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //         children: [
                        //           Text("Total",
                        //               style: TextStyle(
                        //                   fontSize: 30, color: Colors.black)),
                        //           Text("${widget.paymentResponse.amount}",
                        //               style: TextStyle(
                        //                   fontSize: 30, color: Colors.black))
                        //         ],
                        //       ),
                        //       SizedBox(
                        //         height: 40,
                        //       ),
                        //       Text(
                        //         "This is an electronically generated Inner Line Permit Card, hence no signature is required.",
                        //         style: TextStyle(fontSize: 24, color: Colors.black),
                        //         textAlign: TextAlign.center,
                        //       ),
                        //       Text("https://manipurilponline.mn.gov.in/",
                        //           style:
                        //               TextStyle(fontSize: 24, color: Colors.black),
                        //           textAlign: TextAlign.center),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            ElevatedButton(onPressed: () {}, child: Text("Print"))
          ],
        );
      });
    });
  }
}

class labeltext extends StatelessWidget {
  const labeltext({
    super.key,
    this.label = "",
    required this.title,
  });
  final String? label;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label != null || label!.isNotEmpty
            ? Text(label ?? "",
                style: TextStyle(fontSize: 24, color: Colors.black))
            : SizedBox(),
        Expanded(
          child: Text(title,
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
        ),
      ],
    );
  }
}
