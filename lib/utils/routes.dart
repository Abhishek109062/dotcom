import 'package:dot_com/client/screens/cart/cart_screen.dart';
import 'package:dot_com/client/screens/product/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dot_com/admin/home/admin_home.dart';
import 'package:flutter/cupertino.dart';

import '../auth/screen/login/login_page.dart';
import '../auth/screen/signup/sign_up_page.dart';
import '../auth/viewModel/auth_viewModel.dart';
import '../client/screens/cart/checkout_screen.dart';
import '../client/screens/cart/order_placed_screen.dart';
import '../client/screens/home/category_screen.dart';
import '../client/screens/home/client_wrapper.dart';
import '../client/screens/home/location_screen.dart';
import '../client/screens/profile/address_update.dart';
import '../client/screens/reviews/product_review_screen.dart';
import '../subadmin/home/presentation/subadmin_home.dart';

class Routes {
  static const String loginScreen = 'LoginScreen';
  static const String AdminScreen = 'AdminScreen';
  static const String SignUpScreen = 'SignUpScreen';
  static const String ClientScreen = 'ClientScreen';
  static const String CategoriesScreen = 'CategoriesScreen';
  static const String LocationScreen = 'LocationScreen';
  static const String AddressUpdateScreen = 'AddressUpdateScreen';
  static const String MyAccount = 'MyAccount';
  static const String productDetailScreen = 'ProductDetailScreen';
  static const String cartScreen = 'CartScreen';
  static const String SubAdminScreen = "SubAdminScreen";
  static const String updateAddress = "updateAddress";
  static const String checkoutScreen = "checkoutScreen";
  static const String onlineOrderDetailScreen = "onlineOrderDetailScreen";
  static const String takeAwayOrderDetailScreen = "takeAwayOrderDetailScreen";
  static const String orderPlacedScreen = "orderPlacedScreen";
  static const String productReviewScreen = "productReviewScreen";
  static Route<dynamic> controller(RouteSettings settings) {
    switch (settings.name) {
      case Routes.loginScreen:
        return MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
                  create: (_) => AuthViewModel(),
                  child: LoginPage(),
                ));
      case Routes.SignUpScreen:
        return MaterialPageRoute(
            builder: (context) =>
                ChangeNotifierProvider(create: (_) => AuthViewModel(), child: SignUpPage()));
      case Routes.ClientScreen:
        return MaterialPageRoute(builder: (context) => ClientHomeWrapper());
      case Routes.AdminScreen:
        return MaterialPageRoute(builder: (context) => AdminHomeWrapper());
      case Routes.SubAdminScreen:
        return MaterialPageRoute(builder: (context) => SubAdminHomeWrapper());
      case Routes.CategoriesScreen:
        return MaterialPageRoute(builder: (context) => CategoryScreen());
      case Routes.LocationScreen:
        return MaterialPageRoute(builder: (context) => LocationSelectScreen());
      case Routes.AddressUpdateScreen:
        return MaterialPageRoute(builder: (context) => AddressUpdate());
      case Routes.productDetailScreen:
        return MaterialPageRoute(builder: (context) => ProductDetailsScreen());
      case Routes.cartScreen:
        return MaterialPageRoute(builder: (context) => CartScreen());
      case Routes.updateAddress:
        return MaterialPageRoute(builder: (context) => AddressUpdate());

      case Routes.checkoutScreen:
        return MaterialPageRoute(builder: (context) => CheckOutScreen());
      case Routes.orderPlacedScreen:
        return MaterialPageRoute(builder: (context) => OrderPlacedScreen());
      case Routes.productReviewScreen:
        return MaterialPageRoute(builder: (context) => ProductReviewScreen());
      default:
        throw Exception('Route not found: ${settings.name}');
    }
  }
}
