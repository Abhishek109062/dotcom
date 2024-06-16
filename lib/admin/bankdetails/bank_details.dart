import 'package:dot_com/admin/layouts/admin_appbar_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:passwordfield/passwordfield.dart';
import 'package:phone_form_field/phone_form_field.dart';

import '../../components/text_style.dart';

class BankDetailsPage extends StatefulWidget {
  const BankDetailsPage({super.key});

  @override
  State<BankDetailsPage> createState() => _BankDetailsPageState();
}

class _BankDetailsPageState extends State<BankDetailsPage> {
  Color buttonColor = Color(0xffB4B4B4);
  Color textColor = Color(0xff333333);
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AdminAppbarLayout(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      child: Icon(Icons.arrow_back),
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      "Bank Account Details",
                      style: TextStyle(fontSize: 22),
                    )
                  ],
                ),
                SizedBox(
                  height: 44,
                ),
                Text(
                  "Account Number",
                  style: Text_Style.small(),
                ),
                SizedBox(
                  height: 8,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Enter your account number",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                          color: Color(0xFF999999)), // Setting border color
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 8),
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Text(
                  "IFSC Code",
                  style: Text_Style.small(),
                ),
                SizedBox(
                  height: 8,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Enter IFSC Code",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                          color: Color(0xFF999999)), // Setting border color
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 8),
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Text(
                  "Bank Name",
                  style: Text_Style.small(),
                ),
                SizedBox(
                  height: 8,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Enter Bank Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                          color: Color(0xFF999999)), // Setting border color
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 8),
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Text(
                  "Card Holder Name",
                  style: Text_Style.small(),
                ),
                SizedBox(
                  height: 8,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Card Holder Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                          color: Color(0xFF999999)), // Setting border color
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 8),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
