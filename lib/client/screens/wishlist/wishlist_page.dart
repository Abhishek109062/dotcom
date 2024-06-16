import 'package:dot_com/components/color.dart';
import 'package:dot_com/components/custom_loader.dart';
import 'package:dot_com/components/text_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../components/network_image_loader.dart';
import '../../../utils/routes.dart';
import '../../api_model/product_details_model.dart';
import '../../view_model/home_view_model.dart';
import '../../view_model/product_details_view_model.dart';
import '../../view_model/wishlist_view_model.dart';

class WishListPage extends StatefulWidget {
  const WishListPage({super.key});

  @override
  State<WishListPage> createState() => _WishListPageState();
}

class _WishListPageState extends State<WishListPage> {
  late WishListViewModel provider;
  late CustomLoader _customLoader;
  ScrollController _scrollController = ScrollController();

  Future<void> _scrollListener() async {
    if (provider.isLoadingMore) return;
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      await provider.loadingMoreProductsTriggered();
    }
  }

  void initState() {
    super.initState();
    _customLoader = CustomLoader(context: context);

    provider = Provider.of<WishListViewModel>(context, listen: false);
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      provider.initialPage();
    });
    _scrollController.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<WishListViewModel>(builder: (context, viewModel, child) {
      return RefreshIndicator(
        onRefresh: () => provider.initialPage(),
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Wishlist',
              style: Text_Style.large(color: Colors.grey),
            ),
          ),
          body: viewModel.isLoading
              ? Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.count(
                    controller: _scrollController,
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    childAspectRatio: 1.8 / 3,
                    children: List.generate(viewModel.allProducts.length, (index) {
                      return productCard(viewModel.allProducts[index], viewModel);
                    }),
                  ),
                ),
        ),
      );
    });
  }

  Widget productCard(ProductDetails _data, WishListViewModel viewModel) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        final temp = Provider.of<ProductDetailsViewModel>(context, listen: false);
        Navigator.pushNamed(context, Routes.productDetailScreen);
        temp.intializePage(_data.id ?? 0, true);
      },
      child: Container(
        padding: EdgeInsets.all(8),
        width: (size.width - 16) / 2,
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
                            child: NetworkImageLoader(
                              image: _data.productImgUrls.isNotEmpty ? _data.productImgUrls[0] : '',
                              fit: BoxFit.fill,
                              height: 200,
                              width: 1000,
                              errorWidget: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(fit: BoxFit.fill, 'assets/product.png'),
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
                Positioned(
                    top: 10,
                    left: 10,
                    child: Icon(
                      Icons.favorite,
                      color: Colors.red,
                      size: 30,
                    )),

                if (_data.discount != null && _data.discount != 0)
                  Positioned(
                    top: 4,
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
}
