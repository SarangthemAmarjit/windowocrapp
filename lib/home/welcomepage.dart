import 'package:camera_windows_example/cons/tandcpolicy.dart';
import 'package:camera_windows_example/controller/managementcontroller.dart';
import 'package:camera_windows_example/controller/pagecontroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/elevatedbuttoncard.dart';

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
    // Get.find<Managementcontroller>().disposeAll();
    // Get.find<PagenavControllers>().reset();
    // Get.find<Imagecontroller>().disposeAll();
    Get.find<Managementcontroller>().printManagement();
    Get.find<PagenavControllers>().printnavpages();

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
            constraints: BoxConstraints(maxWidth: 700),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 100,
                  ),

                  Text(
                    'Welcome to the',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 44,
                      height: 0.5,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 41, 40, 40),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Inner Line Permit (ILP)\nSystem - Manipur',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.interTight(
                      fontSize: 60,
                      letterSpacing: 1,
                      height: 1,
                      shadows: [
                        Shadow(
                            color: Colors.black.withValues(alpha: 0.3),
                            blurRadius: 2,
                            offset: Offset(2, 3))
                      ],
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 26, 25, 25),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Facilitating Hassle-Free Entry for Visitors',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.grey[900],
                    ),
                  ),
                  SizedBox(height: 40),
                  Text(
                    'Manipur welcomes you to experience its rich culture, breathtaking landscapes, and vibrant traditions.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 24,
                        color: const Color.fromARGB(255, 26, 25, 25),
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    'To ensure smooth and lawful entry, the Government of Manipur mandates the issuance of an Inner Line Permit (ILP) for visitors.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: const Color.fromARGB(255, 26, 25, 25),
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
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 41, 40, 40)),
                  ),

                  SizedBox(height: 20),
                  // const SizedBox(height: 20),
                  ElevatedButtonCard(
                    callback: () {
                      if (mngctrl.getDocNames.isNotEmpty) {
                        context.go('/home/idverification');
                        //return to front page if not active for 30 seconds
                        pagecon.listenPageChange();
                      }
                      //  else {
                      //   showDialog(
                      //       context: context,
                      //       builder: (c) => Dialog(
                      //           insetPadding: EdgeInsets.zero,
                      //           child: ConstrainedBox(
                      //             constraints: BoxConstraints(maxWidth: 600),
                      //             child: Container(
                      //                 clipBehavior: Clip.antiAlias,
                      //                 decoration:
                      //                     BoxDecoration(borderRadius: BorderRadius.circular(24)),
                      //                 child: Column(
                      //                   crossAxisAlignment: CrossAxisAlignment.start,
                      //                   mainAxisSize: MainAxisSize.min,
                      //                   children: [
                      //                     Stack(
                      //                       children: [
                      //                         Container(
                      //                           child: Image.asset(
                      //                             'assets/images/searching.gif',
                      //                             height: 300,
                      //                             width: double.infinity,
                      //                             fit: BoxFit.cover,
                      //                           ),
                      //                         ),
                      //                         Positioned(
                      //                           top: 0,
                      //                           right: 0,
                      //                           child: Padding(
                      //                             padding: const EdgeInsets.all(16.0),
                      //                             child: IconButton(
                      //                                 onPressed: () {
                      //                                   Navigator.pop(c);
                      //                                 },
                      //                                 icon: Icon(Icons.close)),
                      //                           ),
                      //                         )
                      //                       ],
                      //                     ),
                      //                     SizedBox(
                      //                       height: 20,
                      //                     ),
                      //                     Padding(
                      //                       padding: const EdgeInsets.all(16.0),
                      //                       child: Text(
                      //                         "Fetching documents...\nPlease wait for some time",
                      //                         style: TextStyle(fontSize: 24),
                      //                       ),
                      //                     ),
                      //                     SizedBox(
                      //                       height: 20,
                      //                     ),
                      //                   ],
                      //                 )),
                      //           )));
                      // }
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
                        Text(
                          mngctrl.getDocNames.isNotEmpty
                              ? ' Apply New Permit'
                              : 'Fetching Documents ',
                          style: TextStyle(fontSize: 25, color: Colors.white),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        mngctrl.getDocNames.isEmpty
                            ? SizedBox(
                                height: 30,
                                width: 30,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            : SizedBox.shrink()
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 100.0),
                    child: mngctrl.getDocNames.isNotEmpty
                        ? const Text(
                            'Use this option to apply for a fresh ILP. Follow a few simple steps to fill in your details, submit necessary documents, and receive your permit instantly.',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          )
                        : const Text(
                            'Getting things ready… Please wait while we fetch your documents so you can get started.',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20, color: Colors.black),
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
                                  showDialog(
                                      context: context,
                                      builder: (c) => Dialog(
                                            child: Container(
                                              clipBehavior: Clip.antiAlias,
                                              padding: EdgeInsets.all(32),
                                              height: e.key == 2 ? 300 : 800,
                                              width: 600,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(16),
                                              ),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text(
                                                        "${e.value}",
                                                        style: TextStyle(
                                                            fontSize: 24,
                                                            fontWeight: FontWeight.bold),
                                                      ),
                                                      IconButton(
                                                          onPressed: () {
                                                            Navigator.pop(c);
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
                                    fontSize: 20,
                                    // fontWeight: FontWeight.bold,
                                    color: Theme.of(context).colorScheme.secondary,
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
