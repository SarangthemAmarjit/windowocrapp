import 'package:flutter/material.dart';

class WelcomescreenWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Figma Flutter Generator WelcomescreenWidget - FRAME
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO(162, 207, 240, 1),
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    child: Column(children: <Widget>[
                  Text(
                    'Welcome to the Inner Line Permit (ILP) System – Manipur',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontFamily: 'Roboto Slab',
                        fontSize: 42,
                        letterSpacing:
                            0 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.normal,
                        height: 1),
                  ),
                  Text(
                    'Manipur welcomes you to experience its rich culture, breathtaking landscapes, and vibrant traditions. To ensure smooth and lawful entry, the Government of Manipur mandates the issuance of an Inner Line Permit (ILP) for visitors. This system is designed to make the process simple, efficient, and user-friendly.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontFamily: 'Poppins',
                        fontSize: 23,
                        letterSpacing:
                            0 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.normal,
                        height: 1.9565217391304348),
                  ),
                  Text(
                    'For any personnel having applied for ILP pass earlier',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color.fromRGBO(31, 31, 31, 1),
                        fontFamily: 'Inter',
                        fontSize: 22,
                        letterSpacing:
                            0 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.normal,
                        height: 1),
                  ),
                  Text(
                    'Let’s get started',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontFamily: 'LEMON MILK',
                        fontSize: 46,
                        letterSpacing:
                            0 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.normal,
                        height: 1),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                      color: Color.fromRGBO(0, 66, 233, 1),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 80, vertical: 40),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          'Apply for New Permit',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color.fromRGBO(235, 224, 224, 1),
                              fontFamily: 'Outfit',
                              fontSize: 38,
                              letterSpacing:
                                  0 /*percentages not used in flutter. defaulting to zero*/,
                              fontWeight: FontWeight.normal,
                              height: 1),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 300,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                      color: Color.fromRGBO(0, 66, 233, 1),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 80, vertical: 40),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          'Existing Permit holder',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color.fromRGBO(235, 224, 224, 1),
                              fontFamily: 'Outfit',
                              fontSize: 38,
                              letterSpacing:
                                  0 /*percentages not used in flutter. defaulting to zero*/,
                              fontWeight: FontWeight.normal,
                              height: 1),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'Use this option to apply for a fresh ILP. Follow a few simple steps to fill in your details, submit necessary documents, and receive your permit instantly.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color.fromRGBO(31, 31, 31, 1),
                        fontFamily: 'Inter',
                        fontSize: 22,
                        letterSpacing:
                            0 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.normal,
                        height: 1),
                  ),
                  Text(
                    'Facilitating Hassle-Free Entry for Visitors',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontFamily: 'Roboto',
                        fontSize: 26,
                        letterSpacing:
                            0 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.normal,
                        height: 1),
                  ),
                  Container(
                      width: 1080,
                      height: 494,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/Untitled21.png'),
                            fit: BoxFit.fitWidth),
                      )),
                  Container(
                      width: 119,
                      height: 119,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                'assets/images/Ilp_logo_transparent1.png'),
                            fit: BoxFit.fitWidth),
                      )),
                  Container(
                      width: 51.587303161621094,
                      height: 65,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image:
                                AssetImage('assets/images/Kanglashanew1.png'),
                            fit: BoxFit.fitWidth),
                      )),
                ])),
              ])),
    );
  }
}
