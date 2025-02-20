import 'package:camera_windows_example/controller/pagecontroller.dart';
import 'package:camera_windows_example/controller/paymentcontroller.dart';
import 'package:camera_windows_example/home/landingpage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SuccessPage extends StatelessWidget {
  final String transactionstatus;
  final int trasactionstatus;
  final String transactionid;
  final String paymentmethodname;
  final String totalamount;

  const SuccessPage(
      {super.key,
      required this.transactionstatus,
      required this.transactionid,
      required this.trasactionstatus,
      required this.paymentmethodname,
      required this.totalamount});

  @override
  Widget build(BuildContext context) {
    PagenavControllers pgcon = Get.put(PagenavControllers());
    GetxTapController gcontroller = Get.put(GetxTapController());
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<GetxTapController>(builder: (_) {
        return SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Center(
            child: Card(
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    trasactionstatus == 100
                        ? Image.asset(
                            'assets/images/cancel.gif',
                            height: 130,
                          )
                        : trasactionstatus == 200
                            ? Text('Success Transaction') //  Gif(
                            //     height: 130,
                            //     autostart: Autostart.once,
                            //     image: const AssetImage(
                            //         'assets/images/paymentsuccess.gif'),
                            //     fit: BoxFit.fill,
                            //   )
                            : Image.asset(
                                'assets/images/fail.png',
                                height: 130,
                              ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      transactionstatus,
                      style: const TextStyle(fontSize: 22),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text('Transaction ID : $transactionid'),
                    const SizedBox(
                      height: 10,
                    ),
                    trasactionstatus == 200
                        ? Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ElevatedButton(
                                      style: ButtonStyle(
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          18.0),
                                                  side: const BorderSide(
                                                      color: Colors.grey)))),
                                      onPressed: () {
                                        pgcon.setmainpageindex(ind: 0);
                                        Get.offAll(LandingPage());
                                        // context.router.replaceNamed('/');
                                      },
                                      child: const Text('Back to Home')),
                                  SizedBox(
                                    width: 50,
                                  ),
                                  ElevatedButton(
                                      style: ButtonStyle(
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          18.0),
                                                  side: const BorderSide(
                                                      color: Colors.grey)))),
                                      onPressed: () {
                                        // gcontroller.getDownloadReciept(
                                        //     paymentname: paymentmethodname,
                                        //     amount: totalamount);
                                      },
                                      child: const Text('Get PDF Receipt')),
                                ],
                              ),
                              gcontroller.isdownloadedfile != null &&
                                      gcontroller.isdownloadedfile!
                                  ? ElevatedButton(
                                      onPressed: () {
                                        pgcon.setmainpageindex(ind: 0);
                                        Get.offAll(LandingPage());
                                        // context.router.replaceNamed('/');
                                      },
                                      child: const Text('Back to Home'))
                                  : const SizedBox()
                            ],
                          )
                        : ElevatedButton(
                            onPressed: () {
                              // context.router.replaceNamed('/');
                            },
                            child: const Text('Back to Home'))
                  ],
                ),
              ),
            ),
          ),
        ));
      }),
    );
  }
}
