import 'dart:ui';

import 'package:dot_com/components/custom_loader.dart';
import 'package:dot_com/components/customsnackbar.dart';
import 'package:dot_com/components/increment_decrement_widget.dart';
import 'package:dot_com/components/text_style.dart';
import 'package:dot_com/components/toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../components/color.dart';
import '../../../components/network_image_loader.dart';
import '../../../utils/routes.dart';
import '../../view_model/Cart_view_model.dart';
import '../../view_model/checkout_view_model.dart';
import '../../view_model/product_details_view_model.dart';

class CartScreen extends StatefulWidget {
  CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  ScrollController _scrollController = ScrollController();
  late CartViewModel provider;
  late CustomLoader _customLoader;
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
    print('Page alunced');
    _customLoader = CustomLoader(context: context);
    _scrollController.addListener(_scrollListener);

    provider = Provider.of<CartViewModel>(context, listen: false);

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      provider.initialPage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cart',
          style: Text_Style.large(color: Colors.grey),
        ),
        actions: [],
      ),
      body: Consumer<CartViewModel>(builder: (context, viewModel, child) {
        return viewModel.isLoading
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your Cart',
                        style: Text_Style.large(),
                      ),
                      // CartProductCard(0)
                      if (viewModel.cartData.isNotEmpty) ...[
                        Column(
                          children: List.generate(
                            viewModel.cartData.length,
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
                              Text(
                                'Order Summary',
                                style: Text_Style.large(),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Subtotal',
                                    style: Text_Style.medium(),
                                  ),
                                  Spacer(),
                                  Text('₹'),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    viewModel.TotalAmount.toString(),
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
                                  ),
                                  Spacer(),
                                  Text('₹'),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    viewModel.TotalDiscount.toString(),
                                    style: Text_Style.medium(),
                                    textAlign: TextAlign.right,
                                  )
                                ],
                              ),
                            ],
                          ),
                        )
                      ] else ...[
                        Center(
                            child: Container(
                                height: 300,
                                child: Text(
                                  'No Products Added',
                                  style: Text_Style.big(),
                                ))),
                      ],
                      SizedBox(
                        height: 100,
                      ),
                    ],
                  ),
                ),
              );
      }),
      bottomSheet: Consumer<CartViewModel>(builder: (context, viewModel, child) {
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
                (viewModel.TotalAmount - viewModel.TotalDiscount).toString(),
                style: Text_Style.large(color: AppColors.primarySecondThemeColor),
              ),
              Spacer(),
              Consumer<CheckOutViewModel>(builder: (context, vM, child) {
                return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      padding: EdgeInsets.all(8),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      backgroundColor: Color(0xffFC5D5D),
                    ),
                    onPressed: () async {
                      if (!viewModel.outOfStockProduct) {
                        if (viewModel.cartData.isNotEmpty) {
                          _customLoader.createLoader();
                          List<dynamic>? temp = await viewModel.getVerifyOrderRequestData();
                          if (await vM.verifyOrderPrice({
                            "orderProductDtoList": temp,
                          })) {
                            _customLoader.dismissLoader();

                            Navigator.pushNamed(context, Routes.checkoutScreen);
                          }
                          ;
                        }
                      } else
                        errorSnackBar(msg: "Out of stock Product added");
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.shopping_cart, color: Colors.white),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          'Check Out',
                          style: Text_Style.large(color: Colors.white),
                        ),
                      ],
                    ));
              }),
            ]));
      }),
    );
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
    return Consumer<CartViewModel>(builder: (context, viewModel, child) {
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
                    Stack(
                      children: [
                        !((viewModel.cartData[widget.index].productMetaData?.quantity ?? 0) == 0)
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: NetworkImageLoader(
                                  image: viewModel
                                          .cartData[widget.index].product?.productImgUrls?[0] ??
                                      '',
                                  fit: BoxFit.fill,
                                  height: 150,
                                  width: (size.width - 16) * 0.4,
                                  errorWidget: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.asset(
                                      'assets/not_found.jpg',
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ))
                            : Stack(
                                children: [
                                  // Image with blur effect
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: ImageFiltered(
                                      imageFilter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                                      child: NetworkImageLoader(
                                        image: viewModel.cartData[widget.index].product
                                                ?.productImgUrls?[0] ??
                                            '',
                                        fit: BoxFit.fill,
                                        height: 150,
                                        width: (size.width - 16) * 0.4,
                                        errorWidget: ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: Image.asset(
                                            'assets/product.png',
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                  // Blurred overlay
                                  Container(
                                    height: 200,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white.withOpacity(0.5),
                                    ),
                                  ),
                                  // Out of stock label
                                  Positioned.fill(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Out of Stock',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                        // ClipRRect(
                        //   borderRadius: BorderRadius.circular(10),
                        //   child: NetworkImageLoader(
                        //     image:
                        //         viewModel.cartData[widget.index].product?.productImgUrls?[0] ?? '',
                        //     fit: BoxFit.fill,
                        //     height: 150,
                        //     width: (size.width - 16) * 0.4,
                        //     errorWidget: Image.asset(
                        //       'assets/not_found.jpg',
                        //       fit: BoxFit.fill,
                        //     ),
                        //   ),
                        // ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: Consumer<ProductDetailsViewModel>(builder: (context, vM, child) {
                            return GestureDetector(
                              onTap: () async {
                                _customLoader.createLoader();
                                await vM.deleteProductToCart(
                                    viewModel.cartData[widget.index].product?.id ?? 0,
                                    viewModel.cartData[widget.index].productMetaData?.id ?? 0);
                                await viewModel.initialPage();
                                _customLoader.dismissLoader();
                              },
                              child: Container(
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                    color: AppColors.primarySecondThemeColor,
                                    borderRadius: BorderRadius.circular(30)),
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ),
                            );
                          }),
                        ),
                      ],
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
                            viewModel.cartData[widget.index].product?.title ?? '',
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
                                      "${viewModel.cartData[widget.index].productMetaData?.color ?? ''}"),
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
                                      "${viewModel.cartData[widget.index].productMetaData?.size ?? ''}"),
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
                                      '${(viewModel.cartData[widget.index].productMetaData?.price ?? 0) * (100 - (viewModel.cartData[widget.index].product?.discount ?? 0)) / 100} ',
                                  style: Text_Style.big(color: Colors.green)),
                              TextSpan(text: 'MRP  ', style: Text_Style.small(color: Colors.grey)),
                              TextSpan(
                                text:
                                    '₹${viewModel.cartData[widget.index].productMetaData?.price ?? 0}',
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
                          Consumer<ProductDetailsViewModel>(builder: (context, vM, child) {
                            return IncrementDecrementWidget(
                              initialValue: viewModel.cartData[widget.index].quantity ?? 0,
                              minValue: 1,
                              maxValue:
                                  viewModel.cartData[widget.index].productMetaData?.quantity ?? 0,
                              onChanged: (value) async {
                                _customLoader.createLoader();
                                viewModel.updateQuantity(widget.index, value);
                                await vM.addProductToCart(
                                    viewModel.cartData[widget.index].product!.id,
                                    viewModel.cartData[widget.index].productMetaData!.id ?? 0,
                                    viewModel.cartData[widget.index].quantity);
                                await viewModel.initialPage();
                                _customLoader.dismissLoader();
                              },
                            );
                          }),
                          // SizedBox(
                          //   height: 8,
                          // ),
                          // Consumer<ProductDetailsViewModel>(builder: (context, vM, child) {
                          //   return ElevatedButton(
                          //       style: ElevatedButton.styleFrom(
                          //         elevation: 0,
                          //         padding: EdgeInsets.symmetric(horizontal: 4, vertical: 0),
                          //         shape: RoundedRectangleBorder(
                          //             borderRadius: BorderRadius.circular(5)),
                          //         backgroundColor: Color(0xffFC5D5D),
                          //       ),
                          //       onPressed: () async {
                          //         _customLoader.createLoader();
                          //         await vM.deleteProductToCart(
                          //             viewModel.cartData[widget.index].product?.id ?? 0,
                          //             viewModel.cartData[widget.index].productMetaData?.id ?? 0);
                          //         await viewModel.initialPage();
                          //         _customLoader.dismissLoader();
                          //       },
                          //       child: Text(
                          //         'Remove',
                          //         style: Text_Style.small(color: Colors.white),
                          //       ));
                          // }),
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
