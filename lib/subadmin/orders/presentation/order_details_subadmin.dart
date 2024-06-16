

  import 'package:dot_com/subadmin/theme/subadmin_pallet.dart';
  import 'package:flutter/material.dart';
  import 'package:provider/provider.dart';
  import 'package:intl/intl.dart';

  import '../../../admin/snackbar_custom.dart';
  import '../../../components/text_style.dart';
  import '../../../core/feature/order/repository/order_details_model_admin.dart';
  import '../viewModel/order_details_sub_admin_viewModel.dart';
import 'add_tracking_details.dart';
  class OrdersDetailsPageSubAdmin extends StatefulWidget {
    const OrdersDetailsPageSubAdmin({super.key});

    static Route<bool> route(int orderId) => MaterialPageRoute<bool>(
        builder: (_) => ChangeNotifierProvider(
              create: (BuildContext context) => OrderDetailsSubAdminViewModel(orderId: orderId),
              child: OrdersDetailsPageSubAdmin(),
            ));

    @override
    State<OrdersDetailsPageSubAdmin> createState() => _OrdersDetailsPageSubAdminState();
  }

  class _OrdersDetailsPageSubAdminState extends State<OrdersDetailsPageSubAdmin> {
    @override
    void initState() {
      super.initState();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Provider.of<OrderDetailsSubAdminViewModel>(context, listen: false).getOrderDetails();
      });
    }

    String formatDateFromMilliseconds(int millisecondsSinceEpoch) {
      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);

      String formattedDate = DateFormat('d MMMM y', 'en_US').format(dateTime);

      return formattedDate;
    }

    int getOrderQuantity(List<OrderedProductDetailsDto> items) {
      int qty = 0;
      items.forEach((element) {
        qty += element.orderedQuantity;
      });
      return qty;
    }

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
        body: Consumer<OrderDetailsSubAdminViewModel>(
          builder: (context, provider, child) {
            return SafeArea(
              child: provider.isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Row(
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
                                  "Order Details",
                                  style: Text_Style.medium(color: Color(0xFF6586A0)),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Container(
                              child: Center(
                                  child: Text(
                                "Status",
                                style: Text_Style.large(fontWeight: FontWeight.w500),
                              )),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                  color: Color(0xFFFFF9EC),
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(color: Color(0xFFCCCCCC))),
                              child: Center(
                                  child: Text(
                                "${provider.orderDetails!.orderStatusDto}",
                                style: Text_Style.medium(
                                    fontWeight: FontWeight.w400, color: Color(0xFF00E8B0)),
                              )),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Details",
                                style: Text_Style.medium(
                                    fontWeight: FontWeight.w400, color: Color(0xff333333)),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            ...List.generate(
                                provider.orderDetails!.orderedProductDetailsDto.length,
                                (index) => orderedItem(
                                    provider.orderDetails!.orderedProductDetailsDto[index])),
                            SizedBox(
                              height: 30,
                            ),
                            orderDetailsTile(
                                title: "Order Date",
                                value:
                                    "${formatDateFromMilliseconds(provider.orderDetails!.dateOfOrder)}"),
                            orderDetailsTile(
                                title: "Order ID", value: "${provider.orderDetails!.id}"),
                            orderDetailsTile(title: "Order Amount", value: "${getOrderQuantity(provider.orderDetails!.orderedProductDetailsDto)} (Qty)"),
                            SizedBox(
                              height: 30,
                            ),
                            payingMethod(),
                            SizedBox(
                              height: 30,
                            ),
                            trackingDetails(provider.orderDetails!),
                            SizedBox(
                              height: 30,
                            ),
                            takeAwayAddress(title: "Takeaway"),
                            provider.orderDetails!.shippingAddress.isNotEmpty
                                ? shippingAddress(provider.orderDetails!)
                                : SizedBox(),
                            SizedBox(
                              height: 30,
                            ),
                            orderSummary(provider.orderDetails!),
                            SizedBox(
                              height: 16,
                            ),
                            GestureDetector(
                              onTap: ()async{
                                bool res = await provider.cancelOrder();
                                if(res){
                                  snackBarCustom(context, "Order cancelled successfully");
                                  Navigator.of(context).pop(true);
                                }
                              },
                              child: ListTile(
                                leading: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Color(0xffFC5D5D)),
                                    child: Icon(
                                      Icons.close,
                                      color: Colors.white,
                                      size: 24,
                                    )),
                                title: Text(
                                  "Cancel Order",
                                  style: Text_Style.medium(
                                      color: Color(0xff333333), fontWeight: FontWeight.w400),
                                ),
                                trailing: Icon(Icons.arrow_forward_ios_rounded),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                      ),
                    ),
            );
          },
        ),
      );
    }

    Widget takeAwayAddress({required String title}) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "$title Address",
                style: Text_Style.large(fontWeight: FontWeight.w400, color: Color(0xff333333)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0),
            child: Container(
              padding: EdgeInsets.all(8),
              decoration:
                  BoxDecoration(color: Color(0xFFFFF9EC), borderRadius: BorderRadius.circular(8)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Gokul Dham society, 3rd Floor ,Near Abdul Soda Shop.",
                    style: Text_Style.medium(fontWeight: FontWeight.w400, color: Color(0xFF9D9D9D)),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Maharashtra , Pune 30",
                    style: Text_Style.small(fontWeight: FontWeight.w400, color: Color(0xFF9D9D9D)),
                  )
                ],
              ),
            ),
          ),
        ],
      );
    }

    Widget shippingAddress(OrderDetailsAdmin orderDetails) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Shipping Address",
                style: Text_Style.large(fontWeight: FontWeight.w400, color: Color(0xff333333)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0),
            child: Container(
              padding: EdgeInsets.all(8),
              decoration:
                  BoxDecoration(color: Color(0xFFFFF9EC), borderRadius: BorderRadius.circular(8)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "${orderDetails.shippingAddress ?? ""}",
                    style: Text_Style.medium(fontWeight: FontWeight.w400, color: Color(0xFF9D9D9D)),
                  ),
                  // SizedBox(
                  //   height: 8,
                  // ),
                  // Text(
                  //   "Maharashtra , Pune 30",
                  //   style: Text_Style.small(fontWeight: FontWeight.w400, color: Color(0xFF9D9D9D)),
                  // )
                ],
              ),
            ),
          ),
        ],
      );
    }

    Widget orderSummary(OrderDetailsAdmin orderDetails) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Order Summary",
                style: Text_Style.large(fontWeight: FontWeight.w500, color: Color(0xff333333)),
              ),
            ),
          ),
          orderSummaryTile(title: "SUBTOTAL", value: "${orderDetails.totalOrderPrice}"),
          orderSummaryTile(title: "Discount", value: "${orderDetails.totalDiscountInRuppee}"),
          orderSummaryTile(title: "Shipping", value: "${orderDetails.shippingCharge}"),
          Divider(
            color: Color(0xff333333),
            thickness: 1,
          ),
          orderSummaryTile(
              title: "Grand Total",
              value:
                  "${orderDetails.totalOrderPrice + orderDetails.shippingCharge - orderDetails.totalDiscountInRuppee}",
              total: true),
        ],
      );
    }

    Widget orderSummaryTile({required String title, required String value, bool total = false}) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
                flex: 1,
                child: Text(
                  "$title",
                  style: total == false
                      ? Text_Style.medium(fontWeight: FontWeight.w400, color: Color(0xff333333))
                      : Text_Style.large(fontWeight: FontWeight.w600, color: Color(0xff333333)),
                )),
            Flexible(
                flex: 2,
                child: Text("\u{20B9} $value",
                    style: total == false
                        ? Text_Style.medium(fontWeight: FontWeight.w400, color: Color(0xff333333))
                        : Text_Style.large(fontWeight: FontWeight.w600, color: Color(0xff333333))))
          ],
        ),
      );
    }

    Widget payingMethod() {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Paying method",
                style: Text_Style.large(fontWeight: FontWeight.w400, color: Color(0xff333333)),
              ),
            ),
          ),
          Container(
            decoration:
                BoxDecoration(color: Color(0xFFFFF9EC), borderRadius: BorderRadius.circular(8)),
            child: orderDetailsTile(title: "Payment ID", value: "407-52777618-43"),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Container(
              padding: EdgeInsets.all(8),
              decoration:
                  BoxDecoration(color: Color(0xFFFFF9EC), borderRadius: BorderRadius.circular(8)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Online Payment",
                    style: Text_Style.medium(fontWeight: FontWeight.w400),
                  ),
                  Text(
                    "YOu have paid through UPI",
                    style: Text_Style.small(fontWeight: FontWeight.w400, color: Color(0xFF9D9D9D)),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0.0),
            // padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Container(
              padding: EdgeInsets.all(8),
              decoration:
                  BoxDecoration(color: Color(0xFFFFF9EC), borderRadius: BorderRadius.circular(8)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Take Away",
                    style: Text_Style.medium(fontWeight: FontWeight.w400),
                  ),
                  Text(
                    "Pick Your Order From the Takeaway Address",
                    style: Text_Style.small(fontWeight: FontWeight.w400, color: Color(0xFF9D9D9D)),
                  )
                ],
              ),
            ),
          )
        ],
      );
    }

    Widget orderDetailsTile({required String title, required String value}) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
                flex: 1,
                child: Text(
                  "$title",
                  style: Text_Style.medium(fontWeight: FontWeight.w500),
                )),
            Flexible(
                flex: 2,
                child: Text(
                  "$value",
                  style: Text_Style.medium(fontWeight: FontWeight.w500, color: Color(0xff505050)),
                ))
          ],
        ),
      );
    }

    Widget orderedItem(OrderedProductDetailsDto orderdProduct) {
      return Container(
          height: 122,
          margin: EdgeInsets.only(bottom: 8),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Flexible(
                flex: 2,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(5.5),
                    child: Container(
                      child: AspectRatio(
                        aspectRatio: 4 / 4.5,
                        child: Image.network(
                          orderdProduct.productMetadataUrls.isNotEmpty
                              ? orderdProduct.productMetadataUrls.first
                              : "",
                          fit: BoxFit.fill,
                          errorBuilder: (_, __, ___) {
                            return Image.asset("assets/not_found.jpg");
                          },
                        ),
                      ),
                      // child:,
                    )),
              ),
              SizedBox(
                width: 20,
              ),
              Flexible(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${orderdProduct.productName}",
                      style: Text_Style.large(
                          fontWeight: FontWeight.w400, overflow: TextOverflow.ellipsis),
                      maxLines: 2,
                    ),
                    RichText(
                      text: TextSpan(
                          text: '\u{20B9} ${orderdProduct.orderedPrice}',
                          style: TextStyle(color: Colors.black, fontSize: 18),
                          children: <TextSpan>[
                            TextSpan(
                              text: '   Quantity   ',
                              style: TextStyle(fontSize: 10, color: Color(0xFF9D9D9D)),
                            ),
                            TextSpan(
                              text: '${orderdProduct.orderedQuantity}',
                              style: new TextStyle(
                                color: Colors.black,

                              ),
                            )
                          ]),
                    ),
                  ],
                ),
              )
            ],
          ));
    }

    Widget trackingDetails(OrderDetailsAdmin orderDetails) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Tracking Details",
                  style: Text_Style.large(fontWeight: FontWeight.w400, color: Color(0xff333333)),
                ),
                Container(
                  height: 40,
                  child: TextButton(
                      onPressed: () async{
                         bool res = await Navigator.of(context).push(AddTrackingDetails.route(orderDetails.id)) ?? false;
                         if(res){
                           Provider.of<OrderDetailsSubAdminViewModel>(context, listen: false).getOrderDetails();
                         }
                      },
                      style: TextButton.styleFrom(
                          maximumSize: Size.fromHeight(40),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(5))),
                          backgroundColor: SubAdminAppPallete.primaryColor),
                      child: Text(
                        "Edit",
                        style:
                        Text_Style.medium(fontWeight: FontWeight.w500, color: Colors.white),
                      )),
                ),
              ],
            ),
          ),
          trackingDetailsTile(title: "Tracking ID", value: "${orderDetails.trackingId ?? "N/A"}"),
          trackingDetailsTile(
              title: "Service Provider", value: "${orderDetails.trackingServiceProvider ?? "N/A"}"),
          trackingDetailsTile(title: "Link", value: "${orderDetails.trackingLink ?? "N/A"}"),
        ],
      );
    }

    Widget trackingDetailsTile({required String title, required String value}) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
                flex: 1,
                child: Text(
                  "$title",
                  style: Text_Style.small(fontWeight: FontWeight.w400, color: Color(0xff666666)),
                )),
            Flexible(
                flex: 2,
                child: SelectableText("$value",
                    style: Text_Style.small(fontWeight: FontWeight.w400, color: Color(0xff333333))))
          ],
        ),
      );
    }
  }
