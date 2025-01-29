import 'package:camera_windows_example/controller/pagecontroller.dart';
import 'package:camera_windows_example/home/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({
    super.key,
  });

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
          const SizedBox(height: 100),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 0, 66, 234),
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {},
            child: const Text(
              'Existing Permit holder',
              style: TextStyle(fontSize: 25, color: Colors.white),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'For any personnel having applied for ILP pass earlier',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 22, color: Colors.black),
          ),
          const SizedBox(height: 30),
        ],
      );
    });
  }
}
