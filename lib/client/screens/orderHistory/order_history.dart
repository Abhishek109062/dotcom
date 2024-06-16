import 'package:dot_com/client/view_model/order_history_view_model.dart';
import 'package:dot_com/components/color.dart';
import 'package:dot_com/components/text_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../components/custom_loader.dart';
import '../../../utils/routes.dart';
import '../../view_model/home_view_model.dart';
import '../wishlist/wishlist_page.dart';
import 'online_orders_List_Screen.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({super.key});

  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  late CustomLoader _customLoader;
  ScrollController _scrollController = ScrollController();
  late OrderHistoryViewModel provider;
  Future<void> _scrollListener() async {
    if (provider.isLoadingMore) return;
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      print('listener triggered');
      // _customLoader.createLoader();
      await provider.loadingMoreProductsTriggered();
      // _customLoader.dismissLoader();
    }
  }

  @override
  void initState() {
    super.initState();
    provider = Provider.of<OrderHistoryViewModel>(context, listen: false);

    _customLoader = CustomLoader(context: context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider.initialPage();
    });

    _scrollController.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<OrderHistoryViewModel>(
      builder: (context, orderHistoryViewModel, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Orders',
              style: Text_Style.large(color: Colors.grey),
            ),
            actions: [
              // IconButton(
              //   onPressed: () {
              //     // Handle search action
              //   },
              //   icon: Icon(Icons.search),
              // ),
              Consumer<HomeViewModel>(builder: (context, homeViewModel, child) {
                return IconButton(
                  onPressed: () {
                    if (!homeViewModel.loggedIn)
                      Navigator.pushNamed(
                        context,
                        Routes.loginScreen,
                      );

                    // showModalBottomSheet(
                    //     context: context,
                    //     builder: (BuildContext context) {
                    //       return LoginPage();
                    //     });
                    else
                      Navigator.pushNamed(context, Routes.cartScreen);
                    ;
                  },
                  icon: Icon(Icons.shopping_cart),
                );
              }),
              Consumer<HomeViewModel>(builder: (context, homeViewModel, child) {
                return IconButton(
                  onPressed: () {
                    if (!homeViewModel.loggedIn)
                      Navigator.pushNamed(
                        context,
                        Routes.loginScreen,
                      );
                    // showModalBottomSheet(
                    //     context: context,
                    //     builder: (BuildContext context) {
                    //       return LoginPage();
                    //     });
                    else
                      Navigator.push(context, MaterialPageRoute(builder: (_) => WishListPage()));
                  },
                  icon: Icon(Icons.favorite_border),
                );
              }),
            ],
          ),
          body: orderHistoryViewModel.isLoading
              ? Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                orderHistoryViewModel.selectedOrderType = 'Online';
                                orderHistoryViewModel.initialPage();
                              },
                              child: Container(
                                padding: EdgeInsets.all(8),
                                width: (size.width - 52) / 2,
                                height: 40,
                                decoration: BoxDecoration(
                                    color: orderHistoryViewModel.selectedOrderType == 'Online'
                                        ? AppColors.primarySecondThemeColor
                                        : AppColors.primaryThemeColor,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: Text(
                                    'Online',
                                    style: Text_Style.large(
                                        color: orderHistoryViewModel.selectedOrderType == 'Online'
                                            ? Colors.white
                                            : Colors.black),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            InkWell(
                              onTap: () {
                                orderHistoryViewModel.selectedOrderType = ('TakeAway');
                                orderHistoryViewModel.initialPage();
                              },
                              child: Container(
                                padding: EdgeInsets.all(8),
                                width: (size.width - 52) / 2,
                                height: 40,
                                decoration: BoxDecoration(
                                    color: orderHistoryViewModel.selectedOrderType == 'TakeAway'
                                        ? AppColors.primarySecondThemeColor
                                        : AppColors.primaryThemeColor,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: Text(
                                    'TakeAway',
                                    style: Text_Style.large(
                                        color: orderHistoryViewModel.selectedOrderType == 'TakeAway'
                                            ? Colors.white
                                            : Colors.black),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        if (orderHistoryViewModel.selectedOrderType == 'Online') ...[
                          if (orderHistoryViewModel.onlineOrderInfo.isEmpty)
                            Text('No Orders Found')
                          else
                            Column(
                                children: List.generate(
                                    orderHistoryViewModel.onlineOrderInfo.length,
                                    (index) => OnlineOrderDetailScreen(
                                          data: orderHistoryViewModel.onlineOrderInfo[index],
                                        )))
                        ] else if (orderHistoryViewModel.selectedOrderType == 'TakeAway') ...[
                          if (orderHistoryViewModel.takeAwayOrderInfo.isEmpty)
                            Text('No Orders Found')
                          else
                            Column(
                                children: List.generate(
                                    orderHistoryViewModel.takeAwayOrderInfo.length,
                                    (index) => OnlineOrderDetailScreen(
                                          data: orderHistoryViewModel.takeAwayOrderInfo[index],
                                        )))
                        ]

                        // OnlineOrderDetailScreen(),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }
}
