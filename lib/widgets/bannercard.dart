import 'package:flutter/material.dart';

class BannerContainer extends StatelessWidget {
  const BannerContainer({
    super.key, required this.text, required this.color, this.padding,this.margin,
  });
  final String text;
  final Color color;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  @override
  Widget build(BuildContext context) {
    return Container(
     padding:padding?? EdgeInsets.all(32),
     margin:margin?? EdgeInsets.all(16),
     decoration: BoxDecoration(
       borderRadius: BorderRadius.circular(8),
     color: color.withValues(alpha: 0.2),
     ),
     child: Text(text,style: TextStyle(color: color,fontSize: 20),),);
  }
}
