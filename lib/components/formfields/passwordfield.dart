import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef ValidatorCallback<T> = String? Function(T? value);

class CustomPasswordField extends StatefulWidget {
  CustomPasswordField(
      {Key? key,
      required this.controller,
      required this.focusNode,
      required this.errorMaxLines,
      this.label,
      this.border,
      this.onTapOutside,
      this.validator,
      this.autofillHints,
      required this.defaultValidator,
      this.filled,
      this.hintText,
      this.prefix,
      this.enabledBorder,
      this.fillColor,
        this.enabled = true,
      this.hintStyle})
      : super(key: key);
  int errorMaxLines;
  TextEditingController controller;
  bool enabled = true;
  FocusNode focusNode;
  String? label;
  InputBorder? border;
  void Function(PointerDownEvent event)? onTapOutside;
  ValidatorCallback<String>? validator;
  ValidatorCallback<String>? defaultValidator;
  Iterable<String>? autofillHints;
  bool? filled;
  Color? fillColor;
  InputBorder? enabledBorder;
  TextStyle? hintStyle;
  Widget? prefix;
  String? hintText;

  @override
  _CustomPasswordFieldState createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        controller: widget.controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        autofillHints: widget.autofillHints ?? [AutofillHints.email],
        textCapitalization: TextCapitalization.none,
        style: TextStyle(fontFamily: "Poppins"),
        obscureText: !showPassword,
        inputFormatters: [
          FilteringTextInputFormatter.deny(RegExp(r'\s')),
          //DENY SPECIAL CHARACTERS
          FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9@!%*?&#^*()\$]"))
        ],
        
        focusNode: widget.focusNode,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(8),
          errorMaxLines: 100,
          labelText: widget.label ?? "Password",
          border: widget.border ?? OutlineInputBorder(),
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(), // Set border color to white
          ),
          hintText: widget.hintText,
          prefix: widget.prefix,
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 15,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              showPassword ? Icons.visibility_off : Icons.visibility_rounded,
              color: Color(0xFF211F1F).withOpacity(.48),
            ),
            onPressed: () {
              showPassword = !showPassword;
              setState(() {});
            },
          ),
        ),enabled: widget.enabled,
        onTapOutside: widget.onTapOutside ??
            (tap) {
              if (widget.focusNode.hasFocus) {
                widget.focusNode.unfocus();
              }
            },
        validator: widget.validator ?? widget.defaultValidator,
      ),
    );
  }
}
