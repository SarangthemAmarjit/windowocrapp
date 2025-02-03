import 'package:camera_windows_example/cons/constant.dart';
import 'package:camera_windows_example/controller/managementcontroller.dart';
import 'package:camera_windows_example/controller/pagecontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DocumentScanPage extends StatelessWidget {
  const DocumentScanPage({super.key});

  @override
  Widget build(BuildContext context) {
    PagenavControllers pagecon = Get.put(PagenavControllers());

    return GetBuilder<PagenavControllers>(builder: (_) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                'Document Type Selection for Scanning',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Choose the type of ID document you want to scan for verification.',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 100),
              GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 50,
                  mainAxisSpacing: 100,
                  childAspectRatio: 3.8,
                ),
                itemCount: documentTypes.length,
                itemBuilder: (context, index) {
                  return _buildButton(context, documentTypes[index]);
                },
              ),
              const SizedBox(height: 100),
              const Text(
                'Place the selected document on the scanning pad, ensuring it is clear and fully visible for a successful scan.',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 100),
              ElevatedButton(
                onPressed: () {
                  pagecon.setmainpageindex(ind: 0);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 0, 183, 234),
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Back', style: TextStyle(fontSize: 20)),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildButton(BuildContext context, String text) {
    PagenavControllers pagecon = Get.put(PagenavControllers());
    Managementcontroller mngctrl = Get.find<Managementcontroller>();
    return ElevatedButton(
      onPressed: () {
        pagecon.setmainpageindex(ind: 2);
        mngctrl.getIdCard(text);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 0, 66, 234),
        foregroundColor: Colors.white,
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 25),
      ),
    );
  }
}
