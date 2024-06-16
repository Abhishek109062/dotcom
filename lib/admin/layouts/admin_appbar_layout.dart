import 'package:dot_com/admin/profile/presentation/admin_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../components/text_style.dart';

class AdminAppbarLayout extends StatefulWidget {
  final Widget child;
  const AdminAppbarLayout({required this.child});

  @override
  State<AdminAppbarLayout> createState() => _AdminAppbarLayoutState();
}

class _AdminAppbarLayoutState extends State<AdminAppbarLayout> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFDFA),
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Color(0xFFFFFDFA),
        leading: SizedBox.shrink(),
        leadingWidth: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      color: Color(0xFFEE4540),
                      borderRadius: BorderRadius.circular(20)),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "dot.",
                  style: Text_Style.small(
                      color: Color(0xFFEE4540), fontWeight: FontWeight.w700),
                ),
                Text(
                  "ComSale",
                  style: Text_Style.small(
                      color: Colors.black, fontWeight: FontWeight.w700),
                ),
              ],
            ),
            GestureDetector(
              onTap: (){
                Navigator.of(context).push(AdminProfile.route());
              },
              child: Row(
                children: [
                  Text(
                    "Admin123",
                    style: Text_Style.large(
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                        overflow: TextOverflow.ellipsis),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Container(
                      padding: EdgeInsets.all(1),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Color(0xFFEE4540), width: 1)),
                      child: Icon(
                        Icons.person,
                        color: Color(0xFFEE4540),
                      ))
                ],
              ),
            )
          ],
        ),
        actions: [],
      ),
      body: SafeArea(
        child: widget.child,
      ),
    );
  }



}
