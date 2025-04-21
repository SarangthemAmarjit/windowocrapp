
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';


class BorderButton extends StatelessWidget {
  const BorderButton({
    super.key, required this.callback, required this.child, this.color,
    
  });
  final Widget child;
  final Color? color;
  final VoidCallback callback;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        callback();
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8,horizontal: 16),
       decoration: BoxDecoration(
         border: Border.all(color:color??Colors.green),
         color: color?.withValues(alpha: 0.2),
         borderRadius: BorderRadius.circular(8)
       ),
        child: child
            .animate()
            .fadeIn()
            .scaleXY(
                begin: 0.5, end: 1, curve: Curves.easeIn),
      ),
    );
  }
}