import 'dart:typed_data';

import 'package:barcode_widget/barcode_widget.dart' show Barcode, BarcodeWidget;
import 'package:camera_windows_example/cons/utils.dart';
import 'package:camera_windows_example/controller/imagecapture.dart';
import 'package:camera_windows_example/models/paymentresponse.dart';
import 'package:camera_windows_example/models/permit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../models/scannermodel.dart';

class PermitGenerateWidgetcopy extends StatefulWidget {
  const PermitGenerateWidgetcopy(
      {super.key,
      required this.applicantId,
      required this.keys,
      req,
      required this.paymentResponse,
      required this.permit,
      required this.permitfee,
      required this.deviceId,
      required this.image});
  final PaymentResponse paymentResponse;
  final VisitorEntry permit;
  final String deviceId;
  final double permitfee;
  final String applicantId;
  final GlobalKey keys;
  final Uint8List image;

  @override
  State<PermitGenerateWidgetcopy> createState() => _PermitGenerateWidgetState();
}

class _PermitGenerateWidgetState extends State<PermitGenerateWidgetcopy> {
  QrScannerModel? d;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    d = QrScannerModel(
      applicantName: widget.paymentResponse.applicantName ?? "",
      applicantParent: widget.paymentResponse.applicantParent ?? "",
      idNo: widget.paymentResponse.idNo ?? "",
      permitNo: widget.paymentResponse.permitNo ?? "",
      hs: widget.permit.applcntHNo ?? "",
      permitType: widget.paymentResponse.permitType ?? "",
      placeOfStay: widget.paymentResponse.placeOfStay ?? "",
      dateOfIssue: parseAnyDate(widget.paymentResponse.dateOfIssue ?? ""),
      validUpto: parseAnyDate(widget.paymentResponse.validUpto ?? ""),
    );
  }

  @override
  Widget build(BuildContext context) {
    double dpi = MediaQuery.of(context).devicePixelRatio * 160; // DPI of screen
    double mmToDp(double mm) => (mm / 25.4) * dpi;

    return GetBuilder<Imagecontroller>(builder: (s) {
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
                                            Center(
                                                child: Image.memory(
                                              widget.image,
                                              height: mmToDp(25),
                                              width: mmToDp(25),
                                            )),
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(16.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
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
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    labeltext(
                                                      title:
                                                          "${widget.paymentResponse.applicantName}",
                                                    ),
                                                    labeltext(
                                                      label: "S/O,D/o,/W/O:",
                                                      title:
                                                          "${widget.paymentResponse.applicantName}",
                                                    ),
                                                    labeltext(
                                                      label: "DOB: ",
                                                      title:
                                                          "${getDate(dateTime: widget.permit.applcntDOB?.toIso8601String())}",
                                                    ),
                                                    labeltext(
                                                        label: "Address: ",
                                                        title:
                                                            "${widget.permit.applcntState} ${widget.permit.applcntDistrict} ${widget.permit.applcntAddress} ${widget.permit.applcntPoliceStation}"
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
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              "${widget.applicantId}",
                                              style: TextStyle(
                                                  fontSize: 36,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
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
                                                    data:
                                                        d!.toJson().toString(),
                                                    size: mmToDp(45),
                                                    embeddedImage: AssetImage(
                                                        'assets/manimap.jpeg'),
                                                    version: QrVersions.auto,
                                                  )
                                                : SizedBox(),
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(16.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    labeltext(
                                                        label: 'Residing: ',
                                                        title:
                                                            "${widget.permit.district} ${widget.permit.placeOfStay} ${widget.permit.pinCode} "),
                                                    labeltext(
                                                        label: "Purpose: ",
                                                        title:
                                                            "${widget.permit.purposeVisit}"),
                                                    widget.permit.lrName != null
                                                        ? labeltext(
                                                            label: "LR: ",
                                                            title:
                                                                "${widget.permit.lrName} ${widget.permit.lrPhone != null ? ', Ph No.:' : " "}${widget.permit.lrPhone ?? ""}",
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
                                              'Date of Issue:\n${d != null && d!.dateOfIssue != null ? DateFormat('dd/MM/yyyy').format(d!.dateOfIssue!) : widget.paymentResponse.dateOfIssue!.split(' ')[0]}',
                                              style: TextStyle(
                                                  fontSize: 22,
                                                  color: Colors.black),
                                            ),
                                            SizedBox(
                                              width: 30,
                                            ),
                                            Text(
                                                'Date of Expiry:\n${d != null && d!.dateOfIssue != null ? DateFormat('dd/MM/yyyy').format(d!.validUpto!) : widget.paymentResponse.validUpto!.split(' ')[0]}',
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
                                          angle: 1.54, child: Icon(Icons.cut)),
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
                                                    fontSize: 26,
                                                    color: Colors.black)),
                                            Text("Temporary Permit",
                                                style: TextStyle(
                                                    fontSize: 26,
                                                    color: Colors.black))
                                          ],
                                        ),

                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Permit Fee",
                                                style: TextStyle(
                                                    fontSize: 26,
                                                    color: Colors.black)),
                                            Text(
                                                "${widget.permitfee.toStringAsFixed(2)}",
                                                style: TextStyle(
                                                    fontSize: 26,
                                                    color: Colors.black))
                                          ],
                                        ),

                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Processing Fee",
                                                style: TextStyle(
                                                    fontSize: 26,
                                                    color: Colors.black)),
                                            Text(
                                                "${widget.paymentResponse.processingfee?.toStringAsFixed(2)}",
                                                style: TextStyle(
                                                    fontSize: 26,
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
                                                    fontSize: 26,
                                                    color: Colors.black)),
                                            Text(
                                                "${(widget.paymentResponse.amount! + widget.paymentResponse.processingfee!).toStringAsFixed(2)}",
                                                style: TextStyle(
                                                    fontSize: 26,
                                                    color: Colors.black))
                                          ],
                                        ),
                                        SizedBox(
                                          height: 80,
                                        ),
                                        Text(
                                          "This is an electronically generated Inner Line Permit Card, hence no signature or seal is required.",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black),
                                          textAlign: TextAlign.center,
                                        ),
                                        Text(
                                            "https://manipurilponline.mn.gov.in/",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
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

                      SizedBox(height: 20),
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
