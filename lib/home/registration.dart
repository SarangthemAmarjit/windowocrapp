import 'package:camera_windows_example/home/registrationpages/facedetect.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/pagecontroller.dart';
import 'registrationpages/addressdetails.dart';
import 'registrationpages/ilpformreplica.dart';
import 'registrationpages/paymentdetails.dart';
import 'registrationpages/permittypes.dart';
import 'registrationpages/ilpform.dart';
import 'registrationpages/photodetails.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});
  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PagenavControllers>(builder: (controller) {
      return Container(
        // padding: EdgeInsets.all(32),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  InkWell(
                    // overlayColor:
                    //     WidgetStateProperty.all(Colors.transparent),
                    focusColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    onTap: 
                         () {
                       
                                if(controller.regPage==0){
                                    controller.setmainpageindex(ind: 0);
                                }else{
                                controller
                                .changeDashboardPage(controller.regPage - 1);
                                }
                          },
                      
                    child: Transform.flip(
                      flipX: true,
                      child: Image.asset(
                        'assets/images/next2.png',
                        height: 60,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Registration",
                    style: TextStyle(fontSize: 30),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: (){
                      controller.changePage(1);
                    },
                    child: Center(
                          child: Text(
                    "Personal Details",
                    style: TextStyle(
                        fontSize: controller.page == 1 ? 30 : 16,
                        color: controller.page >= 1 ? Colors.green : null),
                  )),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: (){
                    controller.changePage(2);
                  },
                    child: Center(
                          child: Text(
                    "Profile Image",
                    style: TextStyle(
                        fontSize: controller.page == 2 ? 30 : 16,
                        // fontSize: 16,
                  
                        color: controller.page >= 2 ? Colors.green : null),
                  )),
                  ),
                ),
 
                Expanded(
                  child: InkWell(
                    onTap: (){
                      controller.changePage(3);
                    },
                    child: Center(
                          child: Text(
                    "Payment",
                    style: TextStyle(
                        fontSize: controller.page == 3 ? 30 : 16,
                        // fontSize: 16,
                  
                        color: controller.page >= 3 ? Colors.green : null),
                  )),
                  ),
                ),
              ],
            ),
       
            LayoutBuilder(builder: (context, s) {
              double x = ((controller.page / 3) * s.maxWidth);
              return AnimatedContainer(
                duration: Duration(milliseconds: 300),
                height: 5,
                width: x,
                color: Colors.green,
              );
            }),
            SizedBox(
              height: 10,
            ),
            Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "Completed: ${controller.page}/3",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                )),
            SizedBox(
              height: 20,
            ),
            controller.page == 1
                ? TemporaryILPFormReplica()
             
                //     : controller.page == 3
                //         ? PermitDetails()
                        : controller.page == 2
                            ? PhotoSignaturePage()
                            // ?FaceDetectionPage()
                            : PaymentDetails()
          ],
        ),
      );
    });
  }
}

// class TextFieldWidget extends StatelessWidget {
//   const TextFieldWidget({
//     super.key, required this.label,
//   });
//   final String label;
  
//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(

//       decoration: InputDecoration(
//         labelText: label,
//         fillColor: Colors.grey[100],
//         filled: true,
//         border: OutlineInputBorder(),
//       ),
//     );
//   }
// }