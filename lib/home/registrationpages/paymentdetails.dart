import 'package:camera_windows_example/cons/utils.dart';
import 'package:camera_windows_example/controller/imagecapture.dart';
import 'package:camera_windows_example/controller/managementcontroller.dart';
import 'package:camera_windows_example/controller/paymentcontroller.dart';
import 'package:camera_windows_example/widgets/bannercard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../cons/constant.dart';
import '../../cons/tandcpolicy.dart';
import '../../controller/pagecontroller.dart';
import '../../widgets/buttoncard.dart';
import '../../widgets/receiptpermit.dart';

class PaymentDetails extends StatelessWidget {
  PaymentDetails({super.key});
  final GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    GetxTapController gcontroller = Get.put(GetxTapController());
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); // Hide keyboard when the screen starts
      },
      child: GetBuilder<Managementcontroller>(builder: (mngctrl) {
        return GetBuilder<Imagecontroller>(builder: (imgcon) {
          return GetBuilder<PagenavControllers>(builder: (controller) {
            return GetBuilder<GetxTapController>(builder: (_) {
              return gcontroller.ispaymentprocessstarted
                  ? Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 400,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Center(
                            child: SizedBox(
                              height: 150,
                              width: 150,
                              child: Image.asset('assets/images/processing.gif'),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 800),
                        child: Container(
                          margin: EdgeInsets.all(16),
                          // padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.2),
                                  spreadRadius: 2,
                                )
                              ]),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Verify Details",
                                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              height: 100,
                                              width: 100,
                                              clipBehavior: Clip.antiAlias,
                                              decoration: BoxDecoration(
                                                  color: Colors.grey[300],
                                                  borderRadius: BorderRadius.circular(8)),
                                              child: imgcon.profileImage != null
                                                  ? Image.memory(
                                                      imgcon.profileImage!,
                                                      height: 120,
                                                      width: 120,
                                                      fit: BoxFit.contain,
                                                    )
                                                  : Center(
                                                      child: Icon(
                                                        Icons.photo,
                                                        color: Colors.grey,
                                                        size: 40,
                                                      ),
                                                    ),
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  mngctrl.getPermit?.applcntName ?? "NA",
                                                  style: TextStyle(
                                                      fontSize: 24, fontWeight: FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Row(
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        TextLabel(
                                                            text: (mngctrl.getPermit?.idProof ??
                                                                "NA")),
                                                        BannerContainer(
                                                            padding: EdgeInsets.all(8),
                                                            margin: EdgeInsets.zero,
                                                            text: mngctrl.getPermit?.idNo ?? "NA",
                                                            color: Colors.green),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      width: 40,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        TextLabel(text: "Gender"),
                                                        TextSubtitle(
                                                          text: mngctrl.getPermit?.applcntGender ??
                                                              "NA",
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      width: 60,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        TextLabel(text: "D.O.B"),
                                                        TextSubtitle(
                                                            text: mngctrl.getPermit != null &&
                                                                    mngctrl.getPermit!.applcntDOB !=
                                                                        null
                                                                ? DateFormat.yMMMEd().format(
                                                                    mngctrl.getPermit!.applcntDOB!)
                                                                : ""),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Divider(),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  TextLabel(text: "Parent's Name"),
                                                  TextSubtitle(
                                                    text: mngctrl.getPermit?.applcntParent ?? "NA",
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  TextLabel(text: "Email"),
                                                  TextSubtitle(
                                                    text: mngctrl.getPermit?.applcntEmail ?? "NA",
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  TextLabel(text: "Phone"),
                                                  TextSubtitle(
                                                      text:
                                                          mngctrl.getPermit?.applcntMobile ?? "NA"),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  TextLabel(text: "State"),
                                                  TextSubtitle(
                                                    text: mngctrl.getPermit?.applcntState ?? "NA",
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  TextLabel(text: "District"),
                                                  TextSubtitle(
                                                    text: mngctrl.getPermit?.district ?? "NA",
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  TextLabel(text: "Address"),
                                                  TextSubtitle(
                                                    text: mngctrl.getPermit?.applcntAddress ?? "NA",
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  TextLabel(text: "Nearest Police Station"),
                                                  TextSubtitle(
                                                    text: mngctrl.getPermit?.applcntPoliceStation ??
                                                        "NA",
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  TextLabel(text: "Tehsil"),
                                                  TextSubtitle(
                                                    text: mngctrl.getPermit?.applcntTehsil ?? "NA",
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  TextLabel(text: "Signature"),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  imgcon.signature != null
                                                      ? Image.memory(
                                                          imgcon.signature!,
                                                          width: 120,
                                                          height: 40,
                                                          fit: BoxFit.fill,
                                                        )
                                                      : Container(
                                                          decoration:
                                                              BoxDecoration(color: Colors.grey),
                                                          height: 100,
                                                          width: 300,
                                                          child: Center(
                                                            child: Text("sig empty"),
                                                          ),
                                                        )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Divider(),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  TextLabel(text: "Period Of Stay"),
                                                  TextSubtitle(
                                                    text:
                                                        "${mngctrl.getPermit?.residingPeriod ?? ""} days",
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  TextLabel(text: "Starting Date"),
                                                  TextSubtitle(
                                                      text: getDate(
                                                          dateTime:
                                                              mngctrl.getPermit?.visitDate ?? "")),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  TextLabel(text: "Purpose"),
                                                  TextSubtitle(
                                                    text: mngctrl.getPermit?.purposeVisit ?? "NA",
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  TextLabel(text: "Place of Stay"),
                                                  TextSubtitle(
                                                    text: mngctrl.getPermit?.placeOfStay ?? "NA",
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  TextLabel(text: "Local Residence"),
                                                  TextSubtitle(
                                                    text:
                                                        "${mngctrl.getPermit?.lrName ?? "NA"} ${mngctrl.getPermit?.lrPhone ?? ""} ",
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(child: SizedBox()),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ).animate().fadeIn(
                                  duration: Duration(milliseconds: 900),
                                  delay: Duration(milliseconds: 300)),
                              SizedBox(
                                height: 10,
                              ),
                              Divider(),
                              PaymentCard(
                                mngctrl: mngctrl,
                              ).animate().fadeIn(
                                  duration: Duration(milliseconds: 1200),
                                  delay: Duration(milliseconds: 600)),
                            ],
                          ),
                        )
                            .animate()
                            .scaleXY(
                                begin: 0.7,
                                end: 1,
                                curve: Curves.easeInCubic,
                                duration: Duration(milliseconds: 600))
                            .fadeIn(duration: Duration(milliseconds: 500)),
                      ),
                    );
            });
          });
        });
      }),
    );
  }
}

class PaymentCard extends StatefulWidget {
  const PaymentCard({
    super.key,
    required this.mngctrl,
  });
  final Managementcontroller mngctrl;

  @override
  State<PaymentCard> createState() => _PaymentCardState();
}

class _PaymentCardState extends State<PaymentCard> {
  final GlobalKey _globlkey = GlobalKey();
  bool isload = false;
  @override
  Widget build(BuildContext context) {
    GetxTapController gcontroller = Get.put(GetxTapController());
    return GetBuilder<PagenavControllers>(builder: (pagectrl) {
      return GetBuilder<Imagecontroller>(builder: (imgcon) {
        return GetBuilder<Managementcontroller>(builder: (mngctrl) {
          return GetBuilder<GetxTapController>(builder: (_) {
            return Container(
              width: double.infinity,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BannerContainer(
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          margin: EdgeInsets.zero,
                          text: "Payments",
                          color: Colors.green,
                        ),
                        // Divider(),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                child: Text(
                              "Permit Type",
                              style: TextStyle(fontSize: 16),
                            )),
                            Expanded(
                                flex: 3,
                                child: Divider(
                                  endIndent: 80,
                                  indent: 80,
                                )),
                            Expanded(
                                child: Text(
                              "Temporary Permit",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            )),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                child: Text(
                              "Permit Validity",
                              style: TextStyle(fontSize: 16),
                            )),
                            Expanded(
                                flex: 3,
                                child: Divider(
                                  endIndent: 80,
                                  indent: 80,
                                )),
                            Expanded(
                                child: Text("${mngctrl.getPermitPrice?.validityDays ?? 30} days",
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                child: Text(
                              "From",
                              style: TextStyle(fontSize: 16),
                            )),
                            Expanded(
                                flex: 3,
                                child: Divider(
                                  endIndent: 80,
                                  indent: 80,
                                )),
                            Expanded(
                                child: Text(
                              getDate(dateTime: mngctrl.getPermit?.visitDate ?? ""),
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            )),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                child: Text(
                              "To",
                              style: TextStyle(fontSize: 16),
                            )),
                            Expanded(
                                flex: 3,
                                child: Divider(
                                  endIndent: 80,
                                  indent: 80,
                                )),
                            Expanded(
                                child: Text(
                              getDate(
                                  dateTime: mngctrl.getPermit?.visitDate ?? "",
                                  duration: (mngctrl.getPermitPrice?.validityDays ?? 30) - 1),
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            )),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                child: Text(
                              "Amount",
                              style: TextStyle(fontSize: 16),
                            )),
                            Expanded(
                                flex: 3,
                                child: Divider(
                                  endIndent: 80,
                                  indent: 80,
                                )),
                            Expanded(
                                child: Text(
                              "$rupee ${mngctrl.getPermitPrice?.fee ?? 100}",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            )),
                          ],
                        ),
                        Divider(),
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                            child: Text(
                          "$rupee ${mngctrl.getPermitPrice?.fee ?? 100}",
                          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                        )),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "By Clicking on Register permit you agree to our following terms and conditions.",
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Please read the following privacy policy, payments instructions and refund policy before proceeding.",
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: terms
                        .asMap()
                        .entries
                        .map(
                          (e) => Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: InkWell(
                                onTap: () {
                                  Get.dialog(Dialog(
                                    child: Container(
                                      padding: EdgeInsets.all(32),
                                      height: e.key == 2 ? 300 : 700,
                                      width: 600,
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "${e.value}",
                                                style: TextStyle(fontSize: 18),
                                              ),
                                              IconButton(
                                                  onPressed: () {
                                                    Get.back();
                                                  },
                                                  icon: Icon(Icons.close))
                                            ],
                                          ),
                                          Divider(),
                                          Expanded(
                                            child: ListView(
                                              shrinkWrap: true,
                                              children: termspolicies[e.key]
                                                  .asMap()
                                                  .entries
                                                  .map(
                                                    (f) => ListTile(
                                                      title: Text(
                                                        "${f.key + 1}",
                                                        style: TextStyle(fontSize: 16),
                                                      ),
                                                      subtitle: Text(
                                                        f.value,
                                                        style: TextStyle(fontSize: 20),
                                                      ),
                                                    ),
                                                  )
                                                  .toList(),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ));
                                },
                                child: Text(
                                  e.value,
                                  style: GoogleFonts.interTight(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: Theme.of(context).colorScheme.secondary),
                                )),
                          ),
                        )
                        .toList(),
                  ),
                  ButtonCard(
                      title: "Register Permit",
                      icon: isload
                          ? SizedBox(
                              height: 20,
                              width: 20,
                              child: Center(
                                  child: CircularProgressIndicator(
                                strokeWidth: 0.5,
                              )))
                          : null,
                      onpress: () async {
                        showDialog(
                            context: context,
                            builder: (c) {
                              return StatefulBuilder(builder: (context, sta) {
                                return AlertDialog(
                                  insetPadding: EdgeInsets.all(16),
                                  content: Container(
                                    width: 600,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Processing Permit",
                                              style: TextStyle(fontSize: 24),
                                            ),
                                            IconButton(
                                                onPressed: () {
                                                  Get.back();
                                                },
                                                icon: Icon(Icons.close))
                                          ],
                                        ),
                                        isload
                                            ? Padding(
                                                padding: const EdgeInsets.all(32.0),
                                                child: Column(
                                                  children: [
                                                    CircularProgressIndicator(
                                                      color: Colors.blue,
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    Text(
                                                      "Creating Permit. Please Wait",
                                                      style: TextStyle(fontSize: 20),
                                                    )
                                                  ],
                                                ),
                                              )
                                            : SizedBox()
                                      ],
                                    ),
                                  ),
                                  actions: isload
                                      ? null
                                      : [
                                          ButtonCard(
                                              padding: EdgeInsets.symmetric(vertical: 8),
                                              icon: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                                child: Icon(
                                                  Icons.laptop_mac_rounded,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              title: "Pay at ILP Counter ",
                                              onpress: () async {
                                                sta(() {
                                                  isload = true;
                                                });

                                                Map<String, dynamic>? s =
                                                    await mngctrl.addtemporaryPermit(
                                                  true,
                                                  imgcon.profileImage!,
                                                  imgcon.idCardimage!,
                                                  imgcon.signature!,
                                                );

                                                sta(() {
                                                  isload = false;
                                                });
                                                Get.back();

                                                if (s.isNotEmpty && s["appid"] != null) {
                                                  Get.dialog(AlertDialog(
                                                    content: RepaintBoundary(
                                                        key: _globlkey,
                                                        child: ReceiptWidget(
                                                            applicantName:
                                                                mngctrl.getPermit?.applcntName ??
                                                                    "NA",
                                                            applicantId: s['appid'])),
                                                  ));
                                                  Future.delayed(Duration(seconds: 3)).then(
                                                    (value) async {
                                                      print("nav Keys sdsd");
                                                      await imgcon.saveReceipt(
                                                          _globlkey,
                                                          s["appid"],
                                                          "Your Permit request is registered.");
                                                      print("nav Keys");

                                                      Get.back();
                                                      pagectrl.pageIncremeter(4);
                                                      pagectrl.setmainpageindex(ind: 4);
                                                    },
                                                  );
                                                } else {
                                                  Get.back();
                                                  String? message = s['message'];

                                                  Get.dialog(
                                                      barrierDismissible: false,
                                                      _errorDialog(pagectrl, imgcon,
                                                          message: message));
                                                }
                                              }),
                                          ButtonCard(
                                              icon: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                                child: Icon(
                                                  Icons.money_sharp,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              padding: EdgeInsets.symmetric(vertical: 8),
                                              title: "Pay Online",
                                              onpress: () async {
                                                sta(() {
                                                  isload = true;
                                                });

                                                Map<String, dynamic> s = await mngctrl
                                                    .addtemporaryPermit(
                                                      false,
                                                      imgcon.profileImage!,
                                                      imgcon.idCardimage!,
                                                      imgcon.signature!,
                                                    )
                                                    .whenComplete(() => Get.back());

                                                sta(() {
                                                  isload = false;
                                                });
                                                if (s.isNotEmpty &&
                                                    s["appid"] != null &&
                                                    s['orderid'] != null &&
                                                    mngctrl.getPermit != null &&
                                                    mngctrl.getPermit!.transactionId != null &&
                                                    mngctrl.getPermitPrice != null) {
                                                  mngctrl.setOnlineApplId(s["appid"]);
                                                  gcontroller.initNdpsPayment(
                                                    email: mngctrl.getPermit?.applcntEmail ?? "",
                                                    number: mngctrl.getPermit?.applcntMobile ?? "",
                                                    transId: mngctrl.getPermit!.transactionId!,
                                                    context: context,
                                                    amount: mngctrl.getPermitPrice!.fee.toString(),
                                                    address:
                                                        mngctrl.getPermit?.applcntAddress ?? 'NA',
                                                    name: mngctrl.getPermit?.applcntName ?? 'NA',
                                                    clientcodeok: s['orderid'],
                                                  );
                                                } else {
                                                  Get.back();
                                                  String? message = s['message'];

                                                  Get.dialog(
                                                      barrierDismissible: false,
                                                      _errorDialog(pagectrl, imgcon,
                                                          message: message));
                                                }
                                              }),
                                        ],
                                ).animate().scaleXY(begin: 0.5, end: 1).fadeIn();
                              });
                            });
                      })
                ],
              ),
            );
          });
        });
      });
    });
  }

  AlertDialog _errorDialog(PagenavControllers pagectrl, Imagecontroller imgcon, {String? message}) {
    return AlertDialog(
      title: Text(
        "Failed to generate Permit.",
        style: TextStyle(fontSize: 24),
      ),
      content: message != null
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(message, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("There are some technical issues at our end.",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text("Some reasons maybe: ", style: TextStyle(fontSize: 16)),
                SizedBox(
                  height: 16,
                ),
                Text("The photo provided may be unclear. Please retry again",
                    style: TextStyle(fontSize: 16)),
                SizedBox(
                  height: 8,
                ),
                Text("The server failed to load during the permit generation process.",
                    style: TextStyle(fontSize: 16)),
                SizedBox(
                  height: 8,
                ),
                Text("The server maybe down.", style: TextStyle(fontSize: 16)),
                SizedBox(
                  height: 8,
                ),
                Text("The internet connection is slow", style: TextStyle(fontSize: 16)),
                SizedBox(
                  height: 8,
                ),
                Text("There is no network coverage.", style: TextStyle(fontSize: 16)),
                SizedBox(
                  height: 16,
                ),
                Divider(),
                Text("For any issues and queries please go to the ILP COUNTER.",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ],
            ),
      actions: [
        ButtonCard(
            padding: EdgeInsets.zero,
            title: "Try again",
            onpress: () {
              pagectrl.setmainpageindex(ind: 0);
              imgcon.disposeAll();
              Get.back();
              // Get.off(()=>LandingPage());
              pagectrl.listenPageChange();
            })
      ],
    );
  }
}

class TextSubtitle extends StatelessWidget {
  const TextSubtitle({
    super.key,
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }
}

class TextLabel extends StatelessWidget {
  const TextLabel({
    super.key,
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: 16),
    );
  }
}
