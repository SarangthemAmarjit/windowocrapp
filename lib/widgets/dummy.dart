import 'package:camera_windows_example/controller/imagecapture.dart';
import 'package:camera_windows_example/models/paymentresponse.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'permitgenerate copy.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  final GlobalKey d = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          PermitGenerateWidgetcopy(
              applicantId: "123784783578",
              keys: d,
              paymentResponse: PaymentResponse(
                  permitType: "Temporary",
                  permitNo: "12375785785",
                  applicantName: "John Doe",
                  applicantParent: "JOhn Smith",
                  idNo: "112374875",
                  dateOfIssue: "12/3/2025",
                  validUpto: "11/4/2025",
                  placeOfStay: "Imphal - Classic Hotel",
                  status: "Success",
                  orderId: "12093059059",
                  transactionId: "ABFFHJS1234",
                  date: '12/3/2025',
                  amount: 100,
                  paymentMode: "online")),
          ElevatedButton(
            onPressed: () {
              Get.find<Imagecontroller>().saveReceiptimages(d);
            },
            child: Text("Press"),
          ),
        ],
      ),
    ));
  }
}
