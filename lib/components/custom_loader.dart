import 'package:flutter/material.dart';

class CustomLoader {
  bool isbackEnabled;
  bool isCircleIndicatorEnabled;
  late BuildContext context;
  BuildContext? dialogContext;
  CustomLoader(
      {required context, this.isbackEnabled = true, this.isCircleIndicatorEnabled = true}) {
    this.context = context;
  }
  bool isLoaderOpen = false;

  dynamic controller;

  void createLoader() {
    controller = showDialog(
        barrierColor: isCircleIndicatorEnabled ? Colors.black12 : Colors.transparent,
        barrierDismissible: false,
        useSafeArea: true,
        context: context,
        builder: (BuildContext context) {
          this.dialogContext = context;
          return WillPopScope(
              onWillPop: () async {
                if (this.isbackEnabled == false) {
                  return Future.value(false);
                }
                this.isLoaderOpen = false;
                return Future.value(true);
              },
              child: isCircleIndicatorEnabled
                  ? Center(
                      child: Container(
                          height: 40,
                          width: 40,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          )),
                    )
                  : Container());
        });
    this.isLoaderOpen = true;
  }

  void dismissLoader() {
    if (isLoaderOpen && dialogContext != null) {
      Navigator.pop(dialogContext!);
      this.isLoaderOpen = false;
    }
  }
}
