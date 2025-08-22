import 'package:flutter/material.dart';

class ButtonCard extends StatelessWidget {
  const ButtonCard({
    super.key,
    required this.title,
    required this.onpress,
    this.padding,
    this.icon,
    this.ver,
    this.conwidth,
  });
  final String title;
  final VoidCallback onpress;
  final EdgeInsets? padding;
  final Widget? icon;
  final double? ver;
  final double? conwidth;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.symmetric(horizontal: 16, vertical: ver ?? 16),
      child: InkWell(
        onTap: onpress,
        child: Container(
          width: conwidth ?? double.infinity,
          padding: EdgeInsets.all(32),
          decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(8)),
          clipBehavior: Clip.antiAlias,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon ?? SizedBox(),
              SizedBox(
                width: icon == null ? 0 : 10,
              ),
              Text(
                title,
                style: TextStyle(color: Colors.white, fontSize: 26),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
