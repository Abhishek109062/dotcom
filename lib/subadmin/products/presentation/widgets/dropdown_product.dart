import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:dot_com/subadmin/theme/subadmin_pallet.dart';
import 'package:flutter/material.dart';
import 'dart:developer';

class DropDownMenuProduct extends StatefulWidget {
  final List<String> list;
  final Function(dynamic) onChange;
  final String initialItem;
  final String hintText;
  final String title;
  const DropDownMenuProduct(
      {Key? key,
      required this.list,
      required this.onChange,
      required this.hintText,
      required this.initialItem,
      required this.title})
      : super(key: key);

  @override
  State<DropDownMenuProduct> createState() => _DropDownMenuProductState();
}

class _DropDownMenuProductState extends State<DropDownMenuProduct> {
  // final List<String> _list = const [
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(shadowColor: Colors.transparent, useMaterial3: true),
      child: CustomDropdown<String>(
        hintText: '${widget.hintText}',
        validator: (value) {
          if (widget.title == "Filters") return null;
          if (value == null || value == "") {
            return "${widget.title} is missing!";
          }
          return null;
        },
        validateOnChange: true,
        items: widget.list,
        initialItem: widget.initialItem == "" ? null : widget.initialItem,
        decoration: CustomDropdownDecoration(
            closedFillColor: SubAdminAppPallete.secondaryColor,
            closedBorder: Border.all(
              width: 1,
              color: SubAdminAppPallete.greyColor,
            ),
            errorStyle: TextStyle(
              fontSize: 12,
            ),
            expandedShadow: [],
            expandedFillColor: SubAdminAppPallete.secondaryColor,
            closedShadow: [BoxShadow()]),
        onChanged: widget.onChange,
      ),
    );
  }
}
