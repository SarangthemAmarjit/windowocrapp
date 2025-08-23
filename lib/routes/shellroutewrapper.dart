import 'package:flutter/material.dart';

class Shellroutewrapper extends StatelessWidget {
  const Shellroutewrapper({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
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
  }
}
