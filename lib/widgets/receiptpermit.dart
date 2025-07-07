import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart';

class ReceiptWidget extends StatelessWidget {
  final String applicantName;
  final String applicantId;


  const ReceiptWidget({
    Key? key,
    required this.applicantName,
    required this.applicantId,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double dpi = MediaQuery.of(context).devicePixelRatio * 160; // DPI of screen
    double mmToDp(double mm) => (mm / 25.4) * dpi;

    return Container(
      // width: mmToDp(80), // Convert 80mm to dp
      height: mmToDp(20), // Convert 180mm to dp
      // padding: const EdgeInsets.all(10),
      // decoration: BoxDecoration(
      //   border: Border.all(color: Colors.black),
      //   borderRadius: BorderRadius.circular(5),
      //   color: Colors.white,
      // ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Center(
          //   child: Text(
          //     "Payment Receipt",
          //     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          //   ),
          // ),
          // Divider(thickness: 1),
          // /// Applicant Details
          // Align(alignment: Alignment.centerLeft, child: Text("Applicant Name:", style: TextStyle(fontWeight: FontWeight.bold))),
          // Align(alignment: Alignment.centerLeft, child: Text(applicantName)),
          // SizedBox(height: 5),
          // Align(alignment: Alignment.centerLeft, child: Text("Applicant ID:", style: TextStyle(fontWeight: FontWeight.bold))),
          // Align(alignment: Alignment.centerLeft, child: Text(applicantId)),
          // SizedBox(height: 10),
   
 
          // SizedBox(height: 10),

          /// Barcode
          Center(
            child: BarcodeWidget(
              barcode: Barcode.code128(), // Barcode format
              data: applicantId,
              width: mmToDp(60),
              height: mmToDp(20),
              drawText: true,
            ),
          ),
          // SizedBox(height: 10),

          /// QR Code
          // Center(
          //   child: QrImageView(
          //     data:'''{
          //       applicantid:1284344343,
          //       applcantname:arvind,
          //       house:"fhfjhjfh"
          //     }''',
          //     size: mmToDp(30),
          //     embeddedImage: AssetImage('assets/images/ilplogo2.png'),
          //     version: QrVersions.auto,
          //   ),
          // ),
          // Spacer(),

          // /// Footer
          // Center(child: Text("Thank you!", style: TextStyle(fontWeight: FontWeight.bold))),
        ],
      ),
    );
  }
}
