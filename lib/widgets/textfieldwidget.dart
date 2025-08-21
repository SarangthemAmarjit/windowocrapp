import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_utils/get_utils.dart';

class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget(
      {super.key,
      this.padding,
      required this.controller,
      required this.label,
      this.validator,
      this.counter,
      this.focusnode,
      this.fontSize,
      this.contentpadding,
      this.mandatory = true,
      this.keytype,
      this.errorSize,
      this.isCapitalise = true,
      this.enable = true,
      this.readonly = true});
  final double? fontSize;
  final FocusNode? focusnode;
  final EdgeInsets? padding;
  final EdgeInsets? contentpadding;
  final TextEditingController controller;
  final String label;
  final String? Function(String?)? validator;
  final int? counter;
  final bool mandatory;
  final TextInputType? keytype;
  final double? errorSize;
  final bool? isCapitalise;
  final bool? enable;
  final bool? readonly;

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ?? const EdgeInsets.symmetric(vertical: 15),
      child: TextFormField(
        style: TextStyle(
          fontSize: widget.fontSize,
          color: widget.enable == false ? Colors.black : null,
        ),
        focusNode: widget.focusnode,
        maxLength: widget.counter ?? 10,

        controller: widget.controller,
        cursorColor: Colors.black,
        readOnly: true,
        showCursor: true, // Still show the cursor
        enableInteractiveSelection: true,

        buildCounter: (context, {required currentLength, required isFocused, required maxLength}) =>
            SizedBox(),
        decoration: InputDecoration(
          hintStyle: TextStyle(color: Colors.black),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4), borderSide: BorderSide(color: Colors.black)),
          enabled: widget.enable!,
          errorStyle: TextStyle(
            color: Colors.red, // Change error text color
            fontSize: widget.errorSize ?? null,
            // Change font size
            // fontWeight: FontWeight.bold, // Make it bold
          ),
          focusColor: Colors.black,
          contentPadding: widget.contentpadding,
          labelStyle: TextStyle(fontSize: 18, color: Colors.black),
          labelText: widget.mandatory ? "* ${widget.label}" : widget.label,
          floatingLabelStyle: TextStyle(fontSize: 16, color: Colors.black),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
        ),
        inputFormatters: [UpperCaseTextFormatter()],
        validator: widget.validator ??
            (v) {
              if (v!.isEmpty) {
                return "${widget.label} is empty";
              }
              return null;
            },
      ),
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return newValue.copyWith(text: newValue.text.capitalize);
  }
}
