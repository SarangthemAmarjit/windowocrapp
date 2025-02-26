import 'package:camera_windows_example/controller/pagecontroller.dart';
import 'package:camera_windows_example/home/dashboard.dart';
import 'package:camera_windows_example/home/registrationpages/ilpformreplica.dart';
import 'package:camera_windows_example/home/registrationpages/paymentdetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class WelcomeScreen extends StatefulWidget {
  WelcomeScreen({
    super.key,
  });

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  TextEditingController mobilecon = TextEditingController();

  // final String videoUrl =
  //     'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4';
  // VideoPlayerController? controller;

  @override
  void initState() {
    super.initState();
    // controller = VideoPlayerController.networkUrl(Uri.parse(videoUrl))
    //   ..initialize().then((_) {
    //     setState(() {});
    //     controller!.play();
    //     controller!.setLooping(true);
    //   });
  }

  @override
  void dispose() {
    // controller!.dispose();
    super.dispose();
  }

  // Replace with actual video URL
  @override
  Widget build(BuildContext context) {
    PagenavControllers pagecon = Get.put(PagenavControllers());
    return GetBuilder<PagenavControllers>(builder: (_) {
      return Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 70.0),
            child: Column(
              children: [
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
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 40),
                Text(
                  'Manipur welcomes you to experience its rich culture, breathtaking landscapes, and vibrant traditions. To ensure smooth and lawful entry, the Government of Manipur mandates the issuance of an Inner Line Permit (ILP) for visitors. This system is designed to make the process simple, efficient, and user-friendly.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 40),
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
              ],
            ),
          ),
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
              pagecon.setmainpageindex(ind: 1);

              //return to front page if not active for 30 seconds
              pagecon.listenPageChange();
            },
            child: const Text(
              'Apply for New Permit',
              style: TextStyle(fontSize: 25, color: Colors.white),
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

          const SizedBox(height: 30),
          // const Divider(thickness: 2),
          // const SizedBox(height: 20),
          // const Text(
          //   '🎥 Watch Our Quick Tutorial!',
          //   textAlign: TextAlign.center,
          //   style: TextStyle(
          //     fontSize: 32,
          //     fontWeight: FontWeight.bold,
          //     color: Colors.black,
          //   ),
          // ),
          // const SizedBox(height: 10),
          // const Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 70.0),
          //   child: Text(
          //     'Need help using the ILP System? Watch our step-by-step video guide to learn how to apply for your Inner Line Permit with ease.',
          //     textAlign: TextAlign.center,
          //     style: TextStyle(fontSize: 22, color: Colors.black),
          //   ),
          // ),
          // const SizedBox(height: 20),
          // SizedBox(
          //   height: 300,
          //   child: controller!.value.isInitialized
          //       ? AspectRatio(
          //           aspectRatio: controller!.value.aspectRatio,
          //           child: ClipRRect(
          //               borderRadius: BorderRadius.circular(10),
          //               child: VideoPlayer(controller!)),
          //         )
          //       : const Center(child: CircularProgressIndicator()),
          // ),
          // ElevatedButton(
          //   style: ElevatedButton.styleFrom(
          //     backgroundColor: Colors.red,
          //     padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(8),
          //     ),
          //   ),
          //   onPressed: () {
          //     showDialog(
          //       context: context,
          //       builder: (context) => AlertDialog(
          //         title: const Text('Tutorial Video'),
          //         content:
          //         actions: [
          //           TextButton(
          //             onPressed: () => Navigator.pop(context),
          //             child: const Text('Close'),
          //           ),
          //         ],
          //       ),
          //     );
          //   },
          //   child: const Text(
          //     '▶ Watch Tutorial Video',
          //     style: TextStyle(fontSize: 25, color: Colors.white),
          //   ),
          // ),
          const SizedBox(height: 30),
          // const SizedBox(height: 100),
          // ElevatedButton(
          //   style: ElevatedButton.styleFrom(
          //     backgroundColor: const Color.fromARGB(255, 0, 66, 234),
          //     padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 50),
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(8),
          //     ),
          //   ),
          //   onPressed: () {
          //     showDialog(
          //         context: context,
          //         builder: (c) {
          //           return Padding(
          //             padding: const EdgeInsets.symmetric(horizontal: 150),
          //             child: AlertDialog(
          //               insetPadding: EdgeInsets.all(50),
          //               content: Row(
          //                 mainAxisAlignment: MainAxisAlignment.end,
          //                 children: [
          //                   IconButton(
          //                       onPressed: () {
          //                         Get.back();
          //                       },
          //                       icon: Icon(Icons.close)),
          //                 ],
          //               ),
          //               actions: [
          //                 SizedBox(
          //                   height: 30,
          //                 ),
          //                 Center(
          //                   child: Text(
          //                     "Enter Your Registered Mobile Number",
          //                     textAlign: TextAlign.center,
          //                     style:
          //                         TextStyle(color: Colors.blue, fontSize: 35),
          //                   ),
          //                 ),
          //                 SizedBox(
          //                   height: 20,
          //                 ),
          //                 Padding(
          //                   padding: const EdgeInsets.symmetric(vertical: 15),
          //                   child: TextFormField(
          //                     style: TextStyle(fontSize: 22),
          //                     controller: mobilecon,
          //                     decoration: InputDecoration(
          //                       labelStyle: TextStyle(fontSize: 25),
          //                       labelText: 'Mobile Number',
          //                       floatingLabelStyle: TextStyle(fontSize: 20),
          //                       border: OutlineInputBorder(
          //                         borderRadius: BorderRadius.circular(4),
          //                       ),
          //                       contentPadding: EdgeInsets.symmetric(
          //                           vertical: 25,
          //                           horizontal: 12), // Increases height
          //                     ),
          //                     validator: (v) {
          //                       if (v == null || v.isEmpty) {
          //                         return "Mobile Number is empty";
          //                       }
          //                       return null;
          //                     },
          //                   ),
          //                 ),
          //                 SizedBox(
          //                   height: 20,
          //                 ),
          //                 InkWell(
          //                   onTap: () {},
          //                   child: Container(
          //                     padding: EdgeInsets.all(20),
          //                     decoration: BoxDecoration(
          //                         color: Colors.green,
          //                         borderRadius: BorderRadius.circular(8)),
          //                     clipBehavior: Clip.antiAlias,
          //                     child: Row(
          //                       mainAxisAlignment: MainAxisAlignment.center,
          //                       children: [
          //                         Icon(
          //                           Icons.navigate_next_outlined,
          //                           size: 30,
          //                         ),
          //                         Text(
          //                           'Proceed',
          //                           style: TextStyle(
          //                               color: Colors.white, fontSize: 26),
          //                         ),
          //                       ],
          //                     ),
          //                   ),
          //                 ),
          //               ],
          //             ).animate().scaleXY(begin: 0.5, end: 1).fadeIn(),
          //           );
          //         });
          //   },
          //   child: const Text(
          //     'Existing Permit holder',
          //     style: TextStyle(fontSize: 25, color: Colors.white),
          //   ),
          // ),
          // const SizedBox(height: 10),
          // const Text(
          //   'For any personnel having applied for ILP pass earlier',
          //   textAlign: TextAlign.center,
          //   style: TextStyle(fontSize: 22, color: Colors.black),
          // ),
          const SizedBox(height: 30),
        ],
      ).animate().fadeIn(curve: Curves.easeIn);
    });
  }
}
