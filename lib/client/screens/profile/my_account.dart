import 'package:dot_com/client/screens/wishlist/wishlist_page.dart';
import 'package:dot_com/components/color.dart';
import 'package:dot_com/components/text_style.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../auth/screen/login/login_page.dart';
import '../../../components/custom_loader.dart';
import '../../../components/network_image_loader.dart';
import '../../../utils/routes.dart';
import '../../view_model/home_view_model.dart';
import 'edit_profile.dart';
import '../orderHistory/order_history.dart';

class MyAccountWrapper extends StatefulWidget {
  const MyAccountWrapper({super.key});

  @override
  State<MyAccountWrapper> createState() => _MyAccountWrapperState();
}

class _MyAccountWrapperState extends State<MyAccountWrapper> {
  String token = '';
  initializePage() async {
    var provider = Provider.of<HomeViewModel>(context, listen: false);
    if (!provider.loggedIn) {
      showModalBottomSheet(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          isScrollControlled: true,
          context: context,
          builder: (BuildContext context) {
            return LoginPage();
          });
    }
    // else {
    //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyAccount()));
    // }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      initializePage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, provider, child) {
        return provider.loggedIn
            ? MyAccount()
            : Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Login to Access your Profile',
                      style: Text_Style.large(),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          Routes.loginScreen,
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: AppColors.primarySecondThemeColor,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          'Login',
                          style: Text_Style.large(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              );
      },
    );
  }
}

class MyAccount extends StatefulWidget {
  const MyAccount({super.key});

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(builder: (context, viewModel, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'My Account',
            style: Text_Style.large(color: Colors.grey),
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Color(0xffFED7C7).withOpacity(0.3),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Color(0xffFED7C7))),
                  padding: EdgeInsets.all(16),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularPercentIndicator(
                        header: Container(),
                        footer: Container(),
                        animation: true,
                        radius: 60.0,
                        lineWidth: 5.0,
                        percent: 0.5,
                        center: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: NetworkImageLoader(
                            width: 105,
                            height: 105,
                            fit: BoxFit.fill,
                            image: viewModel.userDetails.profilePicUrl ?? '',
                            errorWidget: Center(
                              child: Image.asset('assets/person.jpg'),
                            ),
                          ),
                        ),
                        backgroundColor: Color(0xffFFD700),
                        progressColor: AppColors.primarySecondThemeColor,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        viewModel.userDetails.name ?? '',
                        style: Text_Style.large(
                          color: Color(0xffFC5D5D),
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(viewModel.userDetails.email ?? ''),
                      SizedBox(
                        height: 8,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          backgroundColor: Color(0xffFC5D5D),
                        ),
                        onPressed: () {
                          // Navigator.push(
                          //     context, MaterialPageRoute(builder: (context) => ClientHome()));
                        },
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context, MaterialPageRoute(builder: (_) => EditProfile()));
                          },
                          child: IntrinsicWidth(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Complete my profile',
                                  style: Text_Style.small(
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Icon(
                                  size: 15,
                                  Icons.arrow_forward_ios_outlined,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => WishListPage()));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xffFED7C7).withOpacity(0.3),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Color(0xffFED7C7))),
                    padding: EdgeInsets.all(16),
                    width: double.infinity,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.favorite,
                          color: Color(0xffFC5D5D),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          'Wishlist',
                          style: Text_Style.small(
                            color: Color(0xffFC5D5D),
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => OrderHistory()));
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xffFED7C7).withOpacity(0.3),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Color(0xffFED7C7))),
                      padding: EdgeInsets.all(16),
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          'Orders',
                          style: Text_Style.small(
                            color: Color(0xffFC5D5D),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )),
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Color(0xffFED7C7).withOpacity(0.3),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Color(0xffFED7C7))),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  width: double.infinity,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.share_location,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              viewModel.userDetails.address ?? '',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              '${viewModel.userDetails.city ?? ''}, ${viewModel.userDetails.state ?? ''} ',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          backgroundColor: AppColors.primarySecondThemeColor,
                        ),
                        onPressed: () async {
                          Navigator.pushNamed(context, Routes.updateAddress);
                        },
                        child: Text(
                          'Change',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                GestureDetector(
                  onTap: () async {
                    final SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.clear();
                    Navigator.pushNamed(context, Routes.loginScreen);
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xffFED7C7).withOpacity(0.3),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Color(0xffFED7C7))),
                      padding: EdgeInsets.all(16),
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          'Logout',
                          style: Text_Style.small(
                            color: Color(0xffFC5D5D),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )),
                ),
                SizedBox(
                  height: 200,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
