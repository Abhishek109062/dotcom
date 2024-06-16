// ignore_for_file: prefer_const_constructors

import 'package:dot_com/components/formfields/passwordfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'formfieldvalidators.dart';

typedef ValidatorCallback<T> = String? Function(String? value);

class CustomFormFields {
  CustomFormFieldValidators defaultValidator = CustomFormFieldValidators();
  int _errorMaxLines = 100;

  Widget textFieldWithoutSpace({
    required TextEditingController controller,
    required FocusNode focusNode,
    String? label,
    InputBorder? border,
    void Function(PointerDownEvent event)? onTapOutside,
    ValidatorCallback<String>? validator,
    Iterable<String>? autofillHints,
    bool? filled,
    Color? fillColor,
    InputBorder? enabledBorder,
    TextStyle? hintStyle,
    Widget? prefix,
    String? hintText,
  }) {
    return TextFormField(
        controller: controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        autofillHints: autofillHints ?? [],
        style: TextStyle(fontFamily: "Poppins"),
        inputFormatters: [
          LengthLimitingTextInputFormatter(30),
          FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
        ],
        focusNode: focusNode,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(8),
          errorMaxLines: _errorMaxLines,
          labelText: label,
          border: border ?? OutlineInputBorder(),
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(), // Set border color to white
          ),
          hintText: hintText,
          prefix: prefix,
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 15,
          ),
        ),
        onTapOutside: onTapOutside ??
            (tap) {
              if (focusNode.hasFocus) {
                focusNode.unfocus();
              }
            },
        validator: validator ?? defaultValidator.isEmptyValidator);
  }

  Widget panCard({
    required TextEditingController controller,
    required FocusNode focusNode,
    String? label,
    InputBorder? border,
    void Function(PointerDownEvent event)? onTapOutside,
    ValidatorCallback<String>? validator,
    Iterable<String>? autofillHints,
    bool? filled,
    Color? fillColor,
    InputBorder? enabledBorder,
    TextStyle? hintStyle,
    Widget? prefix,
    String? hintText,
  }) {
    return TextFormField(
        controller: controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        autofillHints: autofillHints ?? [],
        style: TextStyle(fontFamily: "Poppins"),
        inputFormatters: [
          LengthLimitingTextInputFormatter(10),
          FilteringTextInputFormatter.allow(RegExp("[0-9A-Z]")),
        ],
        focusNode: focusNode,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(8),
          errorMaxLines: _errorMaxLines,
          labelText: label,
          border: border ?? OutlineInputBorder(),
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(), // Set border color to white
          ),
          hintText: hintText,
          prefix: prefix,
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 15,
          ),
        ),
        onTapOutside: onTapOutside ??
            (tap) {
              if (focusNode.hasFocus) {
                focusNode.unfocus();
              }
            },
        validator: validator ?? defaultValidator.panCardValidatorRequired);
  }

  Widget aadharCard({
    required TextEditingController controller,
    required FocusNode focusNode,
    String? label,
    InputBorder? border,
    void Function(PointerDownEvent event)? onTapOutside,
    ValidatorCallback<String>? validator,
    Iterable<String>? autofillHints,
    bool? filled,
    Color? fillColor,
    InputBorder? enabledBorder,
    TextStyle? hintStyle,
    Widget? prefix,
    String? hintText,
  }) {
    return TextFormField(
        controller: controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        autofillHints: autofillHints ?? [],
        style: TextStyle(fontFamily: "Poppins"),
        inputFormatters: [
          LengthLimitingTextInputFormatter(12),
          FilteringTextInputFormatter.allow(RegExp("[0-9]")),
        ],
        focusNode: focusNode,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(8),
          errorMaxLines: _errorMaxLines,
          labelText: label,
          border: border ?? OutlineInputBorder(),
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(), // Set border color to white
          ),
          hintText: hintText,
          prefix: prefix,
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 15,
          ),
        ),
        onTapOutside: onTapOutside ??
            (tap) {
              if (focusNode.hasFocus) {
                focusNode.unfocus();
              }
            },
        validator: validator ?? defaultValidator.aadhaarCardValidatorRequired);
  }

  Widget textFieldWithSpace(
      //ALLOW ONLY SINGLE SPACE
      {
    required TextEditingController controller,
    required FocusNode focusNode,
    String? label,
    InputBorder? border,
    void Function(PointerDownEvent event)? onTapOutside,
    ValidatorCallback<String>? validator,
    Iterable<String>? autofillHints,
    bool? filled,
    Color? fillColor,
    InputBorder? enabledBorder,
    TextStyle? hintStyle,
    Widget? prefix,
    String? hintText,
  }) {
    return TextFormField(
        controller: controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        autofillHints: autofillHints ?? [],
        style: TextStyle(fontFamily: "Poppins"),
        inputFormatters: [
          LengthLimitingTextInputFormatter(30),
          FilteringTextInputFormatter.deny(RegExp("^\\s")),
          FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
          SingleSpaceInputFormatter()
        ],
        focusNode: focusNode,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(8),
          errorMaxLines: _errorMaxLines,
          labelText: label,
          border: border ?? OutlineInputBorder(),
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(), // Set border color to white
          ),
          hintText: hintText,
          prefix: prefix,
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 15,
          ),
        ),
        onTapOutside: onTapOutside ??
            (tap) {
              if (focusNode.hasFocus) {
                focusNode.unfocus();
              }
            },
        validator: validator ?? defaultValidator.none);
  }

  Widget emailField({
    required TextEditingController controller,
    required FocusNode focusNode,
    String? label,
    InputBorder? border,
    void Function(PointerDownEvent event)? onTapOutside,
    ValidatorCallback<String>? validator,
    Iterable<String>? autofillHints,
    String? hintText,
    bool isEnabled = true,
    bool? filled,
    Color? fillColor,
    InputBorder? enabledBorder,
    TextStyle? hintStyle,
    Widget? prefix,
  }) {
    return TextFormField(
      enabled: isEnabled,
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      autofillHints: autofillHints ?? [AutofillHints.email],
      textCapitalization: TextCapitalization.none,
      style: TextStyle(fontFamily: "Poppins"),
      inputFormatters: [
        FilteringTextInputFormatter.deny(RegExp(r'\s')),
      ],
      focusNode: focusNode,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(8),
        errorMaxLines: _errorMaxLines,
        labelText: label,
        border: border ?? OutlineInputBorder(),
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(), // Set border color to white
        ),
        hintText: hintText,
        prefix: prefix,
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: 15,
        ),
      ),
      onTapOutside: onTapOutside ??
          (tap) {
            if (focusNode.hasFocus) {
              focusNode.unfocus();
            }
          },
      validator: validator ?? defaultValidator.emailValidator,
    );
  }

  Widget passwordField({
    required TextEditingController controller,
    required FocusNode focusNode,
    String? label,
    InputBorder? border,
    void Function(PointerDownEvent event)? onTapOutside,
    ValidatorCallback<String>? validator,
    Iterable<String>? autofillHint,
    bool? filled,
    Color? fillColor,
    InputBorder? enabledBorder,
    TextStyle? hintStyle,
    Widget? prefix,
    String? hintText,
    bool enabled = true,
  }) {
    return CustomPasswordField(
      filled: filled,
      fillColor: fillColor,
      enabledBorder: enabledBorder,
      hintStyle: hintStyle,
      prefix: prefix,
      hintText: hintText,
      focusNode: focusNode,
      controller: controller,
      defaultValidator: validator ?? defaultValidator.passwordValidator,
      errorMaxLines: _errorMaxLines,
      label: label,
      enabled: enabled,
    );
  }

  Widget phoneNumberField({
    required TextEditingController controller,
    required FocusNode focusNode,
    String? label,
    String? hintText,
    InputBorder? border,
    void Function(PointerDownEvent event)? onTapOutside,
    required ValidatorCallback<String>? validator,
    Iterable<String>? autofillHints,
    bool? filled,
    Color? fillColor,
    InputBorder? enabledBorder,
    TextStyle? hintStyle,
    Widget? prefix,
  }) {
    return TextFormField(
      textAlignVertical: TextAlignVertical.center,
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      autofillHints: autofillHints ?? [],
      keyboardType: TextInputType.phone,
      style: TextStyle(color: Colors.black, fontSize: 18),
      inputFormatters: [
        LengthLimitingTextInputFormatter(10),
        FilteringTextInputFormatter.digitsOnly,
      ],
      focusNode: focusNode,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(8),
        filled: true,
        fillColor: Colors.white,
        border: const OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(), // Set border color to white
        ),
        labelText: label ?? '',
        hintText: hintText ?? null,
        prefix: Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Text(
            "+91 ",
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ),
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: 15,
        ),
        // floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      onTapOutside: onTapOutside ??
          (tap) {
            if (focusNode.hasFocus) {
              focusNode.unfocus();
            }
          },
      validator: validator,
    );
  }

  Widget dropdownField(
      {required FocusNode focusNode,
      required String label,
      InputBorder? border,
      bool isValidationRequired = true,
      void Function(PointerDownEvent event)? onTapOutside,
      required Set<String>? itemSet,
      required void Function(String?)? onChanged,
      String? initialValue,
      double? menuMaxHeight = 300}) {
    if (itemSet == null || !itemSet.contains(initialValue)) {
      initialValue = null;
    }
    return TapRegion(
        onTapOutside: (tap) {
          if (focusNode.hasFocus) {
            focusNode.unfocus();
          }
        },
        enabled: itemSet == null || itemSet.isEmpty ? false : true,
        child: DropdownButtonFormField<String>(
          menuMaxHeight: menuMaxHeight,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (isValidationRequired) {
              return defaultValidator.dropdownValidator(label, value);
            }
            return null;
          },
          borderRadius: BorderRadius.circular(10),
          focusNode: focusNode,
          value: initialValue,
          items: itemSet != null
              ? itemSet?.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(color: Colors.black),
                    ),
                  );
                }).toList()
              : [],
          onChanged: onChanged,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 17),
            border: OutlineInputBorder(),
            labelText: "$label",
          ),
          itemHeight: kMinInteractiveDimension,
          isExpanded: true,
        ));
  }

  Widget addressField({
    required TextEditingController controller,
    required FocusNode focusNode,
    String? label,
    InputBorder? border,
    void Function(PointerDownEvent event)? onTapOutside,
    ValidatorCallback<String>? validator,
    Iterable<String>? autofillHints,
    int characterLimit = 100,
    bool? filled,
    Color? fillColor,
    InputBorder? enabledBorder,
    TextStyle? hintStyle,
    Widget? prefix,
    String? hintText,
  }) {
    return TextFormField(
        controller: controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        autofillHints: autofillHints ?? [],
        style: TextStyle(fontFamily: "Poppins"),
        inputFormatters: [
          LengthLimitingTextInputFormatter(characterLimit),
          FilteringTextInputFormatter.deny(RegExp("^\\s")),
          SingleSpaceInputFormatter()
        ],
        focusNode: focusNode,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(8),
          errorMaxLines: _errorMaxLines,
          labelText: label,
          border: border ?? OutlineInputBorder(),
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(), // Set border color to white
          ),
          hintText: hintText,
          prefix: prefix,
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 15,
          ),
        ),
        onTapOutside: onTapOutside ??
            (tap) {
              if (focusNode.hasFocus) {
                focusNode.unfocus();
              }
            },
        validator: validator ?? defaultValidator.addressValidator);
  }

  Widget pinCodeField({
    required TextEditingController controller,
    required FocusNode focusNode,
    String? label,
    String? hintText,
    InputBorder? border,
    void Function(PointerDownEvent event)? onTapOutside,
    ValidatorCallback<String>? validator,
    Iterable<String>? autofillHints,
    bool? filled,
    Color? fillColor,
    InputBorder? enabledBorder,
    TextStyle? hintStyle,
    Widget? prefix,
  }) {
    return TextFormField(
      enabled: true,
      controller: controller,
      focusNode: focusNode,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(6),
      ],
      onTapOutside: onTapOutside ??
          (tap) {
            if (focusNode.hasFocus) {
              focusNode.unfocus();
            }
          },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(8),
        errorMaxLines: _errorMaxLines,
        labelText: label,
        border: border ?? OutlineInputBorder(),
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(), // Set border color to white
        ),
        hintText: hintText,
        prefix: prefix,
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: 15,
        ),
      ),
      validator: validator ?? defaultValidator.pinCodeValidator,
    );
  }
}

class SingleSpaceInputFormatter extends TextInputFormatter {
  @override

  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isNotEmpty && newValue.text.startsWith(' ')) {
      return oldValue.copyWith(
        text: newValue.text.trimLeft(),
        selection: TextSelection.collapsed(offset: newValue.text.length),
      );
    }
    String filteredText = newValue.text.replaceAll(RegExp(r'\s+'), ' ');

    int cursorOffset =
        newValue.selection.end - (newValue.text.length - filteredText.length);

    return TextEditingValue(
      text: filteredText,
      selection: TextSelection.collapsed(offset: cursorOffset),
    );
  }
}
