import "package:carousel_slider/carousel_slider.dart";
import "package:chips_choice/chips_choice.dart";
import "package:dot_com/subadmin/products/presentation/update_product_page.dart";
import "package:dot_com/subadmin/products/presentation/widgets/dropdown_product.dart";
import "package:dot_com/subadmin/products/presentation/widgets/text_input_product.dart";
import "package:dot_com/subadmin/products/repository/add_product_model.dart";
import "package:dot_com/subadmin/products/repository/product_model_subadmin.dart";
import "package:dot_com/subadmin/theme/subadmin_pallet.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:fpdart/fpdart.dart" as fp;
import "package:provider/provider.dart";

import "../../../admin/snackbar_custom.dart";
import "../../../components/formfields/formfieldvalidators.dart";
import "../../../components/network_image_loader.dart";
import "../../../components/text_style.dart";
import "../../../core/error/failure.dart";
import "../../home/viewModel/user_subadmin_viewModel.dart";
import "../viewModel/add_product_viewModel.dart";

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  static Route<bool> route() => MaterialPageRoute<bool>(
      builder: (_) => ChangeNotifierProvider(
            create: (BuildContext context) => AddProductViewModel(),
            child: AddProductPage(),
          ));

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  // TextEditingController searchController = TextEditingController();
  // ScrollController _scrollController = ScrollController();
  // FocusNode searchFocus = FocusNode();
  // String search = "";
  int tag = 1;
  TextEditingController productNameController = TextEditingController();
  TextEditingController brandNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController discountController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController deliveryTimeController = TextEditingController();
  TextEditingController averageProductPriceController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  bool _isKeyboardVisible = false;
  FocusNode productNameFocusNode = FocusNode();
  FocusNode brandNameFocusNode = FocusNode();
  FocusNode descriptionFocusNode = FocusNode();
  FocusNode stateFocusNode = FocusNode();
  FocusNode pincodeFocusNode = FocusNode();
  FocusNode discountFocusNode = FocusNode();
  FocusNode addressFocusNode = FocusNode();
  FocusNode deliveryTimeFocusNode = FocusNode();
  FocusNode averageProductPriceFocusNode = FocusNode();
  FocusNode districtFocusNode = FocusNode();

  // onSearchChanged(String val) {
  //   setState(() {
  //     this.search = val;
  //   });
  // }

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance!.addPostFrameCallback((_) {
    // });
  }

  @override
  void dispose() {
    // _scrollController.dispose();
    super.dispose();
  }

  final List<String> _list = const [
    'Developer',
    'Designer',
    'Consultant',
    'Student',
  ];

  int _current = 0;
  final CarouselController _controller = CarouselController();
  final _formKey = GlobalKey<FormState>();
  CustomFormFieldValidators customValidators = CustomFormFieldValidators();

  Future<fp.Either<Failure, ProductDetails>> addProduct() async {
    AddProduct newProduct = AddProduct(
        title: productNameController.text.trim(),
        brandName: brandNameController.text.trim(),
        description: descriptionController.text.trim(),
        averageProductPrice: double.parse(averageProductPriceController.text.trim()),
        discount: double.parse(discountController.text.trim()),
        district: districtController.text.trim(),
        estimatedDeliveryTime: int.parse(deliveryTimeController.text.trim()),
        pincode: int.parse(pincodeController.text.trim()),
        state: stateController.text.trim(),
        // category: category,
        // filters: [filters],
        // productImgUrls: [],
        takeAwayAddress: addressController.text.trim());
    return await Provider.of<AddProductViewModel>(context, listen: false).addProduct(newProduct);
  }

  @override
  Widget build(BuildContext context) {
    _isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      // appBar: AppBar(
      //   titleSpacing: 0,
      //   title: Text(
      //     "Advertisement/Add Advertisement",
      //     style: Text_Style.medium(color: Color(0xFF6586A0)),
      //   ),
      // ),
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                  leading: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: Color(0xFF6586A0),
                      )),
                  title: Text(
                    "Products/Add Product",
                    style: Text_Style.medium(color: Color(0xFF6586A0)),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Consumer<AddProductViewModel>(
                  builder: (context, provider, child) {
                    return AbsorbPointer(
                      absorbing: provider.addingProduct,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Consumer<AddProductViewModel>(
                            //   builder: (context, provider, child) {
                            //     return provider.imageUrl != ""
                            //         ? advertisementCard(
                            //         image: provider.imageUrl,
                            //         deleteImage: provider.deleteImage)
                            //         : addAdvertisementCard(
                            //         onTap: provider.selectImage,
                            //         uploading: provider.uploadingImage);
                            //   },
                            // ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                "Product Name",
                                style: Text_Style.medium(
                                    color: Color(0xff113946), fontWeight: FontWeight.w500),
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: TextFieldProduct(
                                controller: productNameController,
                                title: "Product",
                                focusNode: productNameFocusNode,
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            if (provider.selectedImages.isEmpty)
                              addPhotoCard(
                                  onTap: () async {
                                    await provider.selectImage();
                                  },
                                  uploading: provider.uploadingImage),
                            if (provider.selectedImages.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CarouselSlider(
                                  items: (provider.selectedImages)
                                      .map((item) => Container(
                                            margin: const EdgeInsets.all(8),
                                            child: ClipRRect(
                                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                                child: AspectRatio(
                                                  aspectRatio: 4 / 4.5,
                                                  child: Image.network(
                                                    item,
                                                    fit: BoxFit.fill,
                                                    errorBuilder: (_, __, ___) {
                                                      return Image.asset(
                                                        'assets/not_found.jpg',
                                                        fit: BoxFit.fill,
                                                      );
                                                    },
                                                  ),
                                                )),
                                          ))
                                      .toList(),
                                  carouselController: _controller,
                                  options: CarouselOptions(
                                      // height: 400,
                                      autoPlay: false,
                                      enableInfiniteScroll: false,
                                      viewportFraction: 1,
                                      enlargeCenterPage: false,
                                      aspectRatio: 4 / 4.5,
                                      onPageChanged: (index, reason) {
                                        setState(() {
                                          _current = index;
                                        });
                                      }),
                                ),
                              ),
                            if (provider.selectedImages.isNotEmpty)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: (provider.selectedImages).asMap().entries.map((entry) {
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
                            if (provider.selectedImages.isNotEmpty)
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: TextButton(
                                    onPressed: () async {
                                      if (provider.uploadingImage == false)
                                        await provider.selectImage();
                                    },
                                    style: TextButton.styleFrom(
                                        padding: EdgeInsets.symmetric(horizontal: 16),
                                        maximumSize: Size.fromHeight(40),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(10)),
                                            side: BorderSide(color: Color(0xffFC5D5D))),
                                        backgroundColor: Colors.white),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        provider.uploadingImage
                                            ? Container(
                                                height: 16,
                                                width: 16,
                                                child: CircularProgressIndicator())
                                            : Text(
                                                "+ Add Photo",
                                                style: Text_Style.medium(
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xff4D4D4D)),
                                              ),
                                      ],
                                    )),
                              ),
                            SizedBox(
                              height: 16,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                "Brand Name",
                                style: Text_Style.medium(
                                    color: Color(0xff113946), fontWeight: FontWeight.w500),
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: TextFieldProduct(
                                controller: brandNameController,
                                title: "Brand Name",
                                focusNode: brandNameFocusNode,
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                "Description",
                                style: Text_Style.medium(
                                    color: Color(0xff113946), fontWeight: FontWeight.w500),
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: TextFieldProduct(
                                controller: descriptionController,
                                focusNode: descriptionFocusNode,
                                title: "Description",
                                minLines: 5,
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                "Category",
                                style: Text_Style.medium(
                                    color: Color(0xff113946), fontWeight: FontWeight.w500),
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: DropDownMenuProduct(
                                hintText: "Select Category",
                                initialItem: provider.category,
                                title: "Category",
                                list: _list,
                                onChange: (value) {
                                  provider.setCategory(value);
                                },
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                "Filters",
                                style: Text_Style.medium(
                                    color: Color(0xff113946), fontWeight: FontWeight.w500),
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: DropDownMenuProduct(
                                hintText: "Select Filters",
                                initialItem: provider.filters,
                                title: "Filters",
                                list: _list,
                                onChange: (value) {
                                  provider.setFilter(value);
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: List.generate(
                                      provider.selectedFilters.length,
                                      (index) => Container(
                                            margin: EdgeInsets.only(right: 8),
                                            child: Chip(
                                              deleteIcon: Container(
                                                padding: EdgeInsets.all(2),
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(8),
                                                    color: SubAdminAppPallete.primaryColor),
                                                child: Icon(
                                                  Icons.close,
                                                  size: 12,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              color: MaterialStatePropertyAll(Color(0xffFED7C7)),
                                              onDeleted: () {
                                                provider.deleteFilter(
                                                    provider.selectedFilters.toList()[index]);
                                              },
                                              padding: EdgeInsets.all(0),
                                              label: Text(
                                                provider.selectedFilters.toList()[index],
                                              ),
                                            ),
                                          )),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                "District",
                                style: Text_Style.medium(
                                    color: Color(0xff113946), fontWeight: FontWeight.w500),
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: TextFieldProduct(
                                controller: districtController,
                                focusNode: districtFocusNode,
                                title: "District",
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                "State",
                                style: Text_Style.medium(
                                    color: Color(0xff113946), fontWeight: FontWeight.w500),
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: TextFieldProduct(
                                controller: stateController,
                                focusNode: stateFocusNode,
                                title: "State",
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                "Pincode",
                                style: Text_Style.medium(
                                    color: Color(0xff113946), fontWeight: FontWeight.w500),
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: TextFieldProduct(
                                controller: pincodeController,
                                focusNode: pincodeFocusNode,
                                title: "Pincode",
                                inputFormatter: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(6),
                                ],
                                textInputType: TextInputType.phone,
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                "Discount (%)",
                                style: Text_Style.medium(
                                    color: Color(0xff113946), fontWeight: FontWeight.w500),
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: TextFieldProduct(
                                controller: discountController,
                                focusNode: discountFocusNode,
                                title: "Discount",
                                inputFormatter: [
                                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                                ],
                                textInputType: TextInputType.phone,
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                "Average Product Price",
                                style: Text_Style.medium(
                                    color: Color(0xff113946), fontWeight: FontWeight.w500),
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: TextFieldProduct(
                                controller: averageProductPriceController,
                                focusNode: averageProductPriceFocusNode,
                                title: "Average Product Price",
                                inputFormatter: [
                                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                                ],
                                textInputType: TextInputType.phone,
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                "Takeaway Address",
                                style: Text_Style.medium(
                                    color: Color(0xff113946), fontWeight: FontWeight.w500),
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: TextFieldProduct(
                                controller: addressController,
                                focusNode: addressFocusNode,
                                title: "Takeaway address",
                                minLines: 3,
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                "Estimated delivery (in days)",
                                style: Text_Style.medium(
                                    color: Color(0xff113946), fontWeight: FontWeight.w500),
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: TextFieldProduct(
                                controller: deliveryTimeController,
                                focusNode: deliveryTimeFocusNode,
                                title: "Estimated delivery",
                                inputFormatter: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                textInputType: TextInputType.phone,
                              ),
                            ),

                            SizedBox(
                              height: 80,
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      bottomSheet:_isKeyboardVisible ? SizedBox(): Consumer<AddProductViewModel>(
        builder: (context, provider, child) {
          return Container(
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(0)),
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                    child: TextButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            fp.Either<Failure, ProductDetails> res = await addProduct();
                            await res.fold((l) {
                              snackBarCustom(context, l.message);
                            }, (r) {
                              snackBarCustom(context, "Product Added Successfully");
                              Navigator.of(context).pushReplacement(UpdateProductPage.route(productId: r.id));
                            });
                          }
                        },
                        style: TextButton.styleFrom(
                            maximumSize: Size.fromHeight(44),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10))),
                            backgroundColor:
                                // provider.getCreateAdvertBtnStatus()
                                //     ? Color(0xffFC5D5D)
                                //     :
                                Color(0xff999999)),
                        child: provider.addingProduct
                            ? Container(
                                height: 16,
                                width: 16,
                                child: CircularProgressIndicator(),
                              )
                            : Text(
                                "Add Product",
                                style: Text_Style.medium(
                                    fontWeight: FontWeight.w500, color: Colors.white),
                              )))
              ],
            ),
          );
        },
      ),
    );
  }

  Widget advertisementCard({required String image, required VoidCallback deleteImage}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            height: 160,
            width: double.infinity,
            child: Stack(
              fit: StackFit.passthrough,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    image,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                    right: 10,
                    top: 10,
                    child: GestureDetector(
                        onTap: () async {
                          bool? res = await deleteConfirmationDialog();
                          if (res ?? false) {
                            deleteImage();
                          }
                        },
                        child: Container(
                            height: 30, width: 30, child: Image.asset("assets/deleteIcon.png"))))
              ],
            ),
          )),
    );
  }

  Widget addPhotoCard({required Function() onTap, required bool uploading}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: AspectRatio(
            aspectRatio: 4 / 4.5,
            child: Container(
              color: Colors.grey,
              width: double.infinity,
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  uploading
                      ? CircularProgressIndicator()
                      : TextButton(
                          onPressed: onTap,
                          style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              maximumSize: Size.fromHeight(40),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  side: BorderSide(color: Color(0xffFC5D5D))),
                              backgroundColor: Colors.white),
                          child: Text(
                            "+ Add Photo",
                            style: Text_Style.medium(
                                fontWeight: FontWeight.w500, color: Color(0xff4D4D4D)),
                          )),
                ],
              ),
            ),
          )),
    );
  }

  deleteConfirmationDialog() async {
    return await showDialog(
        context: context,
        useRootNavigator: false,
        builder: (_) {
          return AlertDialog(
            titlePadding: EdgeInsets.all(16),
            backgroundColor: Color(0xffFFF9EC),
            title: Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text(
                "Are You Sure You want to Delete this Advertisement",
                style: Text_Style.medium(fontWeight: FontWeight.w500, color: Color(0xffFC5D5D)),
                textAlign: TextAlign.center,
              ),
            ),
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              TextButton(
                  onPressed: () async {
                    Navigator.of(context).pop(true);
                  },
                  style: TextButton.styleFrom(
                      maximumSize: Size.fromHeight(40),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      backgroundColor: Color(0xffFC5D5D)),
                  child: Text(
                    "Yes",
                    style: Text_Style.medium(fontWeight: FontWeight.w500, color: Colors.white),
                  )),
              TextButton(
                  onPressed: () async {
                    Navigator.of(context).pop(false);
                  },
                  style: TextButton.styleFrom(
                      maximumSize: Size.fromHeight(40),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      backgroundColor: Colors.transparent),
                  child: Text(
                    "No",
                    style: Text_Style.medium(fontWeight: FontWeight.w500, color: Color(0xff666666)),
                  ))
            ],
          );
        });
  }
}
