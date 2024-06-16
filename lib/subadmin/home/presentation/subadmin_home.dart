import 'package:dot_com/subadmin/products/presentation/add_product.dart';
import 'package:dot_com/subadmin/profiles/presentation/subadmin_profile.dart';
import 'package:dot_com/subadmin/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../components/text_style.dart';
import '../../../utils/routes.dart';
import '../../orders/presentation/orders_subadmin.dart';
import '../../products/presentation/product_home_page.dart';
import '../viewModel/user_subadmin_viewModel.dart';

class SubAdminHomeWrapper extends StatefulWidget {
  const SubAdminHomeWrapper({super.key});

  @override
  State<SubAdminHomeWrapper> createState() => _SubAdminHomeWrapperState();
}

class _SubAdminHomeWrapperState extends State<SubAdminHomeWrapper> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserSubAdminViewModel()),
      ],
      child: MaterialApp(
        theme: AppTheme.lightThemeMode,
        home: SubAdminHome(),
        onGenerateRoute: Routes.controller,
      ),
    );
  }
}

class SubAdminHome extends StatefulWidget {
  const SubAdminHome({super.key});

  @override
  State<SubAdminHome> createState() => _SubAdminHomeState();
}

class _SubAdminHomeState extends State<SubAdminHome> {
  @override
  TextEditingController searchController = TextEditingController();
  FocusNode searchFocus = FocusNode();

  @override
  void initState() {
    Provider.of<UserSubAdminViewModel>(context, listen: false);
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
              onTap: () {
                Navigator.of(context).push(SubAdminProfile.route());
              },
              child: Consumer<UserSubAdminViewModel>(
                builder: (context, provider, child) {
                  return Row(
                    children: [
                      Text(
                        provider.user?.name ?? "",
                        style: Text_Style.large(
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                            overflow: TextOverflow.ellipsis),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Container(
                        height:30,
                        width: 30,
                        padding: EdgeInsets.all(1),
                        decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border:
                              Border.all(color: Color(0xFFEE4540), width: 1)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(provider.user?.profilePicUrl ?? "",fit: BoxFit.fill,errorBuilder: (_,__,___){
                              return Icon(
                                Icons.person,
                                color: Color(0xFFEE4540),
                              );
                            },),
                        ),
                      )
                    ],
                  );
                },
              ),
            )
          ],
        ),
        actions: [],
      ),
      body: SafeArea(
        child: Consumer<UserSubAdminViewModel>(
          builder: (context, provider, child) {
            return provider.isLoading || provider.error
                ? Center(
              child: CircularProgressIndicator(),
            ) : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Color(0xFFf4f6f9),
                        borderRadius: BorderRadius.circular(10)),
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
                              Navigator.push(context, ProductHomePage.route());
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Color(0xFFF3EDC8),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Products',
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
                              Navigator.of(context).push(OrdersPageSubAdmin.route());
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Color(0xFFF3EDC8),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: Text(
                                  'Orders',
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
                      Center(
                        child: GridTile(
                          child: GestureDetector(
                            onTap: () async {
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
