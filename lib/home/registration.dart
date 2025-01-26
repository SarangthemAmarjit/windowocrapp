import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/pagecontroller.dart';
import 'registrationpages/addressdetails.dart';
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
    return GetBuilder<PageControllers>(builder: (controller) {
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
            Row(
              children: [
                InkWell(
                  // overlayColor:
                  //     WidgetStateProperty.all(Colors.transparent),
                  focusColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  onTap: controller.regPage > 0
                      ? () {
                          controller
                              .changeDashboardPage(controller.regPage - 1);
                        }
                      : null,
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

            SizedBox(
              height: 20,
            ),
            // Row(
            //   children: [
            //     Expanded(
            //         child: Center(
            //             child: Text(
            //       "Personal Details",
            //       style: TextStyle(
            //           fontSize: controller.page == 1 ? 30 : 16,
            //           color: controller.page >= 1 ? Colors.green : null),
            //     ))),
            //     Expanded(
            //         child: Center(
            //             child: Text(
            //       "Address Details",
            //       style: TextStyle(
            //           fontSize: controller.page == 2 ? 30 : 16,
            //           // fontSize: 16,

            //           color: controller.page >= 2 ? Colors.green : null),
            //     ))),
            //     Expanded(
            //         child: Center(
            //             child: Text(
            //       "Permit Details",
            //       style: TextStyle(
            //           fontSize: controller.page == 3 ? 30 : 16,
            //           color: controller.page >= 3 ? Colors.green : null),
            //     ))),
            //     Expanded(
            //         child: Center(
            //             child: Text(
            //       "Photo & Sign",
            //       style: TextStyle(
            //           fontSize: controller.page == 4 ? 30 : 16,
            //           // fontSize: 16,

            //           color: controller.page >= 4 ? Colors.green : null),
            //     ))),
            //     Expanded(
            //         child: Center(
            //             child: Text(
            //       "Payment",
            //       style: TextStyle(
            //           fontSize: controller.page == 5 ? 30 : 16,
            //           // fontSize: 16,

            //           color: controller.page >= 5 ? Colors.green : null),
            //     ))),
            //   ],
            // ),
            SizedBox(
              height: 10,
            ),
            // LayoutBuilder(builder: (context, s) {
            //   double x = ((controller.page / 5) * s.maxWidth);
            //   return AnimatedContainer(
            //     duration: Duration(milliseconds: 300),
            //     height: 5,
            //     width: x,
            //     color: Colors.green,
            //   );
            // }),
            // SizedBox(
            //   height: 10,
            // ),
            // Align(
            //     alignment: Alignment.centerRight,
            //     child: Text(
            //       "Completed: ${controller.page}/5",
            //       style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            //     )),
            // SizedBox(
            //   height: 20,
            // ),
            Expanded(
                child: SingleChildScrollView(
                    child: controller.page == 1
                        ? TemporaryILPForm()
                        : controller.page == 2
                            ? AddressDetails()
                            : controller.page == 3
                                ? PermitDetails()
                                : controller.page == 4
                                    ? PhotoSignaturePage()
                                    : PaymentDetails()))
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