import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

import '../../controller/pagecontroller.dart';

class PhotoSignaturePage extends StatefulWidget {
  const PhotoSignaturePage({super.key});

  @override
  State<PhotoSignaturePage> createState() => _PhotoSignaturePageState();
}

class _PhotoSignaturePageState extends State<PhotoSignaturePage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PagenavControllers>(builder: (controller) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text("Photo & Signature",style: TextStyle(fontSize: 30,color: Colors.green),),
          // Divider(),
          SizedBox(
            height: 10,
          ),

          Row(
            children: [
              Expanded(
                child: Container(
                  height: 300,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey[700]!,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add_a_photo_rounded),
                        SizedBox(
                          height: 16,
                        ),
                        Text("Add a Profile Photo")
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: Container(
                  height: 100,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey[700]!,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.edit_square),
                        SizedBox(
                          height: 16,
                        ),
                        Text("Add Signature")
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              controller.changePage(5);
            },
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Colors.green, borderRadius: BorderRadius.circular(8)),
              clipBehavior: Clip.antiAlias,
              child: Center(
                  child: Text(
                "Register Permit",
                style: TextStyle(color: Colors.white),
              )),
            ),
          ),
        ],
      ).animate().fadeIn(duration: Duration(milliseconds: 500));
    });
  }
}
