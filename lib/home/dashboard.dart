import 'package:camera_windows_example/controller/imagecapture.dart';
import 'package:camera_windows_example/controller/pagecontroller.dart';
import 'package:camera_windows_example/home/registration.dart';
import 'package:camera_windows_example/homepage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectIdCardTypeScreen extends StatefulWidget {
  const SelectIdCardTypeScreen({super.key});

  @override
  State<SelectIdCardTypeScreen> createState() => _SelectIdCardTypeScreenState();
}

class _SelectIdCardTypeScreenState extends State<SelectIdCardTypeScreen> {
  final List<Map<String, dynamic>> idCards = [
    {"label": "Aadhar Card", "icon": Icons.credit_card},
    {"label": "PAN Card", "icon": Icons.account_balance_wallet},
    {"label": "Voter Card", "icon": Icons.how_to_vote},
    {"label": "Driving License", "icon": Icons.directions_car},
  ];

  String selectedCard = "Aadhar Card"; // Default selection

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    Imagecontroller imgcon = Get.put(Imagecontroller());
    return GetBuilder<PageControllers>(
      builder: (pagectrl) {
        return Scaffold(
          body: GetBuilder<Imagecontroller>(builder: (_) {
            return SingleChildScrollView(
              child: Container(
                height:screenHeight,
                width: screenWidth,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/bg.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 1200,maxHeight: 1400),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      child: Card(
                      
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 10,
                        child: AnimatedContainer(
                        height:pagectrl.regPage==2?800 : 600,
                          padding:  const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
                          decoration: BoxDecoration(
                            // border: Border.all(),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          duration: Duration(milliseconds: 600),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // const SizedBox(height: 20),
                              pagectrl.regPage==2?SizedBox(): Text(
                                pagectrl.regPage == 0
                                    ? "SELECT ID CARD TYPE"
                                    : "CAPTURE YOUR ID CARD",
                                style: TextStyle(
                                  fontSize: 30,
                                  // fontWeight: FontWeight.bold,
                                  // color: Colors.black87,
                                ),
                              ),
                          pagectrl.regPage==2?SizedBox():  const SizedBox(height: 5),
                             pagectrl.regPage==2?SizedBox():   Container(
                                width: 40,
                                height: 4,
                                color: Colors.green,
                              ),
                              pagectrl.regPage==0
                                  ? SizedBox(height: 40,)
                                  : const SizedBox(),
                              Expanded(
                                child:  pagectrl.regPage==1
                                    ? IdSelectionAndScanningScreen()
                                    :  pagectrl.regPage==2?RegistrationPage():Row(
                                        children: idCards
                                            .map((card) => Expanded(
                                                  child: _buildOption(
                                                      card["label"], card["icon"],(){
                                                        pagectrl.changeDashboardPage(pagectrl.regPage+1);
                                                        pagectrl.selectCard(card["label"]);
                                                      },pagectrl),
                                                ))
                                            .toList(),
                                      ),
                              ),
                           pagectrl.regPage==2?SizedBox():Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  pagectrl.regPage > 0
                                      ? InkWell(
                                          // overlayColor:
                                          //     WidgetStateProperty.all(Colors.transparent),
                                          focusColor: Colors.transparent,
                                          splashColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          onTap:pagectrl.regPage  > 0
                                              ? () {
                                                    pagectrl.changeDashboardPage(pagectrl.regPage-1);
                                                }
                                              : null,
                                          child: Transform.flip(
                                            flipX: true,
                                            child: Image.asset(
                                              'assets/images/next2.png',
                                              height: 60,
                                            ),
                                          ),
                                        )
                                      : SizedBox(),
                                  // ElevatedButton(
                                  //     onPressed: () {},
                                  //     style: ElevatedButton.styleFrom(
                                  //       backgroundColor: Colors.grey.shade300,
                                  //     ),
                                  //     child: Padding(
                                  //       padding: const EdgeInsets.all(8.0),
                                  //       child: Text(
                                  //         'Back',
                                  //         style: TextStyle(fontSize: 18),
                                  //       ),
                                  //     )),
                                  InkWell(
                                    // overlayColor:
                                    //     WidgetStateProperty.all(Colors.transparent),
                                    focusColor: Colors.transparent,
                                    splashColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    onTap: () {
                                      pagectrl.changeDashboardPage(pagectrl.regPage+1);
                                    },
                                    child: Image.asset(
                                      'assets/images/next2.png',
                                      height: 60,
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        );
      }
    );
  }

  Widget _buildOption(String label, IconData icon,Function onpress,PageControllers pagectrl) {
    final isSelected = pagectrl.cardtype == label;
    return InkWell(
      overlayColor: WidgetStateProperty.all(Colors.transparent),
      focusColor: Colors.transparent,
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      onTap: () {
        setState(() {
          selectedCard = label;
          onpress();
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 50),
        child: Card(
          elevation: 10,
          child: Container(
            decoration: BoxDecoration(
              color: isSelected ? Colors.green.shade50 : Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha:0.1),
                  blurRadius: 10,
                ),
              ],
              border: isSelected
                  ? Border.all(color: Colors.green, width: 2)
                  : Border.all(color: Colors.transparent),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 40,
                  color: isSelected ? Colors.green : Colors.black54,
                ),
                const SizedBox(height: 10),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    // fontWeight: FontWeight.w600,
                    color: isSelected ? Colors.green : Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}