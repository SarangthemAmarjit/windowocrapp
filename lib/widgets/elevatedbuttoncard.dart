import 'package:flutter/material.dart';

class ElevatedButtonCard extends StatelessWidget {
  const ElevatedButtonCard({
    super.key,
    required this.callback,
    required this.child,
  });
  final VoidCallback callback;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: Container(
          padding: EdgeInsets.symmetric(vertical: 32, horizontal: 64),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: LinearGradient(colors: [
                const Color.fromARGB(255, 0, 66, 234),
                const Color.fromARGB(255, 44, 95, 224),
                const Color.fromARGB(255, 6, 50, 160),
              ]),
              boxShadow: [
                BoxShadow(
                    color: const Color.fromARGB(100, 197, 210, 236),
                    blurRadius: 4,
                    spreadRadius: 2,
                    offset: Offset(0, -2)),
                BoxShadow(
                    color: Color.fromARGB(100, 4, 30, 95),
                    blurRadius: 6,
                    spreadRadius: 1,
                    offset: Offset(2, 4))
              ],
              color: const Color.fromARGB(255, 0, 66, 234)),
          child: child),
    );
  }
}
