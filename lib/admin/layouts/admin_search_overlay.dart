import 'package:dot_com/admin/layouts/admin_appbar_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../components/text_style.dart';

class AdminSearchLayout extends StatefulWidget {
  final Widget child;
  final String pageTitle;
  final Function(String) onSearchChanged;
  const AdminSearchLayout({required this.child, required this.onSearchChanged,required this.pageTitle});

  @override
  State<AdminSearchLayout> createState() => _AdminSearchLayoutState();
}

class _AdminSearchLayoutState extends State<AdminSearchLayout> {
  TextEditingController searchController = TextEditingController();
  FocusNode searchFocus = FocusNode();
  String search = "";
  @override
  Widget build(BuildContext context) {
    return AdminAppbarLayout(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [ Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
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
                    "${widget.pageTitle}",
                    style: TextStyle(fontSize: 22),
                  )
                ],
              ),
            ),
              Container(
                decoration: BoxDecoration(
                    color: Color(0xFFf4f6f9),
                    borderRadius: BorderRadius.circular(10)),
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: ListTile(
                  horizontalTitleGap: 0,
                  visualDensity: VisualDensity(horizontal: 2, vertical: -4),
                  minVerticalPadding: 0,
                  trailing: GestureDetector(
                      onTap: () {
                        searchController.clear();
                      },
                      child: Icon(Icons.search)),
                  contentPadding: EdgeInsets.zero,
                  title: Container(
                    child: TextFormField(
                      controller: searchController,
                      focusNode: searchFocus,
                      onTapOutside: (tap) {
                        searchFocus.unfocus();
                      },
                      onChanged: (val) {
                        setState(() {
                          search = val ?? "";
                          widget.onSearchChanged(search);
                        });
                      },
                      onFieldSubmitted: (String val) {},
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          hintText: "Search",
                          border: InputBorder.none,
                          isDense: true
                        // errorText: false ? 'Last Name is required' : null,
                      ),
                    ),
                  ),
                ),

              ),widget.child],
          ),
        ));
  }
}
