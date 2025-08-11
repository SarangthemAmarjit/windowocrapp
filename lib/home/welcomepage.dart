import 'package:camera_windows_example/cons/tandcpolicy.dart';
import 'package:camera_windows_example/controller/managementcontroller.dart';
import 'package:camera_windows_example/controller/pagecontroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class WelcomeScreen extends StatefulWidget {
  WelcomeScreen({
    super.key,
  });

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).unfocus(); // Hide keyboard when the screen starts
    });
  }

  @override
  void dispose() {
    FocusManager.instance.primaryFocus?.unfocus();
    super.dispose();
  }

  // Replace with actual video URL
  @override
  Widget build(BuildContext context) {
    return GetBuilder<Managementcontroller>(builder: (mngctrl) {
      return GetBuilder<PagenavControllers>(builder: (pagecon) {
        return Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 800),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  Text(
                    'Welcome to the Inner Line Permit (ILP)\nSystem – Manipur',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Facilitating Hassle-Free Entry for Visitors',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.grey[800],
                    ),
                  ),
                  SizedBox(height: 40),
                  Text(
                    'Manipur welcomes you to experience its rich culture, breathtaking landscapes, and vibrant traditions.\nTo ensure smooth and lawful entry, the Government of Manipur mandates the issuance of an Inner Line Permit (ILP) for visitors.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.black,
                    ),
                  ),
                  // Text(
                  //   'This system is designed to make the process simple, efficient, and user-friendly.',
                  //   textAlign: TextAlign.center,
                  //   style: TextStyle(
                  //     fontSize: 22,
                  //     color: Colors.black,
                  //   ),
                  // ),
                  SizedBox(height: 60),
                  Text(
                    'LET’S GET STARTED',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 20),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 0, 66, 234),
                      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      if (mngctrl.getDocNames.isNotEmpty) {
                        pagecon.setmainpageindex(ind: 1);
                        //return to front page if not active for 30 seconds
                        pagecon.listenPageChange();
                      } else {
                        Get.dialog(Dialog(
                            insetPadding: EdgeInsets.zero,
                            child: ConstrainedBox(
                              constraints: BoxConstraints(maxWidth: 600),
                              child: Container(
                                  clipBehavior: Clip.antiAlias,
                                  decoration:
                                      BoxDecoration(borderRadius: BorderRadius.circular(24)),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Stack(
                                        children: [
                                          Container(
                                            child: Image.asset(
                                              'assets/images/searching.gif',
                                              height: 300,
                                              width: double.infinity,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Positioned(
                                            top: 0,
                                            right: 0,
                                            child: Padding(
                                              padding: const EdgeInsets.all(16.0),
                                              child: IconButton(
                                                  onPressed: () {
                                                    Get.back();
                                                  },
                                                  icon: Icon(Icons.close)),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Text(
                                          "Fetching documents...\nPlease wait for some time",
                                          style: TextStyle(fontSize: 24),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  )),
                            )));
                      }
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          height: 30,
                          width: 30,
                          'assets/images/permitsvg.svg',
                          fit: BoxFit.fill,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        const Text(
                          'Apply New Permit',
                          style: TextStyle(fontSize: 25, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 100.0),
                    child: const Text(
                      'Use this option to apply for a fresh ILP. Follow a few simple steps to fill in your details, submit necessary documents, and receive your permit instantly.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 22, color: Colors.black),
                    ),
                  ),
                  const SizedBox(height: 120),
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
                                      clipBehavior: Clip.antiAlias,
                                      padding: EdgeInsets.all(32),
                                      height: e.key == 2 ? 300 : 800,
                                      width: 600,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        // image: DecorationImage(
                                        //     image: AssetImage("assets/images/backgrounds.jpg"),
                                        //     fit: BoxFit.cover)
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "${e.value}",
                                                style: TextStyle(
                                                    fontSize: 24, fontWeight: FontWeight.bold),
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
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.blue,
                                  ),
                                )),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 30),
                ],
              ).animate().fadeIn(curve: Curves.easeIn),
            ),
          ),
        );
      });
    });
  }
}
