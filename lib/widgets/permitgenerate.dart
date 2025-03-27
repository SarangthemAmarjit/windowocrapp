import 'package:barcode_widget/barcode_widget.dart' show Barcode, BarcodeWidget;
import 'package:camera_windows_example/controller/imagecapture.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PermitGenerateWidget extends StatefulWidget {
  const PermitGenerateWidget({super.key, required this.applicantId}

  );
  final String applicantId;
  @override
  State<PermitGenerateWidget> createState() => _PermitGenerateWidgetState();
}

class _PermitGenerateWidgetState extends State<PermitGenerateWidget> {
    final GlobalKey _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
      double dpi = MediaQuery.of(context).devicePixelRatio * 160; // DPI of screen
    double mmToDp(double mm) => (mm / 25.4) * dpi;
  
    return GetBuilder<Imagecontroller>(
      builder: (imgcon) {
        return Scaffold(
          body:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RepaintBoundary(
                key: _key,
                child: Container(
                  padding: EdgeInsets.all(16),
                   width: mmToDp(80),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Inner Line Permit"),
                       BarcodeWidget(
                          barcode: Barcode.code128(), // Barcode format
                          data: widget.applicantId,
                          width: mmToDp(30),
                          height: mmToDp(10),
                          drawText: true,
                        ),
                        Text("Sagolsem Arvind"),
                        Text("SO/DO/WO: Sagolsem Arvind"),
                        Text("DOB: 1/3/1996"),
                        Text("Address: KANdhasfsf"),
                    SizedBox(height:20),
                        /// QR Code
                      QrImageView(
                        data:'''{
                            applicantid:1284344343,
                            applcantname:arvind,
                            house:"fhfjhjfh"
                          }''',
                        size: mmToDp(30),
                        embeddedImage: AssetImage('assets/images/ilplogo2.png'),
                        version: QrVersions.auto,
                      ),
                      // Spacer(),
                  
                    ],
                  ),
                ),
              ),

              ElevatedButton(onPressed: (){
                imgcon.saveReceiptimages(_key);
              }, child: Text("Print"))
            ],
          ) ,
        );
      }
    );
  }
}