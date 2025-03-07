import 'package:flutter/material.dart';

class CustomKeyboard extends StatefulWidget {
  final Function(String) onKeyTap;
  final VoidCallback onBackspace;
  final VoidCallback onToggle;
  final bool isAlpha;

  CustomKeyboard({
    required this.onKeyTap,
    required this.onBackspace,
    required this.onToggle, 
    this.isAlpha = true,
  });

  @override
  _CustomKeyboardState createState() => _CustomKeyboardState();
}

class _CustomKeyboardState extends State<CustomKeyboard> {

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.symmetric(vertical: 16),
      // padding: EdgeInsets.all(8),
     decoration: BoxDecoration(
      color: Colors.grey[200],
      boxShadow: [
        BoxShadow(
          color: Colors.grey[700]!,
          spreadRadius: 1,
          blurRadius: 2,
          blurStyle: BlurStyle.solid
        )
      ],
      borderRadius: BorderRadius.circular(8)
     ),
      child: Column(
        children: [
          if (widget.isAlpha) ...[
            Row(
              children: [
                Expanded(child: _buildKeyRow(['1', '2', '3', '4', '5', '6', '7', '8', '9', '0'])),
                SizedBox(
                  width: 120,
                  child: _buildSpecialButton('⌫', widget.onBackspace)),
              ],
            ),
            _buildKeyRow(['q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p']),
            _buildKeyRow(['a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l','/']),
            _buildKeyRow(['z', 'x', 'c', 'v', 'b', 'n', 'm','.']),
            Row(
              children: [
                Expanded(child: _buildKeyRow(['@','-', '_'])),
                SizedBox(
                          width:300,
                  child: _buildSpecialButton('SPACE', () => widget.onKeyTap(' '))),
                Expanded(child: _buildKeyRow(['\\','\$'])),
              ],
            ),
          ] else ...[
            _buildKeyRow(['1', '2', '3']),
            _buildKeyRow(['4', '5', '6']),
            _buildKeyRow(['7', '8', '9']),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: _buildKeyRow(['0'])),
                Expanded(
              
                  child: _buildSpecialButton('⌫', widget.onBackspace)),
              ],
            ),
          ],
          // _buildBottomRow(),
        ],
      ),
    );
  }

  Widget _buildKeyRow(List<String> keys) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: keys.map((key) => Expanded(child: _buildKeyButton(key))).toList(),
    );
  }

  Widget _buildKeyButton(String key) {
    return KeyboardKey(widget: widget,keys: key,);
  }

  Widget _buildBottomRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildSpecialButton('@', () => widget.onKeyTap('@')),
   
        _buildSpecialButton(widget.isAlpha ? '123' : 'ABC', widget.onToggle),
        _buildSpecialButton('⌫', widget.onBackspace),
      ],
    );
  }

  Widget _buildSpecialButton(String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
           height: 70,
        alignment: Alignment.center,
        // margin: EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.blue[300],
          // borderRadius: BorderRadius.circular(8),
          boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 2)],
        ),
        child: Text(
          label,
          style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class KeyboardKey extends StatefulWidget {
  const KeyboardKey({
    super.key,
    required this.widget, required this.keys,
    
  });
  final String keys;
  final CustomKeyboard widget;

  @override
  State<KeyboardKey> createState() => _KeyboardKeyState();
}

class _KeyboardKeyState extends State<KeyboardKey> {

  bool hov = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState((){
          hov = true;
        });
        Future.delayed(Duration(milliseconds: 300)).then((v){
            setState(() {
              hov = false;
            });
        });
        widget.widget.onKeyTap(widget.keys);},
      child: AnimatedContainer(
        width: 80,
        height: 70,
        // margin: EdgeInsets.all(4),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color:hov?const Color.fromARGB(255, 137, 195, 243):Colors.white,
          // borderRadius: BorderRadius.circular(8),
          boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 2)],
        ),
        duration: Duration(milliseconds: 400),
        curve: Curves.easeIn,
        child: Text(
          widget.keys,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: hov?Colors.white:null),
        ),
      ),
    );
  }
}
