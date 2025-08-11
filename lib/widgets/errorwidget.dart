import 'package:camera_windows_example/controller/imagecapture.dart';
import 'package:camera_windows_example/controller/managementcontroller.dart';
import 'package:camera_windows_example/controller/pagecontroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

class ErrorPages extends StatelessWidget {
  const ErrorPages({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Managementcontroller>(builder: (mngctrl) {
      return GetBuilder<Imagecontroller>(builder: (imgcon) {
        return GetBuilder<PagenavControllers>(builder: (pagectrl) {
          return Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 600),
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2), blurRadius: 6, spreadRadius: 2)
                ], borderRadius: BorderRadius.circular(32), color: Colors.white),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                            height: 300,
                            clipBehavior: Clip.antiAlias,
                            decoration:
                                BoxDecoration(
                                    color: Colors.black,
                                    gradient:
                                        LinearGradient(colors: [Colors.grey[700]!, Colors.black])),
                            child: Center(
                              child: Image.asset(
                                'assets/images/nointernet.webp',
                                height: 120,
                                width: 120,
                                fit: BoxFit.contain,
                              ),
                            ))
                        .animate()
                        .fadeIn()
                        .slideY(begin: -0.5, end: 0, duration: Duration(milliseconds: 800)),
                    SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16),
                      child: Text(
                        "Service is Temporarily down\nWe will get back soon.",
                        style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      )
                          .animate()
                          .fadeIn()
                          .slideY(begin: 1, end: 0, delay: Duration(milliseconds: 600)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 8),
                      child: Text(
                        "There is no Network Connection.",
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.center,
                      )
                          .animate()
                          .fadeIn()
                          .slideY(begin: 1, end: 0, delay: Duration(milliseconds: 400)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 8),
                      child: Text(
                        "Check the Network Cables",
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.center,
                      )
                          .animate()
                          .fadeIn()
                          .slideY(begin: 1, end: 0, delay: Duration(milliseconds: 400)),
                    ),
                    SizedBox(
                      height: 60,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
      });
    });
  }
}
