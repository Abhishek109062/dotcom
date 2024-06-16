import 'package:accordion/accordion.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dot_com/components/color.dart';
import 'package:dot_com/components/customsnackbar.dart';
import 'package:dot_com/components/network_image_loader.dart';
import 'package:dot_com/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../auth/screen/login/login_page.dart';
import '../../../components/custom_loader.dart';
import '../../../components/text_style.dart';
import '../../view_model/home_view_model.dart';
import '../../view_model/product_details_view_model.dart';
import '../../view_model/product_review_model.dart';
import '../home/client_home_page.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  late CustomLoader _customLoader;
  @override
  void initState() {
    super.initState();
    _customLoader = CustomLoader(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductDetailsViewModel>(builder: (context, viewModel, child) {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              viewModel.productInfo?.productDto.title ?? '',
              style: Text_Style.large(color: Colors.grey),
            ),
            actions: [
              // SearchAnchor(builder: (BuildContext context, SearchController controller) {
              //   return SearchBar(
              //     hintText: 'Overload hoodie 3',
              //     elevation: MaterialStateProperty.all(0),
              //     backgroundColor: MaterialStateProperty.all(Colors.white),
              //     constraints: BoxConstraints(maxHeight: 30, maxWidth: 300),
              //     controller: controller,
              //     padding: const MaterialStatePropertyAll<EdgeInsets>(
              //         EdgeInsets.symmetric(horizontal: 16.0)),
              //     onTap: () {
              //       controller.openView();
              //     },
              //     onChanged: (_) {
              //       controller.openView();
              //     },
              //     trailing: [Icon(Icons.search)],
              //   );
              // }, suggestionsBuilder: (BuildContext context, SearchController controller) {
              //   return List<ListTile>.generate(5, (int index) {
              //     final String item = 'item $index';
              //     return ListTile(
              //       title: Text(item),
              //       onTap: () {
              //         setState(() {
              //           controller.closeView(item);
              //         });
              //       },
              //     );
              //   });
              // }),
              // IconButton(
              //   onPressed: () {
              //     // Handle search action
              //   },
              //   icon: Icon(Icons.search),
              // ),

              Consumer<HomeViewModel>(builder: (context, viewModel, child) {
                return IconButton(
                  onPressed: () {
                    if (!viewModel.loggedIn)
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
                  },
                  icon: Icon(Icons.shopping_cart),
                );
              }),
              // IconButton(
              //   onPressed: () {
              //     // Handle favorite action
              //   },
              //   icon: Icon(Icons.favorite_border),
              // ),
            ],
          ),
          body: viewModel.isLoading
              ? Center(child: CircularProgressIndicator())
              : Container(
                  color: Colors.white,
                  child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CarouselSlider(
                            items: (viewModel.selectedProduct?.productImgUrls ?? [])
                                .map((item) => Container(
                                      margin: EdgeInsets.all(5.0),
                                      child: ClipRRect(
                                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                          child: Stack(
                                            children: <Widget>[
                                              NetworkImageLoader(
                                                  image: item,
                                                  fit: BoxFit.fill,
                                                  height: 400,
                                                  width: double.infinity,
                                                  errorWidget: Image.asset('assets/not_found.jpg')),
                                            ],
                                          )),
                                    ))
                                .toList(),
                            carouselController: _controller,
                            options: CarouselOptions(
                                height: 400,
                                autoPlay: false,
                                enlargeCenterPage: true,
                                aspectRatio: 2.0,
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    _current = index;
                                  });
                                }),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: (viewModel.selectedProduct?.productImgUrls ?? [])
                                .asMap()
                                .entries
                                .map((entry) {
                              return GestureDetector(
                                onTap: () => _controller.animateToPage(entry.key),
                                child: Container(
                                  width: 8.0,
                                  height: 8.0,
                                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: (_current == entry.key
                                        ? Color(0xffFC5D5D)
                                        : Color(0xffD9D9D9)),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              viewModel.productInfo?.productDto.title ?? '',
                              style: Text_Style.large(fontWeight: FontWeight.w600),
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Row(
                              children: [
                                RatingBarIndicator(
                                  rating: viewModel.productInfo?.productDto.rating ?? 0,
                                  unratedColor: Colors.amberAccent.withOpacity(0.4),
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  itemCount: 5,
                                  itemSize: 20.0,
                                  direction: Axis.horizontal,
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Text(viewModel.productInfo?.productDto.rating.toString() ?? ''),
                                // Text(' (100)'),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                      text:
                                          '${(viewModel.selectedProduct?.price ?? 0) * (100 - (viewModel.productInfo?.productDto.discount ?? 0)) / 100} ',
                                      style: Text_Style.big(color: Colors.green)),
                                  TextSpan(
                                      text: 'MRP  ', style: Text_Style.small(color: Colors.grey)),
                                  TextSpan(
                                    text: '₹${viewModel.selectedProduct?.price ?? 0}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      decoration: TextDecoration.lineThrough,
                                      color: Colors.black,
                                    ),
                                  )
                                ]),
                                overflow: TextOverflow.ellipsis,
                              )),
                          // SizedBox(
                          //   height: 12,
                          // ),
                          // Padding(
                          //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          //   child: Text(
                          //     'Discounts',
                          //     style: Text_Style.medium(),
                          //   ),
                          // ),
                          SizedBox(
                            height: 12,
                          ),
                          // Container(
                          //   margin: EdgeInsets.only(left: 8),
                          //   padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          //   decoration: BoxDecoration(
                          //       borderRadius: BorderRadius.circular(20),
                          //       border: Border.all(
                          //         color: Color(0xffFC5D5D),
                          //       )),
                          //   child: Text(
                          //     'Get ${viewModel.productInfo?.productDto.discount ?? ''}% off on first Order',
                          //     style: Text_Style.medium(),
                          //   ),
                          // ),
                          if ((viewModel.selectedProduct?.color ?? '') != '') ...[
                            SizedBox(
                              height: 4,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(
                                    'Color',
                                    style: Text_Style.medium(),
                                  ),
                                  Spacer(),
                                  // Text(
                                  //   'Size Chart',
                                  //   style: Text_Style.medium(),
                                  // )
                                ],
                              ),
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: List.generate(
                                    viewModel.color.length,
                                    (index) => GestureDetector(
                                          onTap: () {
                                            viewModel.selectedColor = viewModel.color[index];
                                          },
                                          child: Container(
                                            margin: EdgeInsets.all(8),
                                            padding: EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                                color: Color(0xffFFF9EC),
                                                border: Border.all(
                                                  color: viewModel.selectedProduct?.color ==
                                                          viewModel.color[index]
                                                      ? AppColors.primarySecondThemeColor
                                                      : Color(0xffFFF9EC),
                                                ),
                                                borderRadius: BorderRadius.circular(10)),
                                            child: Text("${viewModel.color[index]}"),
                                          ),
                                        )),
                              ),
                            ),
                          ],
                          SizedBox(
                            height: 4,
                          ),
                          if (viewModel.selectedProduct?.color != '') ...[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(
                                    'Size',
                                    style: Text_Style.medium(),
                                  ),
                                  Spacer(),
                                  // Text(
                                  //   'Size Chart',
                                  //   style: Text_Style.medium(),
                                  // )
                                ],
                              ),
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: List.generate(
                                    viewModel.colorToSize[viewModel.selectedProduct?.color]?.keys
                                            .toList()
                                            .length ??
                                        0, (index) {
                                  String title = viewModel
                                          .colorToSize[viewModel.selectedProduct?.color]?.keys
                                          .toList()[index] ??
                                      '';
                                  return GestureDetector(
                                    onTap: () {
                                      viewModel.selectedSize = title;
                                    },
                                    child: Container(
                                      margin: EdgeInsets.all(8),
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          color: Color(0xffFFF9EC),
                                          border: Border.all(
                                            color: viewModel.selectedProduct?.size == title
                                                ? AppColors.primarySecondThemeColor
                                                : Color(0xffFFF9EC),
                                          ),
                                          borderRadius: BorderRadius.circular(10)),
                                      child: Text(title),
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ],

                          SizedBox(
                            height: 8,
                          ),
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: Accordion(
                              disableScrolling: true,
                              paddingBetweenOpenSections: 0,
                              paddingListBottom: 0,
                              paddingListHorizontal: 0,
                              paddingListTop: 0,
                              headerBackgroundColor: Colors.white,
                              paddingBetweenClosedSections: 0,
                              contentBorderWidth: 0,
                              children: [
                                AccordionSection(
                                  leftIcon: SvgPicture.asset(
                                    height: 25,
                                    width: 25,
                                    'assets/product_descrption.svg',
                                    color: Color(0xffFC5D5D),
                                  ),
                                  rightIcon: Icon(
                                    Icons.arrow_drop_down,
                                    size: 25,
                                  ),
                                  header: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Product Description',
                                        style: Text_Style.big(),
                                      ),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Text("Manufacture, care and fit")
                                    ],
                                  ),
                                  content:
                                      Text(viewModel.productInfo?.productDto.description ?? ''),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: Accordion(
                              disableScrolling: true,
                              paddingBetweenOpenSections: 0,
                              paddingListBottom: 0,
                              paddingListHorizontal: 0,
                              paddingListTop: 0,
                              headerBackgroundColor: Colors.white,
                              paddingBetweenClosedSections: 0,
                              contentBorderWidth: 0,
                              children: [
                                AccordionSection(
                                    leftIcon: SvgPicture.asset(
                                      height: 25,
                                      width: 25,
                                      'assets/review_product.svg',
                                      color: Color(0xffFC5D5D),
                                    ),
                                    rightIcon: Icon(
                                      Icons.arrow_drop_down,
                                      size: 25,
                                    ),
                                    header: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Reviews',
                                          style: Text_Style.big(),
                                        ),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Text("Know how other customer felt after buying")
                                      ],
                                    ),
                                    content: Container(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          // Consumer<ProductReviewModel>(
                                          //     builder: (context, productViewModel, child) {
                                          //   return Row(
                                          //     mainAxisAlignment: MainAxisAlignment.center,
                                          //     children: [
                                          //       Image.asset('assets/Star.png'),
                                          //       SizedBox(
                                          //         width: 2,
                                          //       ),
                                          //       Text(
                                          //           '${productViewModel.productReviewRatingData?.averageRating ?? 0}',
                                          //           style: Text_Style.large()),
                                          //       SizedBox(
                                          //         width: 4,
                                          //       ),
                                          //       Expanded(
                                          //         child: Text(
                                          //             "${productViewModel.productReviewRatingData?.totalReviewsCount ?? 0} happy customers rated this"),
                                          //       ),
                                          //     ],
                                          //   );
                                          // }),
                                          SizedBox(
                                            height: 12,
                                          ),
                                          Consumer<HomeViewModel>(
                                              builder: (context, homeViewModel, child) {
                                            return Consumer<ProductReviewModel>(
                                                builder: (context, productViewModel, child) {
                                              return ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  elevation: 0,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(12)),
                                                  backgroundColor: Color(0xffFFF9EC),
                                                ),
                                                onPressed: () {
                                                  // productViewModel.initialPage(
                                                  //     homeViewModel.loggedIn,
                                                  //     viewModel.productInfo!.productDto.id);
                                                  Navigator.pushNamed(
                                                      context, Routes.productReviewScreen);
                                                  // Navigator.push(
                                                  //     context,
                                                  //     MaterialPageRoute(
                                                  //         builder: (context) => ClientPage()));
                                                },
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      'See all reviews',
                                                      style: Text_Style.small(
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            });
                                          }),
                                        ],
                                      ),
                                    ))
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 80,
                          ),
                        ]),
                  ),
                ),
          bottomSheet: Consumer<HomeViewModel>(builder: (context, vM, child) {
            return vM.loggedIn
                ? Container(
                    height: 60,
                    color: Color(0xffFFF9EC),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 8,
                        ),
                        viewModel.productInfo?.productDto.productInWishList ?? false
                            ? GestureDetector(
                                onTap: () async {
                                  setState(() {
                                    viewModel.productInfo?.productDto.productInWishList = false;
                                  });
                                  _customLoader.createLoader();
                                  await vM.deleteProductToWishList(
                                      viewModel.productInfo!.productDto.id);
                                  _customLoader.dismissLoader();
                                },
                                child: Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                  size: 30,
                                ),
                              )
                            : GestureDetector(
                                onTap: () async {
                                  setState(() {
                                    viewModel.productInfo?.productDto.productInWishList = true;
                                  });
                                  _customLoader.createLoader();
                                  await vM
                                      .addProductToWishList(viewModel.productInfo!.productDto.id);
                                  _customLoader.dismissLoader();
                                },
                                child: Icon(
                                  Icons.favorite_border,
                                  color: Colors.black,
                                  size: 30,
                                ),
                              ),
                        Spacer(),
                        Consumer<ProductDetailsViewModel>(
                            builder: (context, productDetailViewModel, child) {
                          return Container(
                              margin: EdgeInsets.only(right: 16),
                              child: (productDetailViewModel.selectedProduct?.quantity ?? 0) == 0
                                  ? ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        padding: EdgeInsets.symmetric(horizontal: 8),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(12)),
                                        backgroundColor: Color(0xffFC5D5D),
                                      ),
                                      onPressed: () async {},
                                      child: Text(
                                        'Out Of Stock',
                                        style: Text_Style.medium(color: Colors.white),
                                      ))
                                  : ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        padding: EdgeInsets.symmetric(horizontal: 8),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(12)),
                                        backgroundColor: Color(0xffFC5D5D),
                                      ),
                                      onPressed: () async {
                                        // successSnackBar();
                                        if (viewModel.productInfo?.productDto.productInCart ??
                                            false) {
                                          setState(() {});
                                          // _customLoader.createLoader();
                                          // await viewModel.addProductToCart(
                                          //     viewModel.productInfo!.productDto.id,
                                          //     viewModel.selectedProduct!.id,
                                          //     1);
                                          // _customLoader.dismissLoader();
                                          Navigator.pushNamed(context, Routes.cartScreen);
                                        } else {
                                          _customLoader.createLoader();
                                          await viewModel.addProductToCart(
                                            viewModel.productInfo!.productDto.id,
                                            viewModel.selectedProduct!.id,
                                            1,
                                          );
                                          _customLoader.dismissLoader();
                                        }
                                      },
                                      child: Row(
                                        children: [
                                          Icon(Icons.add_shopping_cart_outlined,
                                              color: Colors.white),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Text(
                                            (viewModel.productInfo?.productDto.productInCart ??
                                                    false)
                                                ? 'Go To Cart'
                                                : 'Add To Cart',
                                            style: Text_Style.medium(color: Colors.white),
                                          ),
                                          SizedBox(
                                            width: 8,
                                          )
                                        ],
                                      )));
                        }),
                      ],
                    ),
                  )
                : SizedBox();
          }));
    });
  }
}
