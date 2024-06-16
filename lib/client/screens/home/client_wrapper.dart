import 'package:dot_com/auth/viewModel/auth_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/routes.dart';
import '../../view_model/Cart_view_model.dart';
import '../../view_model/checkout_view_model.dart';
import '../../view_model/home_view_model.dart';
import '../../view_model/order_history_view_model.dart';
import '../../view_model/payment_view_model.dart';
import '../../view_model/product_details_view_model.dart';
import '../../view_model/product_review_model.dart';
import '../../view_model/wishlist_view_model.dart';
import 'client_navigator.dart';

class ClientHomeWrapper extends StatefulWidget {
  const ClientHomeWrapper({super.key});

  @override
  State<ClientHomeWrapper> createState() => _ClientHomeWrapperState();
}

class _ClientHomeWrapperState extends State<ClientHomeWrapper> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => HomeViewModel()),
          ChangeNotifierProvider(create: (_) => WishListViewModel()),
          ChangeNotifierProvider(create: (_) => AuthViewModel()),
          ChangeNotifierProvider(create: (_) => ProductDetailsViewModel()),
          ChangeNotifierProvider(create: (_) => CartViewModel()),
          ChangeNotifierProvider(create: (_) => CheckOutViewModel()),
          ChangeNotifierProvider(create: (_) => PaymentViewModel()),
          ChangeNotifierProvider(create: (_) => OrderHistoryViewModel()),
          ChangeNotifierProvider(create: (_) => ProductReviewModel()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
            useMaterial3: true,
          ),
          home: ClientHome(),
          onGenerateRoute: Routes.controller,
        ));
  }
}
