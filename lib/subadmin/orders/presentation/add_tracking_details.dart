import 'dart:io';

import 'package:dot_com/admin/snackbar_custom.dart';
import 'package:dot_com/components/text_style.dart';
import 'package:dot_com/subadmin/home/viewModel/user_subadmin_viewModel.dart';
import 'package:dot_com/subadmin/orders/presentation/widgets/text_field_order_subadmin.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewModel/add_tracking_details_viewModel.dart';

class AddTrackingDetails extends StatefulWidget {
  static Route<bool> route(int id) => MaterialPageRoute<bool>(
      builder: (context) => ChangeNotifierProvider(
            create: (BuildContext context) => AddTrackingDetailsViewModel(orderId: id),
            child: AddTrackingDetails(),
          ));

  const AddTrackingDetails({Key? key}) : super(key: key);

  @override
  State<AddTrackingDetails> createState() => _AddTrackingDetailsState();
}

class _AddTrackingDetailsState extends State<AddTrackingDetails> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode linkFocusNode = FocusNode();
  final FocusNode trackingIdFocusNode = FocusNode();
  final FocusNode serviceProviderFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance!.addPostFrameCallback((_) {
    //   // Provider.of<AddTrackingDetailsViewModel>(context, listen: false)
    //   //     .getAllProducts();
    // });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // appBar: AppBar(
      //   titleSpacing: 0,
      //   title: Text(
      //     "Advertisement/Add Advertisement",
      //     style: Text_Style.medium(color: Color(0xFF6586A0)),
      //   ),
      // ),
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
                      color: Color(0xFFEE4540), borderRadius: BorderRadius.circular(20)),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "dot.",
                  style: Text_Style.small(color: Color(0xFFEE4540), fontWeight: FontWeight.w700),
                ),
                Text(
                  "ComSale",
                  style: Text_Style.small(color: Colors.black, fontWeight: FontWeight.w700),
                ),
              ],
            ),
            Row(
              children: [
                Consumer<UserSubAdminViewModel>(
                  builder: (context, provider, child) {
                    return Text(
                      provider.user?.name ?? "",
                      style: Text_Style.large(
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                          overflow: TextOverflow.ellipsis),
                    );
                  },
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
            )
          ],
        ),
        actions: [],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Consumer<AddTrackingDetailsViewModel>(
            builder: (context, provider, child) {
              return AbsorbPointer(
                absorbing: provider.isSubmitting,
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          "Tracking Link",
                          style: Text_Style.small(
                              color: Color(0xff333333), fontWeight: FontWeight.w400),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: TextFieldOrder(
                          controller: provider.linkController,
                          title: "Tracking Link",
                          focusNode: linkFocusNode,
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          "Tracking Id",
                          style: Text_Style.small(
                              color: Color(0xff333333), fontWeight: FontWeight.w400),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: TextFieldOrder(
                          controller: provider.trackingIdController,
                          title: "Tracking Id",
                          focusNode: trackingIdFocusNode,
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          "Service Provider",
                          style: Text_Style.small(
                              color: Color(0xff333333), fontWeight: FontWeight.w400),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: TextFieldOrder(
                          controller: provider.serviceProviderController,
                          title: "Service Provider",
                          focusNode: serviceProviderFocusNode,
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 100,
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
      bottomSheet: Consumer<AddTrackingDetailsViewModel>(
        builder: (context, provider, child) {
          return Container(
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(0)),
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                    child: TextButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()){
                            provider.updateTrackingDetails(() {
                              snackBarCustom(context, "Details Saved Successfully");
                              Navigator.of(context).pop(true);
                            }, (String msg) => snackBarCustom(context, msg));
                          }
                        },
                        style: TextButton.styleFrom(
                            maximumSize: Size.fromHeight(44),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10))),
                            backgroundColor:
                                provider.getAddBtnStatus() ? Color(0xffFC5D5D) : Color(0xff999999)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            provider.isSubmitting
                                ? Container(
                                    height: 16,
                                    width: 16,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  )
                                : Text(
                                    "Save Details",
                                    style: Text_Style.medium(
                                        fontWeight: FontWeight.w500, color: Colors.white),
                                  ),
                          ],
                        )))
              ],
            ),
          );
        },
      ),
    );
  }

  Widget advertisementCard({required String image, required VoidCallback deleteImage}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            height: 160,
            width: double.infinity,
            child: Stack(
              fit: StackFit.passthrough,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    image,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                    right: 10,
                    top: 10,
                    child: GestureDetector(
                        onTap: () async {
                          bool? res = await deleteConfirmationDialog();
                          if (res ?? false) {
                            deleteImage();
                          }
                        },
                        child: Container(
                            height: 30, width: 30, child: Image.asset("assets/deleteIcon.png"))))
              ],
            ),
          )),
    );
  }

  Widget addAdvertisementCard({required Function() onTap, required bool uploading}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            height: 160,
            color: Colors.grey,
            width: double.infinity,
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                uploading
                    ? CircularProgressIndicator()
                    : TextButton(
                        onPressed: onTap,
                        style: TextButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            maximumSize: Size.fromHeight(40),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                side: BorderSide(color: Color(0xffFC5D5D))),
                            backgroundColor: Colors.white),
                        child: Text(
                          "+ Add Photo",
                          style: Text_Style.medium(
                              fontWeight: FontWeight.w500, color: Color(0xff4D4D4D)),
                        )),
              ],
            ),
          )),
    );
  }

  deleteConfirmationDialog() async {
    return await showDialog(
        context: context,
        useRootNavigator: false,
        builder: (_) {
          return AlertDialog(
            titlePadding: EdgeInsets.all(16),
            backgroundColor: Color(0xffFFF9EC),
            title: Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text(
                "Are You Sure You want to Delete this Advertisement",
                style: Text_Style.medium(fontWeight: FontWeight.w500, color: Color(0xffFC5D5D)),
                textAlign: TextAlign.center,
              ),
            ),
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              TextButton(
                  onPressed: () async {
                    Navigator.of(context).pop(true);
                  },
                  style: TextButton.styleFrom(
                      maximumSize: Size.fromHeight(40),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      backgroundColor: Color(0xffFC5D5D)),
                  child: Text(
                    "Yes",
                    style: Text_Style.medium(fontWeight: FontWeight.w500, color: Colors.white),
                  )),
              TextButton(
                  onPressed: () async {
                    Navigator.of(context).pop(false);
                  },
                  style: TextButton.styleFrom(
                      maximumSize: Size.fromHeight(40),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      backgroundColor: Colors.transparent),
                  child: Text(
                    "No",
                    style: Text_Style.medium(fontWeight: FontWeight.w500, color: Color(0xff666666)),
                  ))
            ],
          );
        });
  }
}
