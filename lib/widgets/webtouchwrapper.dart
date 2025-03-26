import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class WebviewTouchWrapper extends StatelessWidget {
  const WebviewTouchWrapper({required this.child, Key? key}) : super(key: key);

  final Widget child;
  static Offset oldPosition = Offset.zero;

  void simulatePress(TapUpDetails details) {
    const kind = PointerDeviceKind.touch;
    final currentPosition = details.globalPosition;
    if ((details.kind == kind) && (oldPosition != currentPosition)) {
      oldPosition = currentPosition;
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        try {
          await Future.delayed(Duration(milliseconds: 36));
          final tOffset = details.globalPosition;
          GestureBinding.instance.handlePointerEvent(PointerMoveEvent(
            position: tOffset,
            kind: kind,
            size: 70,
          ));
          await Future.delayed(Duration(milliseconds: 36));
          GestureBinding.instance.handlePointerEvent(PointerDownEvent(
            position: tOffset,
            kind: kind,
            size: 70,
          ));
          await Future.delayed(Duration(milliseconds: 36));
          GestureBinding.instance.handlePointerEvent(PointerUpEvent(
            position: tOffset,
            kind: kind,
            size: 70,
          ));
        } catch (e, s) {
          print(e);
          print(s);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTapUp: simulatePress,
        child: child,
      );
}
