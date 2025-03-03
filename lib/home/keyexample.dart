import 'package:flutter/material.dart';
import '../widgets/customkeys.dart';

class KeyboardExample extends StatefulWidget {
  @override
  _KeyboardExampleState createState() => _KeyboardExampleState();
}

class _KeyboardExampleState extends State<KeyboardExample> {
  final Map<String, TextEditingController> controllers = {
    'field1': TextEditingController(),
    'field2': TextEditingController(),
    'field3': TextEditingController(),
  };

  final Map<String, FocusNode> focusNodes = {
    'field1': FocusNode(),
    'field2': FocusNode(),
    'field3': FocusNode(),
  };

  String? activeField; // Track which field is active

  @override
  void initState() {
    super.initState();
    // Attach focus listeners
    focusNodes.forEach((key, node) {
      node.addListener(() {
        if (node.hasFocus) {
          setState(() {
            activeField = key;
          });
        }
      });
    });
  }

  void _onKeyTap(String key) {
    if (activeField != null) {
      controllers[activeField]!.text += key;
    }
  }

  void _onBackspace() {
    if (activeField != null) {
      final controller = controllers[activeField]!;
      if (controller.text.isNotEmpty) {
        controller.text = controller.text.substring(0, controller.text.length - 1);
      }
    }
  }

  void _toggleKeyboard() {
    setState(() {}); // Just rebuild to update UI
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Multi-Field Keyboard Example')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildTextField('field1', 'Enter first value'),
          _buildTextField('field2', 'Enter second value'),
          _buildTextField('field3', 'Enter third value'),
          SizedBox(height: 20),
          CustomKeyboard(
            onKeyTap: _onKeyTap,
            onBackspace: _onBackspace,
            onToggle: _toggleKeyboard,
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String fieldKey, String hint) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextField(
        controller: controllers[fieldKey],
        focusNode: focusNodes[fieldKey],
        readOnly: true, // Disable system keyboard
        decoration: InputDecoration(
          hintText: hint,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
