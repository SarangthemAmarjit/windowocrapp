import 'package:camera_windows_example/controller/paymentcontroller.dart';
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
                              FittedBox(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Your Gazzette File is Generated :',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        // gcontroller.getDownloadfile(
                                        //     trnxid: transactionid);
                                      },
                                      //              child: const SizedBox(
                                      //   height: 20,
                                      //   child: SizedBox(
                                      //       width: 20, child: CircularProgressIndicator()),
                                      // ),
                                      child: SizedBox(
                                        height: 30,
                                        child: gcontroller.isdownloadedfile ==
                                                null
                                            ? Image.asset(
                                                'assets/images/download.gif',
                                              )
                                            : gcontroller.isdownloadedfile!
                                                ? Image.asset(
                                                    'assets/images/check.gif')
                                                : const SizedBox(
                                                    width: 20,
                                                    child:
                                                        CircularProgressIndicator()),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              ElevatedButton(
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(18.0),
                                              side: const BorderSide(
                                                  color: Colors.grey)))),
                                  onPressed: () {
                                    // gcontroller.getDownloadReciept(
                                    //     paymentname: paymentmethodname,
                                    //     amount: totalamount);
                                  },
                                  child: const Text('Get PDF Receipt')),
                              gcontroller.isdownloadedfile != null &&
                                      gcontroller.isdownloadedfile!
                                  ? ElevatedButton(
                                      onPressed: () {
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
