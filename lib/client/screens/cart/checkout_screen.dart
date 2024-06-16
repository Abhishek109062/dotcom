import 'package:dot_com/components/color.dart';
import 'package:dot_com/components/text_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../components/custom_loader.dart';
import '../../../components/network_image_loader.dart';
import '../../view_model/checkout_view_model.dart';
import '../../view_model/home_view_model.dart';
import '../../view_model/payment_view_model.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  late CustomLoader _customLoader;

  void initState() {
    super.initState();
    _customLoader = CustomLoader(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Checkout',
          style: Text_Style.large(color: Colors.grey),
        ),
      ),
      body: Consumer<HomeViewModel>(builder: (_, viewModel, child) {
        return Consumer<CheckOutViewModel>(builder: (_, vM, child) {
          return Container(
            padding: EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                color: Colors.grey,
                              )),
                          child: Icon(
                            Icons.person,
                            size: 15,
                          )),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            viewModel.userDetails.name ?? '',
                            style: Text_Style.medium(),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Text(
                      "Payment Method",
                      style: Text_Style.medium(),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  if (vM.checkOutData?.paymentMode == 'Online') ...[
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: AppColors.primarySecondThemeColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        'Online',
                        style: Text_Style.medium(color: Colors.white),
                      ),
                    ),
                  ] else if (vM.checkOutData!.paymentMode == 'TakeAway') ...[
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey)),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              vM.shippingCharges =
                                  (vM.checkOutData?.shippingCharges ?? 0).toDouble();
                              vM.selectedPaymentMethod = 'Online';
                            },
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: vM.selectedPaymentMethod == 'Online'
                                      ? AppColors.primarySecondThemeColor
                                      : AppColors.primaryThemeColor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text(
                                'Online',
                                style: Text_Style.medium(
                                    color: vM.selectedPaymentMethod == 'Online'
                                        ? Colors.white
                                        : Colors.black),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          InkWell(
                            onTap: () {
                              vM.shippingCharges = (0);
                              vM.selectedPaymentMethod = 'TakeAway';
                            },
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: vM.selectedPaymentMethod == 'TakeAway'
                                      ? AppColors.primarySecondThemeColor
                                      : AppColors.primaryThemeColor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text(
                                'TakeAway',
                                style: Text_Style.medium(
                                    color: vM.selectedPaymentMethod == 'TakeAway'
                                        ? Colors.white
                                        : Colors.black),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                  SizedBox(
                    height: 20,
                  ),
                  if (vM.selectedPaymentMethod == 'Online') onlineWidget() else takeAwayWidget(),
                ],
              ),
            ),
          );
        });
      }),
      bottomSheet: Consumer<CheckOutViewModel>(builder: (context, viewModel, child) {
        return Container(
            padding: EdgeInsets.all(8),
            color: Color(0xffFFF9EC),
            child: Row(children: [
              Text(
                '₹',
                style: Text_Style.large(color: AppColors.primarySecondThemeColor),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                (viewModel.grandTotal).toString(),
                style: Text_Style.large(color: AppColors.primarySecondThemeColor),
              ),
              Spacer(),
              Consumer<HomeViewModel>(builder: (context, homeViewModel, child) {
                return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      padding: EdgeInsets.all(8),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      backgroundColor: Color(0xffFC5D5D),
                    ),
                    onPressed: () async {
                      _customLoader.createLoader();

                      if (viewModel.selectedPaymentMethod == 'Online') {
                        await viewModel.initializePayment(
                            homeViewModel.userDetails.mobileNo ?? '',
                            homeViewModel.userDetails.email ?? '',
                            "${homeViewModel.userDetails.address ?? ''}, ${homeViewModel.userDetails.district ?? ''}, ${homeViewModel.userDetails.city ?? ''}, ${homeViewModel.userDetails.state ?? ''}, ${homeViewModel.userDetails.pincode ?? ''} ",
                            context);
                        _customLoader.dismissLoader();
                      } else {
                        await viewModel.addOrderDetails(viewModel.checkOutData
                                ?.verifiedProductsList?[0].productDto?.takeAwayAddress ??
                            "");
                        _customLoader.dismissLoader();
                        await viewModel.orderPlacedBackend(context: context);
                      }
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.shopping_cart, color: Colors.white),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          'Place Order',
                          style: Text_Style.large(color: Colors.white),
                        ),
                      ],
                    ));
              }),
            ]));
      }),
    );
  }

  Widget takeAwayWidget() {
    return Consumer<HomeViewModel>(builder: (_, viewModel, child) {
      return Consumer<CheckOutViewModel>(builder: (_, vM, child) {
        return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Text(
                  "Shipping Address",
                  style: Text_Style.medium(),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primaryThemeColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      vM.checkOutData?.verifiedProductsList?[0].productDto?.takeAwayAddress
                              .toString() ??
                          '',
                      style: Text_Style.medium(),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Text(
                  "Billing Address",
                  style: Text_Style.medium(),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primaryThemeColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      viewModel.userDetails.address ?? '',
                      style: Text_Style.medium(),
                    ),
                    SizedBox(
                      height: 8,
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
                height: 20,
              ),
              Text(
                "Order Summary",
                style: Text_Style.large(fontWeight: FontWeight.w500),
              ),
              Column(
                children: List.generate(
                  (vM.checkOutData?.verifiedProductsList ?? []).length,
                  (index) => CartProductCard(index),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Subtotal',
                          style: Text_Style.medium(),
                        ),
                        Spacer(),
                        Text(
                          '₹',
                          style: Text_Style.medium(),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          vM.TotalAmount.toString(),
                          style: Text_Style.medium(),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          'Discount',
                          style: Text_Style.medium(),
                        ),
                        Spacer(),
                        Text(
                          '₹',
                          style: Text_Style.medium(),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          vM.TotalDiscount.toString(),
                          style: Text_Style.medium(),
                          textAlign: TextAlign.right,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          'Shipping',
                          style: Text_Style.medium(),
                        ),
                        Spacer(),
                        Text(
                          '₹',
                          style: Text_Style.medium(),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          vM.shippingCharges.toString(),
                          style: Text_Style.medium(),
                          textAlign: TextAlign.right,
                        )
                      ],
                    ),
                    Divider(),
                    Row(
                      children: [
                        Text(
                          'Grand Total',
                          style: Text_Style.medium(),
                        ),
                        Spacer(),
                        Text(
                          '₹',
                          style: Text_Style.medium(),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          vM.grandTotal.toString(),
                          style: Text_Style.medium(),
                          textAlign: TextAlign.right,
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 100,
              ),
            ]);
      });
    });
  }

  Widget onlineWidget() {
    return Consumer<HomeViewModel>(builder: (_, viewModel, child) {
      return Consumer<CheckOutViewModel>(builder: (_, vM, child) {
        return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Text(
                  "Shipping Address",
                  style: Text_Style.medium(),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primaryThemeColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      viewModel.userDetails.address ?? '',
                      style: Text_Style.medium(),
                    ),
                    SizedBox(
                      height: 8,
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
                height: 20,
              ),
              Container(
                child: Text(
                  "Billing Address",
                  style: Text_Style.medium(),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primaryThemeColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      viewModel.userDetails.address ?? '',
                      style: Text_Style.medium(),
                    ),
                    SizedBox(
                      height: 8,
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
                height: 20,
              ),
              Text(
                "Order Summary",
                style: Text_Style.large(fontWeight: FontWeight.w500),
              ),
              Column(
                children: List.generate(
                  (vM.checkOutData?.verifiedProductsList ?? []).length,
                  (index) => CartProductCard(index),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Subtotal',
                          style: Text_Style.medium(),
                        ),
                        Spacer(),
                        Text(
                          '₹',
                          style: Text_Style.medium(),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          vM.TotalAmount.toString(),
                          style: Text_Style.medium(),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          'Discount',
                          style: Text_Style.medium(),
                        ),
                        Spacer(),
                        Text(
                          '₹',
                          style: Text_Style.medium(),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          vM.TotalDiscount.toString(),
                          style: Text_Style.medium(),
                          textAlign: TextAlign.right,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          'Shipping',
                          style: Text_Style.medium(),
                        ),
                        Spacer(),
                        Text(
                          '₹',
                          style: Text_Style.medium(),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          vM.shippingCharges.toString(),
                          style: Text_Style.medium(),
                          textAlign: TextAlign.right,
                        )
                      ],
                    ),
                    Divider(),
                    Row(
                      children: [
                        Text(
                          'Grand Total',
                          style: Text_Style.medium(),
                        ),
                        Spacer(),
                        Text(
                          '₹',
                          style: Text_Style.medium(),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          vM.grandTotal.toString(),
                          style: Text_Style.medium(),
                          textAlign: TextAlign.right,
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 100,
              ),
            ]);
      });
    });
  }
}

class CartProductCard extends StatefulWidget {
  CartProductCard(this.index);
  int index;
  @override
  State<CartProductCard> createState() => _CartProductCardState();
}

class _CartProductCardState extends State<CartProductCard> {
  late CustomLoader _customLoader;

  void initState() {
    super.initState();
    _customLoader = CustomLoader(context: context);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<CheckOutViewModel>(builder: (context, viewModel, child) {
      return Container(
        width: (size.width - 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: NetworkImageLoader(
                        image: viewModel.checkOutData?.verifiedProductsList?[widget.index]
                                .productDto?.productImgUrls[0] ??
                            '',
                        fit: BoxFit.fill,
                        height: 150,
                        width: (size.width - 16) * 0.4,
                        errorWidget: Image.asset(
                          'assets/not_found.jpg',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            viewModel.checkOutData?.verifiedProductsList?[widget.index].productDto
                                    ?.title ??
                                '',
                            style: Text_Style.medium(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                      color: Color(0xffFFF9EC),
                                      border: Border.all(color: AppColors.primarySecondThemeColor),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Text(
                                      "${viewModel.checkOutData?.verifiedProductsList?[widget.index].productMetaDataDto?.color ?? ''}"),
                                ),
                                Container(
                                  margin: EdgeInsets.all(8),
                                  padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                      color: Color(0xffFFF9EC),
                                      border: Border.all(
                                        color: AppColors.primarySecondThemeColor,
                                      ),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Text(
                                      "${viewModel.checkOutData?.verifiedProductsList?[widget.index].productMetaDataDto?.size ?? ''}"),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  text:
                                      '${(viewModel.checkOutData?.verifiedProductsList?[widget.index].productTotalPriceWithoutDiscount ?? 0) * (100 - (viewModel.checkOutData?.verifiedProductsList?[widget.index].productDiscount ?? 0)) / 100} ',
                                  style: Text_Style.big(color: Colors.green)),
                              TextSpan(text: 'MRP  ', style: Text_Style.small(color: Colors.grey)),
                              TextSpan(
                                text:
                                    '₹${viewModel.checkOutData?.verifiedProductsList?[widget.index].productTotalPriceWithoutDiscount ?? 0}',
                                style: TextStyle(
                                  fontSize: 16,
                                  decoration: TextDecoration.lineThrough,
                                  color: Colors.black,
                                ),
                              )
                            ]),
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Quantity : ${viewModel.checkOutData?.verifiedProductsList?[widget.index].productQuantity ?? 0}",
                            style: Text_Style.medium(),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),

                // Divider(),
              ],
            )
          ],
        ),
      );
    });
  }
}
