import 'package:dot_com/components/color.dart';
import 'package:dot_com/components/network_image_loader.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../../../components/text_style.dart';
import '../../../utils/routes.dart';
import '../../api_model/product_review_model.dart';
import '../../view_model/home_view_model.dart';
import '../../view_model/product_details_view_model.dart';
import '../../view_model/product_review_model.dart';
import 'package:intl/intl.dart';

class ProductReviewScreen extends StatefulWidget {
  const ProductReviewScreen({super.key});

  @override
  State<ProductReviewScreen> createState() => _ProductReviewScreenState();
}

class _ProductReviewScreenState extends State<ProductReviewScreen> {
  ScrollController _scrollController = ScrollController();
  late ProductReviewModel provider;

  Future<void> _scrollListener() async {
    if (provider.isLoadingMore) return;
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      print('listener triggered');
      // _customLoader.createLoader();
      await provider.loadingMoreProductsTriggered();
      // _customLoader.dismissLoader();
    }
  }

  void initState() {
    super.initState();
    provider = Provider.of<ProductReviewModel>(context, listen: false);
    _scrollController.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductDetailsViewModel>(
      builder: (context, productviewModel, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              productviewModel.productInfo?.productDto.title ?? '',
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
          body: Consumer<ProductReviewModel>(
            builder: (context, productReviewModel, child) {
              return productviewModel.isLoading
                  ? Center(child: CircularProgressIndicator())
                  : Container(
                      padding: EdgeInsets.all(16),
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Customer Reviews',
                              style: Text_Style.large(),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating:
                                      productReviewModel.productReviewRatingData?.averageRating ??
                                          0,
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
                                Text(
                                  "${(productReviewModel.productReviewRatingData?.averageRating ?? 0).toStringAsFixed(1)} / 5",
                                  style: Text_Style.medium(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                // Text(' (100)'),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(16),
                              margin: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${productReviewModel.productReviewRatingData?.totalReviewsCount ?? 0} reviews",
                                    style: Text_Style.medium(),
                                  ),
                                  ratingMeter(
                                      "5 ",
                                      productReviewModel
                                          .productReviewRatingData?.fiveStarPercentage),
                                  ratingMeter(
                                      "4 ",
                                      productReviewModel
                                          .productReviewRatingData?.fourStarPercentage),
                                  ratingMeter(
                                      "3 ",
                                      productReviewModel
                                          .productReviewRatingData?.threeStarPercentage),
                                  ratingMeter(
                                      "2 ",
                                      productReviewModel
                                          .productReviewRatingData?.twoStarPercentage),
                                  ratingMeter(
                                      "1 ",
                                      productReviewModel
                                          .productReviewRatingData?.oneStarPercentage),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            DropdownButtonHideUnderline(
                              child: DropdownButton2<String>(
                                customButton: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 16),
                                    height: 40,
                                    width: 140,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Colors.black.withOpacity(0.4), width: 2),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          productReviewModel.reviewFilter ?? '',
                                          style: TextStyle(fontSize: 13),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Spacer(),
                                        Icon(Icons.keyboard_arrow_down)
                                      ],
                                    )),
                                isExpanded: true,
                                items: ['Top Reviews', 'Latest']
                                    .map((String item) => DropdownMenuItem<String>(
                                          value: item,
                                          child: Text(
                                            item,
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ))
                                    .toList(),
                                value: productReviewModel.reviewFilter,
                                onChanged: (String? value) {
                                  setState(() {
                                    productReviewModel.reviewFilter = value!;
                                    productReviewModel.reviewFilterApplied();
                                  });
                                },
                                dropdownStyleData: DropdownStyleData(
                                  maxHeight: 200,
                                ),
                                menuItemStyleData: MenuItemStyleData(
                                    height: 40,
                                    selectedMenuItemBuilder: (context, child) {
                                      return Container(
                                          decoration: BoxDecoration(
                                              color: AppColors.primarySecondThemeColor
                                                  .withOpacity(0.08),
                                              border: Border(
                                                  left: BorderSide(
                                                      width: 4,
                                                      color: AppColors.primarySecondThemeColor))),
                                          child: child);
                                    }),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Column(
                              children: List.generate(
                                  productReviewModel?.productReviewData.length ?? 0,
                                  (index) => Column(
                                        children: [
                                          userRatingCard(
                                              productReviewModel!.productReviewData[index]),
                                        ],
                                      )),
                            )
                          ],
                        ),
                      ),
                    );
            },
          ),
        );
      },
    );
  }

  Widget ratingMeter(String star, double? rating) {
    double percentage = (rating ?? 0) / 100; // 35%

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(star),
          Icon(
            size: 15,
            Icons.star_outlined,
            color: Colors.black,
          ),
          SizedBox(
            width: 4,
          ),
          Expanded(
            child: Stack(
              children: [
                Container(
                  height: 10,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: percentage,
                  child: Container(
                    height: 10,
                    decoration: BoxDecoration(
                      color: AppColors.primarySecondThemeColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
              width: 40,
              child: Text(
                '${(percentage * 100).toInt()}%',
                style: TextStyle(),
                textAlign: TextAlign.right,
              ))
        ],
      ),
    );
  }

  Widget userRatingCard(ProductReviewResponseModel data) {
    final int createdAtMilliseconds = data.createdAt ?? 0;
    final DateTime createdAtDate = DateTime.fromMillisecondsSinceEpoch(createdAtMilliseconds);
    final String formattedDate = DateFormat('MMM d, yyyy').format(createdAtDate);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: NetworkImageLoader(
                    image: data.reviewerImgUrl ?? '',
                    fit: BoxFit.fill,
                    height: 50,
                    width: 50,
                    errorWidget: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.asset('assets/person.jpg'))),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                  child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${data.reviewerName ?? ''}",
                      style: Text_Style.small(fontWeight: FontWeight.w600),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      formattedDate,
                      style: Text_Style.small(),
                    )
                  ],
                ),
              )),
              SizedBox(
                width: 10,
              ),
              RatingBarIndicator(
                rating: double.parse((data.rating ?? 0).toStringAsFixed(0)),
                itemBuilder: (context, index) => Icon(
                  Icons.star,
                ),
                itemCount: 5,
                itemSize: 20.0,
                direction: Axis.horizontal,
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Text(data.feedbackMessage ?? ''),
          SizedBox(
            height: 20,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                  20,
                  (index) => Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: NetworkImageLoader(
                              image: "https://picsum.photos/200/300",
                              fit: BoxFit.fill,
                              height: 100,
                              width: 80,
                              errorWidget: Container()),
                        ),
                      )),
            ),
          )
        ],
      ),
    );
  }
}
