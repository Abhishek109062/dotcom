
import 'package:dot_com/admin/advertisement/presentation/add_advertisement.dart';
import 'package:dot_com/admin/advertisement/repository/advertisement_detail_model.dart';
import 'package:dot_com/admin/snackbar_custom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../../components/text_style.dart';
import '../../home/viewModel/user_admin_viewModel.dart';
import '../viewModel/advertisements_viewModel.dart';

class AdvertisementPage extends StatefulWidget {
  static route() => MaterialPageRoute(
      builder: (context) => ChangeNotifierProvider(
            create: (BuildContext context) => AdvertisementViewModel(),
            child: AdvertisementPage(),
          ));
  const AdvertisementPage({super.key});

  @override
  State<AdvertisementPage> createState() => _AdvertisementPageState();
}

class _AdvertisementPageState extends State<AdvertisementPage> {
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
      Provider.of<AdvertisementViewModel>(context, listen: false)
          .getAdvertisements();
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
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
                      "Advertisements ",
                      style: TextStyle(fontSize: 22),
                    )
                  ],
                ),
              ),
              // Container(
              //   decoration: BoxDecoration(
              //       color: Color(0xFFf4f6f9),
              //       borderRadius: BorderRadius.circular(10)),
              //   margin: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              //   padding: EdgeInsets.symmetric(horizontal: 8),
              //   child: ListTile(
              //     horizontalTitleGap: 0,
              //     visualDensity: VisualDensity(horizontal: 2, vertical: -4),
              //     minVerticalPadding: 0,
              //     trailing: GestureDetector(
              //         onTap: () {
              //           searchController.clear();
              //         },
              //         child: Icon(Icons.search)),
              //     contentPadding: EdgeInsets.zero,
              //     title: Container(
              //       child: TextFormField(
              //         controller: searchController,
              //         focusNode: searchFocus,
              //         onTapOutside: (tap) {
              //           searchFocus.unfocus();
              //         },
              //         onChanged: (val) {
              //           setState(() {
              //             search = val ?? "";
              //             onSearchChanged(search);
              //           });
              //         },
              //         onFieldSubmitted: (String val) {},
              //         decoration: InputDecoration(
              //             contentPadding: EdgeInsets.zero,
              //             floatingLabelBehavior: FloatingLabelBehavior.auto,
              //             hintText: "Search",
              //             border: InputBorder.none,
              //             isDense: true
              //             // errorText: false ? 'Last Name is required' : null,
              //             ),
              //       ),
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: 20,
              // ),
              Consumer<AdvertisementViewModel>(
                builder: (context, provider, child) {
                  return provider.isLoading ? Center(child: CircularProgressIndicator(),):ListView.builder(
                      itemCount: provider.advertisements.length,
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemBuilder: (context, index) {
                        return advertisementCard(advert:provider.advertisements[index],deleteAdvert: provider.deleteAdvertisement);
                      });
                },
              ),
              SizedBox(height: 80,)
            ],
          ),
        ),
      ),
      bottomSheet: Consumer<AdvertisementViewModel>(
  builder: (context, provider, child) {
  return Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(0)),
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
        child: Row(
          children: [
            Expanded(
                child: TextButton(
                    onPressed: () async {
                      bool? res = await Navigator.of(context).push(AddAdvertisement.route());
                      if(res == true){
                        provider.reloadPage();
                      }
                    },
                    style: TextButton.styleFrom(
                        maximumSize: Size.fromHeight(44),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        backgroundColor: Color(0xffFC5D5D)),
                    child: Text(
                      "Add Advertisement",
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

  Widget advertisementCard({required AdvertisementDetailsDto advert, required Future<bool> Function(int id) deleteAdvert}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      margin: EdgeInsets.only(top: 16),
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
                    advert.bannerUrl,
                    fit: BoxFit.cover,
                    loadingBuilder:(BuildContext context, Widget child,ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(child: Row(children: [Spacer()],),color: Colors.grey,);
                    },
                  ),
                ),
                Positioned(
                    right: 10,
                    top: 10,
                    child: GestureDetector(
                        onTap: () async {
                          bool? res = await deleteConfirmationDialog();
                          if (res ?? false) {
                              deleteAdvert(advert.id).then((value){
                                if(value){
                                  snackBarCustom(context, "Advertisement Deleted Successfully");
                                }
                              });
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

  deleteConfirmationDialog() async {
    return await showDialog(
      useRootNavigator: false,
        context: context,
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
