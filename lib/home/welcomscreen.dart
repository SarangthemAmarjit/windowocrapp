import 'package:flutter/material.dart';

class ILPSystemScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 162, 207, 240),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset(
                    'assets/images/Kanglashanew1.png',
                    height: 40,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Image.asset(
                    'assets/images/Ilp_logo_transparent1.png',
                    height: 60,
                  )
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
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
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Manipur welcomes you to experience its rich culture, breathtaking landscapes, and vibrant traditions. To ensure smooth and lawful entry, the Government of Manipur mandates the issuance of an Inner Line Permit (ILP) for visitors. This system is designed to make the process simple, efficient, and user-friendly.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 24),
                  Text(
                    'LET’S GET STARTED',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 0, 66, 234),
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 32),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {},
              child: const Text(
                'Apply for New Permit',
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: const Text(
                'Use this option to apply for a fresh ILP. Follow a few simple steps to fill in your details, submit necessary documents, and receive your permit instantly.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: Colors.black),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 0, 66, 234),
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 32),
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
              style: TextStyle(fontSize: 12, color: Colors.black),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  'assets/images/Untitled21.png', // Replace with your image asset
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
