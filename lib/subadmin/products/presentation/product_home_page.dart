import 'package:chips_choice/chips_choice.dart';
import 'package:dot_com/subadmin/products/presentation/add_product.dart';
import 'package:dot_com/subadmin/products/presentation/update_product_page.dart';
import 'package:dot_com/subadmin/products/repository/add_product_model.dart';
import 'package:dot_com/subadmin/products/repository/product_model_subadmin.dart';
import 'package:dot_com/subadmin/products/viewModel/product_home_viewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../components/text_style.dart';
import '../../home/viewModel/user_subadmin_viewModel.dart';

class ProductHomePage extends StatefulWidget {
  static Route<bool> route() => MaterialPageRoute<bool>(
      builder: (_) => ChangeNotifierProvider(
            create: (BuildContext context) => ProductHomeViewModel(),
            child: ProductHomePage(),
          ));
  const ProductHomePage({super.key});

  @override
  State<ProductHomePage> createState() => _ProductHomePageState();
}

class _ProductHomePageState extends State<ProductHomePage> {
  TextEditingController searchController = TextEditingController();
  FocusNode searchFocus = FocusNode();
  ScrollController _scrollController = ScrollController();
  int tag = 3;
  // list of string options
  List<String> options = ["OK"];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Provider.of<ProductHomeViewModel>(context, listen: false).getAllProducts();
      _scrollController.addListener(() => Provider.of<ProductHomeViewModel>(context, listen: false)
          .scrollListener(_scrollController));
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            Consumer<UserSubAdminViewModel>(
              builder: (context, provider, child) {
                return Row(
                  children: [
                    Text(
                      provider.user?.name ?? "",
                      style: Text_Style.large(
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                          overflow: TextOverflow.ellipsis),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Container(
                      height:30,
                      width: 30,
                      padding: EdgeInsets.all(1),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border:
                          Border.all(color: Color(0xFFEE4540), width: 1)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(provider.user?.profilePicUrl ?? "",fit: BoxFit.fill,errorBuilder: (_,__,___){
                          return Icon(
                            Icons.person,
                            color: Color(0xFFEE4540),
                          );
                        },),
                      ),
                    )
                  ],
                );
              },
            )
          ],
        ),
        actions: [],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    GestureDetector(
                      child: Icon(
                        Icons.arrow_back,
                        weight: 500,
                        size: 24,
                      ),
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      "Products",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Color(0xFFf4f6f9), borderRadius: BorderRadius.circular(10)),
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
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Consumer<ProductHomeViewModel>(
                  builder: (context, provider, child) {
                    return Column(
                      children: [
                        Flex(
                          direction: Axis.horizontal,
                          // mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              flex: 8,
                              child: options.isNotEmpty
                                  ? ChipsChoice<int>.single(
                                      value: tag,
                                      onChanged: (val) => setState(() => tag = val),
                                      choiceItems: C2Choice.listFrom<int, String>(
                                        source: options,
                                        value: (i, v) => i,
                                        label: (i, v) => v,
                                        tooltip: (i, v) => v,
                                        delete: (i, v) => () {
                                          // clearFilter();
                                        },
                                      ),
                                      choiceStyle: C2ChipStyle.toned(
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(18),
                                          ),
                                          backgroundColor: Color(0xffDC143C),
                                          backgroundOpacity: 1),
                                      // leading: IconButton(
                                      //   tooltip: 'Add Choice',
                                      //   icon: const Icon(Icons.add_box_rounded),
                                      //   onPressed: () => setState(
                                      //         () => options.add('Opt #${options.length + 1}'),
                                      //   ),
                                      // ),
                                      // trailing: IconButton(
                                      //   tooltip: 'Remove Choice',
                                      //   icon: const Icon(Icons.remove_circle),
                                      //   onPressed: () => setState(() => options.removeLast()),
                                      // ),
                                      wrapped: false,
                                    )
                                  : Container(),
                            ),
                            Flexible(
                                flex: 3,
                                child: GestureDetector(
                                  onTap: () {
                                    // _showBottomSheet();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                    child: Row(
                                      children: [
                                        SvgPicture.asset("assets/filtericon.svg"),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          "Filters",
                                          style: Text_Style.medium(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ))
                          ],
                        ),
                        GridView.count(
                          physics: ScrollPhysics(),
                          shrinkWrap: true,
                          crossAxisCount: MediaQuery.of(context).size.width < 480 ? 2 : 4,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 4 / 5.5,
                          padding: EdgeInsets.all(16),
                          children: List.generate(provider.products.length,
                              (index) => productCard(provider.products[index])),
                        ),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(
                height: 80,
              )
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(0)),
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
                child: TextButton(
                    onPressed: () async {
                      Navigator.push(context, AddProductPage.route());
                    },
                    style: TextButton.styleFrom(
                        maximumSize: Size.fromHeight(44),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                        backgroundColor: Color(0xffFC5D5D)),
                    child: Text(
                      "Add Product",
                      style: Text_Style.medium(fontWeight: FontWeight.w500, color: Colors.white),
                    )))
          ],
        ),
      ),
    );
  }

  Widget productCard(ProductDetails product) {
    return GestureDetector(
      onTap: () async {
        bool res =
            await Navigator.push(context, UpdateProductPage.route(productId: product.id)) ?? false;
        if (res) {
          Provider.of<ProductHomeViewModel>(context, listen: false).resetPage();
          Provider.of<ProductHomeViewModel>(context, listen: false).getAllProducts();
        }
      },
      child: Column(
        children: [
          Stack(
            children: [
              AspectRatio(
                aspectRatio: 4 / 4.5,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    child: Image.network(
                      product.productImgUrls.isNotEmpty ? product.productImgUrls.first : "",
                      fit: BoxFit.fitWidth,
                      errorBuilder: (_, __, ___) {
                        return Image.asset("assets/not_found.jpg");
                      },
                    ),
                    // child:,
                  ),
                ),
              )
            ],
          ),
          Expanded(
            child: Container(
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    product.title,
                    overflow: TextOverflow.ellipsis,
                  )),
            ),
          )
        ],
      ),
    );
  }

  // Widget productCard() {
  //   Size size = MediaQuery.of(context).size;
  //   return GestureDetector(
  //     onTap: () {
  //     },
  //     child: Container(
  //       padding: EdgeInsets.all(8),
  //       width: (size.width - 16) / 2,
  //       height: 200,
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Stack(
  //             children: [
  //               // Image
  //               !(true)
  //                   ? ClipRRect(
  //                 borderRadius: BorderRadius.circular(10),
  //                 child: Container(
  //                     height: 200,
  //                     width: 1000,
  //                     child: Image.asset(
  //                       'assets/not_found.jpg',
  //                       fit: BoxFit.fill,
  //                     )),
  //               )
  //                   : Stack(
  //                 clipBehavior: Clip.none,
  //                 children: [
  //                   // Image with blur effect
  //                   ClipRRect(
  //                     borderRadius: BorderRadius.circular(10),
  //                     child:  Container(
  //                         height: 200,
  //                         width: 1000,
  //                         child: Image.network(
  //                           'https://picsum.photos/400/450',
  //                           fit: BoxFit.fill,
  //                         )),
  //                   ),
  //                   // Blurred overlay
  //                   Container(
  //                     height: 200,
  //                     decoration: BoxDecoration(
  //                       borderRadius: BorderRadius.circular(10),
  //                       color: Colors.white.withOpacity(0.5),
  //                     ),
  //                   ),
  //                   // Out of stock label
  //                   Positioned.fill(
  //                     child: Align(
  //                       alignment: Alignment.center,
  //                       child: Text(
  //                         'Out of Stock',
  //                         style: TextStyle(
  //                           color: Colors.black,
  //                           fontWeight: FontWeight.w700,
  //                           fontSize: 20,
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               // Favorite Icon
  //               if (true)
  //                 Positioned(
  //                   top: 10,
  //                   left: 10,
  //                   child: false
  //                       ? GestureDetector(
  //                     onTap: () async {
  //                       setState(() {
  //                         // _data.productInWishList = false;
  //                         // viewModel.deleteProductToWishList(_data.id!);
  //                       });
  //                     },
  //                     child: Icon(
  //                       Icons.favorite,
  //                       color: Colors.red,
  //                       size: 30,
  //                     ),
  //                   )
  //                       : GestureDetector(
  //                     onTap: () {
  //                       setState(() {
  //                         // _data.productInWishList = true;
  //                         // viewModel.addProductToWishList(_data.id!);
  //                       });
  //                     },
  //                     child: Icon(
  //                       Icons.favorite_border,
  //                       color: Colors.black,
  //                       size: 30,
  //                     ),
  //                   ),
  //                 ),
  //
  //               // if (_data.discount != null && _data.discount != 0)
  //               if (true)
  //                 Positioned(
  //                   top: 10,
  //                   right: 4,
  //                   child: Container(
  //                     padding: EdgeInsets.all(8),
  //                     decoration: BoxDecoration(
  //                       color: Color(0xffFC5D5D),
  //                       borderRadius: BorderRadius.circular(50),
  //                     ),
  //                     child: Text(
  //                       '${10}%',
  //                       style: Text_Style.small(color: Colors.white),
  //                     ),
  //                   ),
  //                 )
  //             ],
  //           ),
  //           SizedBox(
  //             height: 10,
  //           ),
  //           Text(
  //             "THIS IS THE TILTLE" ?? '',
  //             style: Text_Style.large(),
  //             overflow: TextOverflow.ellipsis,
  //           ),
  //           SizedBox(
  //             height: 10,
  //           ),
  //           // RichText(
  //           //   text: TextSpan(children: [
  //           //     TextSpan(
  //           //         text:
  //           //         '${(_data.averageProductPrice ?? 0) * (100 - (_data.discount ?? 0)) / 100} ',
  //           //         style: Text_Style.big(color: Colors.green)),
  //           //     TextSpan(text: 'MRP  ', style: Text_Style.small(color: Colors.grey)),
  //           //     TextSpan(
  //           //       text: '₹${_data.averageProductPrice ?? 0}',
  //           //       style: TextStyle(
  //           //         fontSize: 16,
  //           //         decoration: TextDecoration.lineThrough,
  //           //         color: Colors.black,
  //           //       ),
  //           //     )
  //           //   ]),
  //           //   overflow: TextOverflow.ellipsis,
  //           // )
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
