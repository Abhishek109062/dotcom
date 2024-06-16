import 'package:dot_com/admin/advertisement/presentation/advertisement_page.dart';
import 'package:dot_com/admin/advertisement/viewModel/add_advertisement_viewModel.dart';
import 'package:dot_com/admin/bankdetails/bank_details.dart';
import 'package:dot_com/admin/layouts/admin_appbar_layout.dart';
import 'package:dot_com/admin/theme/admin_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../client/view_model/home_view_model.dart';
import '../../components/text_style.dart';
import '../../utils/routes.dart';
import '../orders/orders.dart';
import '../profile/presentation/admin_profile.dart';
import 'viewModel/user_admin_viewModel.dart';
import '../subadmin/presentation/pages/subadmin_list_page.dart';

class AdminHomeWrapper extends StatefulWidget {
  const AdminHomeWrapper({super.key});

  @override
  State<AdminHomeWrapper> createState() => _AdminHomeWrapperState();
}

class _AdminHomeWrapperState extends State<AdminHomeWrapper> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => UserAdminViewModel()),
        ],
        child: MaterialApp(
          theme: AdminAppTheme.lightThemeMode,
          home: AdminHomePage(),
          onGenerateRoute: Routes.controller,
        ));
  }
}

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  TextEditingController searchController = TextEditingController();
  FocusNode searchFocus = FocusNode();

  @override
  void initState() {
    Provider.of<UserAdminViewModel>(context, listen: false);
    super.initState();
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
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(AdminProfile.route());
              },
              child: Row(
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
              ),
            )
          ],
        ),
        actions: [],
      ),
      body: SafeArea(
        child: Consumer<UserAdminViewModel>(
          builder: (context, provider, child) {
            return provider.isLoading || provider.error
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Color(0xFFf4f6f9), borderRadius: BorderRadius.circular(10)),
                          margin: EdgeInsets.all(16),
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
                                onChanged: (val) {},
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
                        ),
                        GridView.count(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 152 / 107,
                          padding: EdgeInsets.all(16),
                          children: [
                            Center(
                              child: GridTile(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(context, AdvertisementPage.route());
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Color(0xFFF3EDC8),
                                        borderRadius: BorderRadius.circular(10)),
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'Add Advertisement',
                                          style: Text_Style.large(
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xFFFC5D5D)),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Center(
                              child: GridTile(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(OrdersPageAdmin.route());
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Color(0xFFF3EDC8),
                                        borderRadius: BorderRadius.circular(10)),
                                    child: Center(
                                      child: Text(
                                        'Orders',
                                        style: Text_Style.large(
                                            fontWeight: FontWeight.w500, color: Color(0xFFFC5D5D)),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Center(
                              child: GridTile(
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Color(0xFFF3EDC8),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                    child: Text(
                                      'Refund Request',
                                      style: Text_Style.large(
                                          fontWeight: FontWeight.w500, color: Color(0xFFFC5D5D)),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // Center(
                            //   child: GridTile(
                            //     child: GestureDetector(
                            //       onTap: () {
                            //         Navigator.of(context)
                            //             .push(MaterialPageRoute(builder: (_) => BankDetailsPage()));
                            //       },
                            //       child: Container(
                            //         decoration: BoxDecoration(
                            //             color: Color(0xFFF3EDC8),
                            //             borderRadius: BorderRadius.circular(10)),
                            //         child: Center(
                            //           child: Text(
                            //             'Bank Account details',
                            //             style: Text_Style.large(
                            //                 fontWeight: FontWeight.w500, color: Color(0xFFFC5D5D)),
                            //             textAlign: TextAlign.center,
                            //           ),
                            //         ),
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            Center(
                              child: GridTile(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(SubAdminPage.route());
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Color(0xFFF3EDC8),
                                        borderRadius: BorderRadius.circular(10)),
                                    child: Center(
                                      child: Text(
                                        'Sub-Admins',
                                        style: Text_Style.large(
                                            fontWeight: FontWeight.w500, color: Color(0xFFFC5D5D)),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Center(
                              child: GridTile(
                                child: GestureDetector(
                                  onTap: () async{
                                    final SharedPreferences prefs = await SharedPreferences.getInstance();
                                    prefs.clear();
                                    Navigator.pushNamed(context, Routes.loginScreen);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Color(0xFFF3EDC8),
                                        borderRadius:
                                        BorderRadius.circular(10)),
                                    child: Center(
                                      child: Text(
                                        'Logout',
                                        style: Text_Style.large(
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFFFC5D5D)),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  );

          },
        ),
      ),
    );
  }
}
