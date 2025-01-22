import 'package:flutter/material.dart';
import 'package:form_validation/form_validation.dart';

class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget(
      {super.key,
      required this.hint,
      required this.controller,
      this.fieldsubmitted,
      this.focusnode,
      this.nextfocusnode,
      this.validator,
      this.icon,
      this.interactivetext,
      this.obscure = false,
      this.autovalidateMode = AutovalidateMode.onUserInteraction,
      this.enabletext = true,
      this.onchanged,
      this.counter,
      this.showhint = true,
      this.textalign,
      this.isfromlogin});
  final String hint;
  final Icon? icon;
  final bool obscure;
  final bool? isfromlogin;
  // final Function? validator;
  final Function(String)? onchanged;
  final TextEditingController controller;
  final FocusNode? focusnode;
  final FocusNode? nextfocusnode;
  final Function? fieldsubmitted;
  final bool? interactivetext;
  final AutovalidateMode autovalidateMode;
  final bool enabletext;
  final int? counter;
  final bool showhint;
  final TextAlign? textalign;
  final ValueValidator? validator;
  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  bool toggless = false;
  @override
  void initState() {
    super.initState();
    toggless = widget.obscure;
  }

  void toggle() {
    setState(() {
      toggless = !toggless;
    });
  }

  @override
  Widget build(BuildContext context) {
      return 
      
      Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.showhint
                ? Text(
                    widget.hint,
                    style: TextStyle(
                      
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                        ),
                  )
                : const SizedBox(),
            SizedBox(
              height: widget.showhint ? 6 : 0,
            ),
            SizedBox(
              height: 70,
              child: TextFormField(
                
                textAlign: widget.textalign ?? TextAlign.start,
                cursorColor: Colors.white,
                cursorHeight: 20,
      
                controller: widget.controller,
                focusNode: widget.focusnode,
                onFieldSubmitted: (value) {
                  if (widget.nextfocusnode != null) {
                    widget.nextfocusnode!.requestFocus();
                  }
                  if (widget.fieldsubmitted != null) {
                    widget.fieldsubmitted!();
                  }
                },
                validator: 
                // widget.isfromlogin != null? 
                    (v) {
                        if (widget.validator == null) {
                          if (widget.controller.text.trim().isEmpty) {
                            return '${widget.hint} is  empty';
                          }
                        } else {

                   final validator = Validator(
                      validators: [ widget.validator!],
                    );

                    return validator.validate(
                      label: widget.hint,
                      value: v,
                    );

                          // if (widget.controller.text.length >
                          //     (widget.counter ?? 50)) {
                          //   return "Should be between 1 to ${widget.counter ?? 50} characters. Exceeds limits";
                          // } else {
                          //   return widget.validator!();
                          // }
                        }
                        return null;
                      },
                    // : widget.hint == "Password"
                    //     ? addmem.validatePassword
                    //     : (v) {
                    //         if (widget.validator == null) {
                    //           if (widget.controller.text.trim().isEmpty) {
                    //             return '${widget.hint} is  empty';
                    //           }
                    //         } else {
                    //           if (widget.controller.text.length >
                    //               (widget.counter ?? 50)) {
                    //             return "Should be between 1 to ${widget.counter ?? 50} characters. Exceeds limits";
                    //           } else {
                    //             return widget.validator!();
                    //           }
                    //         }
                    //         return null;
                    //       },
                    style: TextStyle(fontSize: 18),
                maxLength: widget.counter ?? 50,
                enabled: widget.enabletext,
                enableInteractiveSelection: widget.interactivetext,
                autovalidateMode: widget.autovalidateMode,
                obscureText: toggless,
                onChanged: widget.onchanged,
                decoration: InputDecoration( 
                    counter: const Offstage(),
                
                    suffixIcon: widget.obscure
                        ? IconButton(
                            onPressed: () {
                              toggle();
                            },
                            icon: Icon(
                                toggless ? Icons.visibility_off : Icons.visibility))
                        : null,
                    filled: false,
                    focusColor: Theme.of(context).colorScheme.secondary,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1.5,
                          color: Colors.green),
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                    ),
                    errorStyle: TextStyle(color: Colors.redAccent.withValues(alpha: 0.8)),
                    focusedErrorBorder:  OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.redAccent.withValues(alpha: 0.8)),
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                    ),
                    prefixIcon: widget.icon,
                    fillColor: Theme.of(context).colorScheme.primary,
                    hintText: widget.hint,
                    hintStyle: TextStyle(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withValues(alpha:0.4)),
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)))),
              ),
            ),
          ],
        );
      
  }
}
