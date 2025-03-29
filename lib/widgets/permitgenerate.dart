import 'package:barcode_widget/barcode_widget.dart' show Barcode, BarcodeWidget;
import 'package:camera_windows_example/cons/utils.dart';
import 'package:camera_windows_example/controller/imagecapture.dart';
import 'package:camera_windows_example/controller/managementcontroller.dart';
import 'package:camera_windows_example/models/paymentresponse.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';


class PermitGenerateWidget extends StatefulWidget {
  const PermitGenerateWidget({super.key, 
  required this.applicantId, required this.keys,
  req, required this.paymentResponse
   }

  );
  final PaymentResponse paymentResponse;
  final String applicantId;
  final GlobalKey keys;
  @override
  State<PermitGenerateWidget> createState() => _PermitGenerateWidgetState();
}

class _PermitGenerateWidgetState extends State<PermitGenerateWidget> {
  @override
  Widget build(BuildContext context) {
      double dpi = MediaQuery.of(context).devicePixelRatio * 160; // DPI of screen
    double mmToDp(double mm) => (mm / 25.4) * dpi;
  
    return GetBuilder<Managementcontroller>(
      builder: (mngctrl) {
        return GetBuilder<Imagecontroller>(
          builder: (imgcon) {
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
                                 Image.asset('assets/images/ILPLOGOSS.png',height: 80,width: 80,),
                                 Image.asset('assets/images/Kanglashanew1.png',height: 80,width:80),
                                 
                               ],
                             ),
                             SizedBox(height: 20,),
                             Text("ILP MANIPUR",style: TextStyle(fontSize: 36,color: Colors.black),),
                             Text("Temporary Inner Line Permit",style: TextStyle(fontSize: 36,color: Colors.black),),
                             Text("12/3/2025",style: TextStyle(fontSize: 24,color: Colors.black),),
                             SizedBox(height: 40,),
                              Text("Permit No:",style: TextStyle(fontSize:24,color: Colors.black),),

                              BarcodeWidget(
            
                                 barcode: Barcode.code128(), // Barcode format
                                 data: '${widget.applicantId}',
                                 width: mmToDp(60),
                                 height: mmToDp(20),
                                 drawText: true,
                                 style: TextStyle(fontSize: 24,color: Colors.black),
                               ),
                                SizedBox(height: 40,),

                               Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                  
                                   imgcon.profileImage!=null? Center(child: Image.memory(imgcon.profileImage!,height: mmToDp(35),width: mmToDp(35),)):SizedBox(),
                                   Text("${mngctrl.getPermit?.applcntName??"" }",style: TextStyle(fontSize:30,color: Colors.black)),
                                   Row(
                                     children: [
                                       Text("SO/DO/WO:",style: TextStyle(fontSize:30,color: Colors.black)),
                                        Expanded(child: Text("${mngctrl.currentPermit?.applcntParent}")),
                                    
                                     ],
                                   ),
                                   Text("DOB:${getDate(dateTime:  mngctrl.getPermit?.applcntDOB) }",style: TextStyle(fontSize:30,color: Colors.black)),
                                                  Row(
                                     children: [
                                       Text("Address: ",style: TextStyle(fontSize:30,color: Colors.black)),
                                        Expanded(child: Text("${mngctrl.currentPermit?.applcntAddress}")),
                                    
                                     ],
                                   ),
                                                     Row(
                                     children: [
                                       Text("Residing:",style: TextStyle(fontSize:30,color: Colors.black)),
                                        Expanded(child: Text("${mngctrl.currentPermit?.placeOfStay}")),
                                    
                                     ],
                                   ),
                                     Text("Validity: ${mngctrl.getPermitPrice?.validityDays}",style: TextStyle(fontSize:30,color: Colors.black)),
                                   Text("Date of Issue: ${getDate(dateTime: DateTime.now().toIso8601String())}",style: TextStyle(fontSize:30,color: Colors.black)),
                                   Text("Date of Expiry: ${getDate(dateTime: DateTime.now().add(Duration(days: 30) ).toIso8601String())}",style: TextStyle(fontSize:30,color: Colors.black)),
                                 ],
                               ),
                               SizedBox(height:20),
                               /// QR Code
                             QrImageView(
                               data:widget.paymentResponse.toJson().toString(),
                               size: mmToDp(50),
                               embeddedImage: AssetImage('assets/images/ilplogo2.png'),
                               version: QrVersions.auto,
                             ),
                               SizedBox(height:20),
                             Row(
                               children: [
                                   Icon(Icons.cut),
                                 Expanded(child: Divider(color: Colors.black,)),
                             
                               ],
                             ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    Text("Receipt  ${widget.paymentResponse.orderId}",style: TextStyle(fontSize:36,color: Colors.black)),
                                                              // Spacer(),
                                        Row(
                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                   children: [
                                                     Text("Type",style: TextStyle(fontSize:30,color: Colors.black)),
                                                     Text("Temporary Permit",style: TextStyle(fontSize:30,color: Colors.black))
                                                   ],
                                                 ),
                  
                                                      Row(
                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                   children: [
                                                     Text("Permit Fee",style: TextStyle(fontSize:30,color: Colors.black)),
                                                     Text("${mngctrl.getPermitPrice?.fee}",style: TextStyle(fontSize:30,color: Colors.black))
                                                   ],
                                                 ),
                                                          Row(
                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                   children: [
                                                     Text("Amount",style: TextStyle(fontSize:30,color: Colors.black)),
                                                     Text("${widget.paymentResponse.amount}",style: TextStyle(fontSize:30,color: Colors.black))
                                                   ],
                                                 ),
                                                 Divider(color: Colors.black,),
                                                            Row(
                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                   children: [
                                                     Text("Total",style: TextStyle(fontSize:30,color: Colors.black)),
                                                     Text("${widget.paymentResponse.amount}",style: TextStyle(fontSize:30,color: Colors.black))
                                                   ],
                                                 ),
                                                  SizedBox(height: 40,),
                                                  Text("This is an electronically generated Inner Line Permit Card, hence no signature is required.",style: TextStyle(fontSize:24,color: Colors.black),textAlign: TextAlign.center,),
                                                  Text("https://manipurilponline.mn.gov.in/",style: TextStyle(fontSize:24,color: Colors.black),textAlign: TextAlign.center),
                                  ],
                                ),
                              ),
                           ],
                         ),
                       ],
                     ),
                   ),
                 ),
            
                 ElevatedButton(onPressed: (){
                  
                 }, child: Text("Print"))
               ],
             );
          }
        );
      }
    );
  }
}