import 'package:barcode_widget/barcode_widget.dart' show Barcode, BarcodeWidget;
import 'package:camera_windows_example/cons/utils.dart';
import 'package:camera_windows_example/controller/imagecapture.dart';
import 'package:camera_windows_example/controller/managementcontroller.dart';
import 'package:camera_windows_example/models/ilpmodel.dart';
import 'package:camera_windows_example/models/paymentresponse.dart';
import 'package:camera_windows_example/models/permit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PermitGenerateWidget extends StatefulWidget {
  const PermitGenerateWidget(
      {super.key,
      required this.applicantId,
      required this.keys,
      req,
      required this.paymentResponse});
  final PaymentResponse paymentResponse;
  final String applicantId;
  final GlobalKey keys;
  @override
  State<PermitGenerateWidget> createState() => _PermitGenerateWidgetState();
}

class _PermitGenerateWidgetState extends State<PermitGenerateWidget> {
  IlPmodel? d;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    VisitorEntry? _permit = Get.find<Managementcontroller>().getPermit;
    d = IlPmodel(
        id: 0,
        applicationNo: "",
        name: _permit?.applcntName ?? "NA",
        parentName: _permit?.applcntParent ?? "NA",
        idProof: _permit?.idProof ?? "NA",
        idNo: "",
        gender: _permit?.applcntGender ?? "NA",
        dob: _permit?.applcntDOB ?? "NA",
        idMark: "NA",
        occupation: "Na",
        photo: "NA",
        signature: "NA",
        idCard: "NA",
        state: _permit?.applcntState ?? "NA",
        policeStation: _permit?.applcntPoliceStation ?? "NA",
        district: _permit?.applcntDistrict ?? "NA",
        houseNo: "NA",
        tehsil: _permit?.applcntTehsil ?? "NA",
        village: _permit?.applcntVillage ?? "NA",
        applicationDate: DateTime.now().toIso8601String(),
        entryBy: '0',
        entryType: 'Temporary',
        permitNo: widget.applicantId,
        permitId: 0,
        permitType: 'Temporary Permit',
        purposeCategory: _permit?.purposeVisit ?? "NA",
        purpose: _permit?.purposeVisit ?? "NA",
        residingPeriodEst: "30",
        residingPlace: _permit?.placeOfStay ?? "NA",
        residingLandmark: "NA",
        residingDistrict: _permit?.district ?? "",
        residingPinCode: _permit?.pinCode ?? "NA",
        localResident: "NA",
        localResidentPhone: "NA",
        nearestPs: _permit?.nearestPS ?? "NA",
        sponsorInfo: SponsorInfo(
            sponsorId: '0',
            name: "ILP Manipur",
            address: "Manipur",
            phone: "9876543219",
            department: "Home"),
        agencyInfo: AgencyInfo(
            agencyId: '0',
            name: 'ILP',
            address: "Manipur",
            phone: "9843214321",
            workName: "ILP",
            workDuration: "30",
            engagementPurpose: ""),
        applicantCategory: "Temporary",
        department: "ILP Manipur",
        workPlace: "Manupur",
        gateId: 0,
        gateName: "Airport",
        issueDate: DateTime.now(),
        validDate: DateTime.now().add(Duration(days: 30)),
        processingDistrictId: 0,
        type: "ILP",
        office: "ILP Office",
        authority: "ILP Office",
        authorityDesignation: "ILP",
        issueBy: "ILP Wing",
        status: true,
        revokeDate: "NA",
        revokeReason: "NA",
        revokeBy: "NA",
        isExit: false,
        transitDate: getDate(dateTime: DateTime.now().toIso8601String()),
        transitGateId: "0",
        transitAuthUser: "ILP Office");
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
              child: Container(
                color: Colors.white,
                width: mmToDp(80),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(
                              'assets/images/ILPLOGOSS.png',
                              height: 80,
                              width: 80,
                            ),
                            Image.asset('assets/images/Kanglashaok.png',
                                height: 80, width: 80),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "INNER LINE PERMIT",
                          style: TextStyle(
                              fontSize: 36,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "GOVERNMENT OF MANIPUR",
                          style: TextStyle(
                              fontSize: 36,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Temporary Permit",
                          style: TextStyle(fontSize: 36, color: Colors.black),
                        ),
                        Text(
                          "12/3/2025",
                          style: TextStyle(fontSize: 24, color: Colors.black),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Text(
                          "Permit No:",
                          style: TextStyle(fontSize: 24, color: Colors.black),
                        ),

                        BarcodeWidget(
                          barcode: Barcode.code128(), // Barcode format
                          data: '${widget.applicantId}',
                          width: mmToDp(60),
                          height: mmToDp(20),
                          drawText: true,
                          style: TextStyle(fontSize: 24, color: Colors.black),
                        ),
                        SizedBox(
                          height: 40,
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Id Proof:",
                                    style: TextStyle(
                                        fontSize: 30, color: Colors.black)),
                                Expanded(
                                    child: Text(
                                        "${mngctrl.currentPermit?.idProof}",
                                        style: TextStyle(
                                            fontSize: 30,
                                            color: Colors.black))),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Id No:",
                                    style: TextStyle(
                                        fontSize: 30, color: Colors.black)),
                                Expanded(
                                    child: Text(
                                        "${mngctrl.currentPermit?.idNo}",
                                        style: TextStyle(
                                            fontSize: 30,
                                            color: Colors.black))),
                              ],
                            ),
                            imgcon.profileImage != null
                                ? Center(
                                    child: Image.memory(
                                    imgcon.profileImage!,
                                    height: mmToDp(35),
                                    width: mmToDp(35),
                                  ))
                                : SizedBox(),
                            Text("${mngctrl.getPermit?.applcntName ?? ""}",
                                style: TextStyle(
                                    fontSize: 30, color: Colors.black)),
                            Row(
                              children: [
                                Text("SO/DO/WO:",
                                    style: TextStyle(
                                        fontSize: 30, color: Colors.black)),
                                Expanded(
                                    child: Text(
                                        "${mngctrl.currentPermit?.applcntParent}",
                                        style: TextStyle(
                                            fontSize: 30,
                                            color: Colors.black))),
                              ],
                            ),
                            Text(
                                "DOB:${getDate(dateTime: mngctrl.getPermit?.applcntDOB)}",
                                style: TextStyle(
                                    fontSize: 30, color: Colors.black)),
                            Text(
                                "Gender:${getDate(dateTime: mngctrl.getPermit?.applcntGender)}",
                                style: TextStyle(
                                    fontSize: 30, color: Colors.black)),
                            Row(
                              children: [
                                Text("State: ",
                                    style: TextStyle(
                                        fontSize: 30, color: Colors.black)),
                                Expanded(
                                    child: Text(
                                        "${mngctrl.currentPermit?.applcntState}",
                                        style: TextStyle(
                                            fontSize: 30,
                                            color: Colors.black))),
                              ],
                            ),
                            Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("District: ",
                                    style: TextStyle(
                                        fontSize: 30, color: Colors.black)),
                                Expanded(
                                    child: Text(
                                        "${mngctrl.currentPermit?.applcntDistrict}",
                                        style: TextStyle(
                                            fontSize: 30,
                                            color: Colors.black))),
                              ],
                            ),
                            Row(
                              
                              children: [
                                Text("Police Station: ",
                                    style: TextStyle(
                                        fontSize: 30, color: Colors.black)),
                                Expanded(
                                    child: Text(
                                        "${mngctrl.currentPermit?.applcntPoliceStation}",
                                        style: TextStyle(
                                            fontSize: 30,
                                            color: Colors.black))),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Address: ",
                                    style: TextStyle(
                                        fontSize: 30, color: Colors.black)),
                                Expanded(
                                    child: Text(
                                                // "SDHFjdhfjkdhfhf fhdjfhjkdfh fhdjfhkfhdkjhk",
                                        "${mngctrl.currentPermit?.applcntAddress}",
                                       
                                       
                                        style: TextStyle(
                                            fontSize: 30,
                                            color: Colors.black))),
                              ],
                            ),
                            Row(
                              children: [
                                Text("Residing:",
                                    style: TextStyle(
                                        fontSize: 30, color: Colors.black)),
                                Expanded(
                                    child: Text(
                                        "${mngctrl.currentPermit?.placeOfStay}",
                                        style: TextStyle(
                                            fontSize: 30,
                                            color: Colors.black))),
                              ],
                            ),
                            Row(
                              children: [
                                Text("Nearest Ps: ",
                                    style: TextStyle(
                                        fontSize: 30, color: Colors.black)),
                                Expanded(
                                    child: Text(
                                        "${mngctrl.currentPermit?.nearestPS}",
                                        style: TextStyle(
                                            fontSize: 30,
                                            color: Colors.black))),
                              ],
                            ),
                            Row(
                              children: [
                                Text("Purpose: ",
                                    style: TextStyle(
                                        fontSize: 30, color: Colors.black)),
                                Expanded(
                                    child: Text(
                                        "${mngctrl.currentPermit?.purposeVisit}",
                                        style: TextStyle(
                                            fontSize: 30,
                                            color: Colors.black))),
                              ],
                            ),
                            Text(
                                "Validity: ${mngctrl.getPermitPrice?.validityDays}",
                                style: TextStyle(
                                    fontSize: 30, color: Colors.black)),
                            Text(
                                "Date of Issue: ${getDate(dateTime: DateTime.now().toIso8601String())}",
                                style: TextStyle(
                                    fontSize: 30, color: Colors.black)),
                            Text(
                                "Date of Expiry: ${getDate(dateTime: DateTime.now().add(Duration(days: 30)).toIso8601String())}",
                                style: TextStyle(
                                    fontSize: 30, color: Colors.black)),
                          ],
                        ),
                        SizedBox(height: 20),

                        /// QR Code
                        d != null
                            ? QrImageView(
                                data: d!.toJson().toString(),
                                size: mmToDp(50),
                                embeddedImage:
                                    AssetImage('assets/images/ilplogo2.png'),
                                version: QrVersions.auto,
                              )
                            : SizedBox(),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Icon(Icons.cut),
                            Expanded(
                                child: Divider(
                              color: Colors.black,
                            )),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Text(
                                  "Receipt: #${widget.paymentResponse.orderId}",
                                  style: TextStyle(
                                      fontSize: 36, color: Colors.black)),
                              // Spacer(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Type",
                                      style: TextStyle(
                                          fontSize: 30, color: Colors.black)),
                                  Text("Temporary Permit",
                                      style: TextStyle(
                                          fontSize: 30, color: Colors.black))
                                ],
                              ),

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Permit Fee",
                                      style: TextStyle(
                                          fontSize: 30, color: Colors.black)),
                                  Text("${mngctrl.getPermitPrice?.fee}",
                                      style: TextStyle(
                                          fontSize: 30, color: Colors.black))
                                ],
                              ),

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Processing Fee",
                                      style: TextStyle(
                                          fontSize: 30, color: Colors.black)),
                                  Text(
                                      "${widget.paymentResponse.amount - (mngctrl.getPermitPrice!=null?mngctrl.getPermitPrice!.fee:0.0)}",
                                      style: TextStyle(
                                          fontSize: 30, color: Colors.black))
                                ],
                              ),

                              Divider(
                                color: Colors.black,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Total",
                                      style: TextStyle(
                                          fontSize: 30, color: Colors.black)),
                                  Text("${widget.paymentResponse.amount}",
                                      style: TextStyle(
                                          fontSize: 30, color: Colors.black))
                                ],
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              Text(
                                "This is an electronically generated Inner Line Permit Card, hence no signature is required.",
                                style: TextStyle(
                                    fontSize: 24, color: Colors.black),
                                textAlign: TextAlign.center,
                              ),
                              Text("https://manipurilponline.mn.gov.in/",
                                  style: TextStyle(
                                      fontSize: 24, color: Colors.black),
                                  textAlign: TextAlign.center),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
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
