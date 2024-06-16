import 'package:carousel_slider/carousel_slider.dart';
import 'package:dot_com/client/screens/product/product_details_screen.dart';
import 'package:dot_com/client/view_model/product_review_model.dart';
import 'package:dot_com/components/color.dart';
import 'package:dot_com/components/custom_loader.dart';
import 'package:dot_com/components/network_image_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../auth/screen/login/login_page.dart';
import '../../../components/text_style.dart';
import '../../../constants.dart';
import '../../../utils/routes.dart';
import '../../api_model/product_details_model.dart';
import '../../view_model/home_view_model.dart';
import '../../view_model/product_details_view_model.dart';
import '../wishlist/wishlist_page.dart';

class ClientPage extends StatefulWidget {
  const ClientPage({super.key});

  @override
  State<ClientPage> createState() => _ClientPageState();
}

class _ClientPageState extends State<ClientPage> {
  late CustomLoader _customLoader;
  ScrollController _scrollController = ScrollController();
  late HomeViewModel provider;

  Future<void> _scrollListener() async {
    if (provider.isLoadingMore) return;
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      print('listener triggered');
      // _customLoader.createLoader();
      await provider.loadingMoreProductsTriggered();
      // _customLoader.dismissLoader();
    }
  }

  initialCall() async {
    await provider.initialPage();
  }

  @override
  void initState() {
    provider = Provider.of<HomeViewModel>(context, listen: false);
    super.initState();
    _customLoader = CustomLoader(context: context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initialCall();
    });

    _scrollController.addListener(_scrollListener);
  }

  @override
  Widget build(ct) {
    return Consumer<HomeViewModel>(
      builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      decoration:
                          BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(20)),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      "dot.",
                      style: Text_Style.small(color: Colors.red, fontWeight: FontWeight.w700),
                    ),
                    Text(
                      "ComSale",
                      style: Text_Style.small(color: Colors.black, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ],
            ),
            actions: [
              // IconButton(
              //   onPressed: () {
              //     // Handle search action
              //   },
              //   icon: Icon(Icons.search),
              // ),
              IconButton(
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
                  ;
                },
                icon: Icon(Icons.shopping_cart),
              ),
              IconButton(
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
                    Navigator.push(context, MaterialPageRoute(builder: (_) => WishListPage()));
                },
                icon: Icon(Icons.favorite_border),
              ),
            ],
          ),
          body: viewModel.isLoading
              ? Center(child: CircularProgressIndicator())
              : RefreshIndicator(
                  onRefresh: () => initialCall(),
                  child: SafeArea(
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          CarouselSlider(
                            options: CarouselOptions(
                              viewportFraction: 0.8,
                              aspectRatio: 16 / 6,
                              autoPlay: true,
                            ),
                            items: viewModel.advertisementsData.map((i) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return GestureDetector(
                                    onTap: () {
                                      final homeTemp =
                                          Provider.of<HomeViewModel>(context, listen: false);
                                      final temp = Provider.of<ProductDetailsViewModel>(context,
                                          listen: false);
                                      Navigator.pushNamed(context, Routes.productDetailScreen);
                                      temp.intializePage(i['productId'] ?? 0, homeTemp.loggedIn);
                                    },
                                    child: Container(
                                      margin: EdgeInsets.symmetric(horizontal: 8),
                                      child: NetworkImageLoader(
                                          image: i['bannerUrl'] ?? '',
                                          fit: BoxFit.fill,
                                          height: 150,
                                          width: double.infinity,
                                          errorWidget: Image.asset(
                                            'assets/not_found.jpg',
                                            fit: BoxFit.fill,
                                          )),
                                    ),
                                  );
                                },
                              );
                            }).toList(),
                          ),
                          categories(),
                          location(ct, viewModel),
                          SizedBox(
                            height: 10,
                          ),
                          if (viewModel.allProducts.length > 0)
                            GridView.count(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              crossAxisCount: 2,
                              childAspectRatio: 1.8 / 3,
                              children: List.generate(viewModel.allProducts.length, (index) {
                                return productCard(viewModel.allProducts[index], viewModel);
                              }),
                            )
                          else
                            Center(child: Text("No Products Found")),
                          SizedBox(
                            height: 100,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        );
      },
    );
  }

  Widget productCard(ProductDetails _data, HomeViewModel viewModel) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        final homeTemp = Provider.of<HomeViewModel>(context, listen: false);
        final temp = Provider.of<ProductDetailsViewModel>(context, listen: false);
        final temp2 = Provider.of<ProductReviewModel>(context, listen: false);
        Navigator.pushNamed(context, Routes.productDetailScreen);
        temp.intializePage((_data.id ?? 0), homeTemp.loggedIn);
        temp2.initialPage(homeTemp.loggedIn, _data.id ?? 0);
      },
      child: Container(
        padding: EdgeInsets.all(8),
        width: (size.width - 16) / 2,
        height: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                // Image
                !(_data.outOfStock ?? false)
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: NetworkImageLoader(
                            image: _data.productImgUrls.isNotEmpty ? _data.productImgUrls[0] : '',
                            fit: BoxFit.fill,
                            height: 200,
                            width: 1000,
                            errorWidget: Image.asset(
                              'assets/not_found.jpg',
                              fit: BoxFit.fill,
                            )),
                      )
                    : Stack(
                        clipBehavior: Clip.none,
                        children: [
                          // Image with blur effect
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: NetworkImageLoader(
                              image: _data.productImgUrls.isNotEmpty ? _data.productImgUrls[0] : "",
                              fit: BoxFit.fill,
                              height: 200,
                              width: 1000,
                              errorWidget: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  'assets/not_found.jpg',
                                  fit: BoxFit.fill,
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
                // Favorite Icon
                if (viewModel.loggedIn)
                  Positioned(
                    top: 10,
                    left: 10,
                    child: _data.productInWishList ?? false
                        ? GestureDetector(
                            onTap: () async {
                              setState(() {
                                _data.productInWishList = false;
                              });
                              _customLoader.createLoader();
                              await viewModel.deleteProductToWishList(_data.id!);
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
                                _data.productInWishList = true;
                              });
                              _customLoader.createLoader();
                              await viewModel.addProductToWishList(_data.id!);

                              _customLoader.dismissLoader();
                            },
                            child: Icon(
                              Icons.favorite_border,
                              color: Colors.black,
                              size: 30,
                            ),
                          ),
                  ),

                if (_data.discount != null && _data.discount != 0)
                  Positioned(
                    top: 10,
                    right: 4,
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.primarySecondThemeColor,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Text(
                        '${_data.discount}%',
                        style: Text_Style.small(color: Colors.white),
                      ),
                    ),
                  )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              _data.title ?? '',
              style: Text_Style.large(),
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(
              height: 10,
            ),
            RichText(
              text: TextSpan(children: [
                TextSpan(
                    text:
                        '${(_data.averageProductPrice ?? 0) * (100 - (_data.discount ?? 0)) / 100} ',
                    style: Text_Style.big(color: Colors.green)),
                TextSpan(text: 'MRP  ', style: Text_Style.small(color: Colors.grey)),
                TextSpan(
                  text: '₹${_data.averageProductPrice ?? 0}',
                  style: TextStyle(
                    fontSize: 16,
                    decoration: TextDecoration.lineThrough,
                    color: Colors.black,
                  ),
                )
              ]),
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
    );
  }

  Widget categories() {
    return Consumer<HomeViewModel>(
      builder: (context, viewModel, child) {
        ScrollController _scrollController = ScrollController();
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scrollController
              .jumpTo(viewModel.selectedCategory * 100.0); // Adjust the value as needed
        });

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'Categories',
                    style: Text_Style.medium(),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, Routes.CategoriesScreen);
                    },
                    child: Text("View all"),
                  ),
                ],
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                // controller: _scrollController,
                child: Row(
                  children: List.generate(
                      categories_list.length,
                      (index) => GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (ct) => ProductDetailsScreen()));
                            },
                            child: GestureDetector(
                              onTap: () {
                                viewModel.selectedCategory = index;
                                // viewModel.selectedCategory(categories_list[index]['']);
                              },
                              child: Container(
                                constraints: BoxConstraints(minHeight: 90, minWidth: 90),
                                decoration: BoxDecoration(
                                  color: Color(0xffFFF5E1),
                                  border: Border.all(
                                    color: viewModel.selectedCategory == index
                                        ? AppColors.primarySecondThemeColor
                                        : Color(0xffFFF5E1),
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                margin: EdgeInsets.only(right: 12, top: 12),
                                padding: EdgeInsets.all(8),
                                // color: Colors.red,
                                child: Column(
                                  children: [
                                    SvgPicture.asset(
                                      categories_list[index]['image'],
                                      height: 40,
                                      width: 40,
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(categories_list[index]['name'])
                                  ],
                                ),
                              ),
                            ),
                          )),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget location(context, viewModel) {
    ScrollController _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(viewModel.selectedLocation * 100.0); // Adjust the value as needed
    });
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Location',
                style: Text_Style.medium(),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, Routes.LocationScreen);
                },
                child: Text("View all"),
              ),
            ],
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            // controller: _scrollController,
            child: Row(
              children: List.generate(
                  location_list.length,
                  (index) => GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => ProductDetailsScreen()));
                        },
                        child: GestureDetector(
                          onTap: () {
                            viewModel.selectedLocation = index;
                            // viewModel.selectedCategory(categories_list[index]['']);
                          },
                          child: Container(
                            constraints: BoxConstraints(minHeight: 90, minWidth: 90),
                            decoration: BoxDecoration(
                              color: Color(0xffFFF5E1),
                              border: Border.all(
                                color: viewModel.selectedLocation == index
                                    ? AppColors.primarySecondThemeColor
                                    : Color(0xffFFF5E1),
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            margin: EdgeInsets.only(right: 12, top: 12),
                            padding: EdgeInsets.all(8),
                            // color: Colors.red,
                            child: Column(
                              children: [
                                SvgPicture.asset(
                                  location_list[index]['image'],
                                  height: 40,
                                  width: 40,
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(location_list[index]['name'])
                              ],
                            ),
                          ),
                        ),
                      )),
            ),
          ),
        ],
      ),
    );
  }
}
