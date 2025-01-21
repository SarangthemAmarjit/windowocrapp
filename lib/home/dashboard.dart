import 'package:camera_windows_example/controller/imagecapture.dart';
import 'package:camera_windows_example/homepage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

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
    return Scaffold(
      body: GetBuilder<Imagecontroller>(builder: (_) {
        return Container(
          height: screenHeight,
          width: screenWidth,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bg.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 100),
            child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 10,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        imgcon.navindex == 0
                            ? "SELECT ID CARD TYPE"
                            : "CAPTURE YOUR ID CARD",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Container(
                        width: 40,
                        height: 4,
                        color: Colors.green,
                      ),
                      imgcon.navindex == 1
                          ? SizedBox()
                          : const SizedBox(height: 40),
                      Expanded(
                        child: imgcon.navindex == 1
                            ? IdSelectionAndScanningScreen()
                            : Row(
                                children: idCards
                                    .map((card) => Expanded(
                                          child: _buildOption(
                                              card["label"], card["icon"]),
                                        ))
                                    .toList(),
                              ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          imgcon.navindex > 0
                              ? InkWell(
                                  // overlayColor:
                                  //     WidgetStateProperty.all(Colors.transparent),
                                  focusColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  onTap: imgcon.navindex > 0
                                      ? () {
                                          imgcon.setnavindex(
                                              navin: imgcon.navindex - 1);
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
                              imgcon.setnavindex(navin: imgcon.navindex + 1);
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
        );
      }),
    );
  }

  Widget _buildOption(String label, IconData icon) {
    final isSelected = selectedCard == label;
    return InkWell(
      overlayColor: WidgetStateProperty.all(Colors.transparent),
      focusColor: Colors.transparent,
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      onTap: () {
        setState(() {
          selectedCard = label;
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
                  color: Colors.black.withOpacity(0.1),
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
                  color: isSelected ? Colors.purple : Colors.black54,
                ),
                const SizedBox(height: 10),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.righteous(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? Colors.purple : Colors.black54,
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
