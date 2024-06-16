import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldOrder extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String title;
  final int minLines;
  final List<TextInputFormatter>? inputFormatter;
  final TextInputType? textInputType;
  final String? Function(String? value)? validator;
  final int? maxlines;
  const TextFieldOrder  (
      {super.key,
        required this.controller,
        required this.title,
        this.minLines = 1,
        required this.focusNode,this.inputFormatter, this.textInputType, this.validator,this.maxlines});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,autovalidateMode: AutovalidateMode.onUserInteraction,
      maxLines: maxlines,
      minLines: minLines,inputFormatters: inputFormatter,
      keyboardType: textInputType,
      focusNode: focusNode,
      onTapOutside: (tap){
        if(focusNode.hasFocus){
          focusNode.unfocus();
        }
      },
      validator: validator ?? (value) {
        if (value!.isEmpty) {
          return "$title is required";
        }
        return null;
      },
    );
  }
}