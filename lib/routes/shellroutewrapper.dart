import 'package:camera_windows_example/controller/connectivitycontroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class Shellroutewrapper extends StatelessWidget {
  const Shellroutewrapper({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<Connectivitycontroller>(builder: (netctrl) {
      return Scaffold(
          backgroundColor: const Color.fromARGB(255, 162, 207, 240),
          body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              const Color.fromARGB(255, 68, 143, 197),
              const Color.fromARGB(255, 162, 207, 240),
              const Color.fromARGB(255, 162, 207, 240),
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Obx(
                        () => netctrl.isConnectivity.value
                            ? Expanded(
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 16),
                                  padding: EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                      color: Colors.black.withValues(alpha: 0.7),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.wifi_off_outlined,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        "There is No Network Connection? Please contact ILP Authority. ",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      SizedBox(
                                        width: 16,
                                      ),
                                      if (GoRouterState.of(context).fullPath != '/home/homescreen')
                                        ElevatedButton(
                                            onPressed: () {
                                              context.go('/home/homescreen');
                                            },
                                            child: Text(
                                              "Home",
                                              style: TextStyle(color: Colors.white),
                                            ))
                                    ],
                                  ),
                                ).animate().fadeIn(),
                              )
                            : SizedBox.shrink(),
                      ),
                      Image.asset(
                        'assets/images/kanglashaok.png',
                        height: 60,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Image.asset(
                        'assets/images/ilplogo2.png',
                        height: 60,
                      )
                    ],
                  ),
                ),
                Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                alignment: Alignment.bottomCenter,
                                image: AssetImage(
                                  'assets/images/Untitled21.png',
                                ))),
                        width: MediaQuery.of(context).size.width,
                        child: ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: 1000), child: child))),
              ],
            ),
          ));
    });
  }
}
