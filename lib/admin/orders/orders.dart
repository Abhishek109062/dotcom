import 'package:dot_com/admin/layouts/admin_appbar_layout.dart';
import 'package:dot_com/admin/orders/order_details.dart';
import 'package:dot_com/core/feature/order/repository/order_details_model_admin.dart';
import 'package:dot_com/admin/orders/viewModel/order_home_admin_viewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../components/text_style.dart';

class OrdersPageAdmin extends StatefulWidget {
  const OrdersPageAdmin({super.key});
  static Route<bool> route() => MaterialPageRoute<bool>(
      builder: (_) => ChangeNotifierProvider(
            create: (BuildContext context) => OrderHomeViewModelAdmin(),
            child: OrdersPageAdmin(),
          ));
  @override
  State<OrdersPageAdmin> createState() => _OrdersPageAdminState();
}

class _OrdersPageAdminState extends State<OrdersPageAdmin> {
  TextEditingController searchController = TextEditingController();
  FocusNode searchFocus = FocusNode();
  ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<OrderHomeViewModelAdmin>(context, listen: false).getAllOrders();
      _scrollController.addListener(() =>
          Provider.of<OrderHomeViewModelAdmin>(context, listen: false)
              .scrollListener(_scrollController));
    });
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
                // Navigator.of(context).push(AdminProfile.route());
              },
              child: Row(
                children: [
                  Text(
                    "Admin123",
                    style: Text_Style.large(
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                        overflow: TextOverflow.ellipsis),
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
      body: SingleChildScrollView(
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
                    "Orders",
                    style: TextStyle(fontSize: 22),
                  )
                ],
              ),
            ),
            Container(
              decoration:
                  BoxDecoration(color: Color(0xFFf4f6f9), borderRadius: BorderRadius.circular(10)),
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
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
            SizedBox(
              height: 10,
            ),
            Consumer<OrderHomeViewModelAdmin>(
              builder: (context, provider, child) {
                return ListView.separated(
                    padding: EdgeInsets.all(16),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => orderItem(provider.orders[index]),
                    separatorBuilder: (context, index) => Divider(
                          color: Color(0xFFCCCCCC),
                        ),
                    itemCount: provider.orders.length);
              },
            )
          ],
        ),
      ),
    );
  }

  Widget orderItem(OrderDetailsAdmin order) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(OrdersDetailsPage.route(order.id));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
                flex: 2,
                child: Text(
                  "ORDER ID ${order.id}",
                  style: Text_Style.medium(fontWeight: FontWeight.w500),
                )),
            Flexible(
                flex: 1,
                child: Text(
                  "${order.orderStatusDto}",
                  style: Text_Style.medium(fontWeight: FontWeight.w500),
                  textAlign: TextAlign.right,
                ))
          ],
        ),
      ),
    );
  }
}
