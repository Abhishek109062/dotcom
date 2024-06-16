import 'dart:io';

import 'package:dot_com/admin/advertisement/viewModel/add_advertisement_viewModel.dart';
import 'package:dot_com/admin/snackbar_custom.dart';
import 'package:dot_com/components/customsnackbar.dart';
import 'package:dot_com/components/formfields/formfieldvalidators.dart';
import 'package:dot_com/components/text_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../components/formfields/formfields.dart';
import '../../home/viewModel/user_admin_viewModel.dart';

class AddAdvertisement extends StatefulWidget {
  static Route<bool> route() => MaterialPageRoute<bool>(
      builder: (context) => ChangeNotifierProvider(
            create: (BuildContext context) => AddAdvertisementViewModel(),
            child: AddAdvertisement(),
          ));

  const AddAdvertisement({Key? key}) : super(key: key);

  @override
  State<AddAdvertisement> createState() => _AddAdvertisementState();
}

class _AddAdvertisementState extends State<AddAdvertisement> {
  TextEditingController searchController = TextEditingController();
  ScrollController _scrollController = ScrollController();
  FocusNode searchFocus = FocusNode();
  String search = "";

  onSearchChanged(String val) {
    setState(() {
      this.search = val;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Provider.of<AddAdvertisementViewModel>(context, listen: false)
          .getAllProducts();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
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
            Row(
              children: [
                Consumer<UserAdminViewModel>(
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                  leading: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: Color(0xFF6586A0),
                      )),
                  title: Text(
                    "Advertisement/Add Advertisement",
                    style: Text_Style.medium(color: Color(0xFF6586A0)),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Consumer<AddAdvertisementViewModel>(
                  builder: (context, provider, child) {
                    return provider.imageUrl != ""
                        ? advertisementCard(
                            image: provider.imageUrl,
                            deleteImage: provider.deleteImage)
                        : addAdvertisementCard(
                            onTap: provider.selectImage,
                            uploading: provider.uploadingImage);
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Text(
                        "Add Product to the Advertisement",
                        style: Text_Style.medium(
                            color: Color(0xff333333),
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Color(0xFFF3F3F3),
                      borderRadius: BorderRadius.circular(10)),
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: ListTile(
                    horizontalTitleGap: 0,
                    visualDensity: VisualDensity(horizontal: 2, vertical: -2),
                    minVerticalPadding: 0,
                    trailing: GestureDetector(
                        onTap: () {
                          searchController.clear();
                        },
                        child: Icon(
                          Icons.search,
                          color: Color(0xff666666),
                        )),
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
                            onSearchChanged(search);
                          });
                        },
                        onFieldSubmitted: (String val) {},
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            hintText: "Search",
                            hintStyle: TextStyle(color: Color(0xff666666)),
                            border: InputBorder.none,
                            isDense: true
                            // errorText: false ? 'Last Name is required' : null,
                            ),
                      ),
                    ),
                  ),
                ),
                // CheckboxListTile(value: false, onChanged: (bool){},title: Text("TITLE"),)
                Consumer<AddAdvertisementViewModel>(
                  builder: (context, provider, child) {
                    return provider.loadingProducts
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : ListView.builder(
                            physics: ScrollPhysics(),
                            itemCount: provider.products.length,
                            shrinkWrap: true,
                            itemBuilder: (context, i) {
                              return CheckboxListTile(
                                title: Text(provider.products[i].title),
                                value: provider.userChecked
                                    .contains(provider.products[i].id),
                                onChanged: (val) {
                                  provider.onSelected(
                                      val ?? false, provider.products[i].id);
                                },
                              );
                            },
                          );
                  },
                ),
                SizedBox(
                  height: 80,
                )
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Consumer<AddAdvertisementViewModel>(
        builder: (context, provider, child) {
          return Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(0)),
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                    child: TextButton(
                        onPressed: () async {
                          if (provider.getCreateAdvertBtnStatus()) {
                            bool res = await provider.addAdvertisement();
                            if (res) {
                              snackBarCustom(
                                  context, "Advertisement added successfully");
                              Navigator.of(context).pop(true);
                            }
                          }
                        },
                        style: TextButton.styleFrom(
                            maximumSize: Size.fromHeight(44),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            backgroundColor: provider.getCreateAdvertBtnStatus()
                                ? Color(0xffFC5D5D)
                                : Color(0xff999999)),
                        child: Text(
                          "Create Advertisement",
                          style: Text_Style.medium(
                              fontWeight: FontWeight.w500, color: Colors.white),
                        )))
              ],
            ),
          );
        },
      ),
    );
  }

  Widget advertisementCard(
      {required String image, required VoidCallback deleteImage}) {
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
                            height: 30,
                            width: 30,
                            child: Image.asset("assets/deleteIcon.png"))))
              ],
            ),
          )),
    );
  }

  Widget addAdvertisementCard(
      {required Function() onTap, required bool uploading}) {
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                side: BorderSide(color: Color(0xffFC5D5D))),
                            backgroundColor: Colors.white),
                        child: Text(
                          "+ Add Photo",
                          style: Text_Style.medium(
                              fontWeight: FontWeight.w500,
                              color: Color(0xff4D4D4D)),
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
                style: Text_Style.medium(
                    fontWeight: FontWeight.w500, color: Color(0xffFC5D5D)),
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
                    style: Text_Style.medium(
                        fontWeight: FontWeight.w500, color: Colors.white),
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
                    style: Text_Style.medium(
                        fontWeight: FontWeight.w500, color: Color(0xff666666)),
                  ))
            ],
          );
        });
  }
}
