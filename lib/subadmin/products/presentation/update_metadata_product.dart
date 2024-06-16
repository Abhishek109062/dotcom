import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dot_com/subadmin/products/presentation/widgets/text_input_product.dart';
import 'package:dot_com/subadmin/theme/subadmin_pallet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../admin/snackbar_custom.dart';
import '../../../components/text_style.dart';
import '../../home/viewModel/user_subadmin_viewModel.dart';
import '../viewModel/update_medatada_viewModel.dart';

class UpdateMetaData extends StatefulWidget {
  const UpdateMetaData({super.key});
  static Route<bool> route(int productMetaDataId) => MaterialPageRoute<bool>(
      builder: (_) => ChangeNotifierProvider(
            create: (BuildContext context) =>
                UpdateMetadataViewModel(productMetaDataId: productMetaDataId),
            child: UpdateMetaData(),
          ));

  @override
  State<UpdateMetaData> createState() => _UpdateMetaDataState();
}

class _UpdateMetaDataState extends State<UpdateMetaData> {
  final CarouselController _controller = CarouselController();
  final _formKey = GlobalKey<FormState>();
  int _current = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UpdateMetadataViewModel>(context, listen: false).getMetadataDetails();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                    "Products/ Update Product/ Update Metadata",
                    overflow: TextOverflow.ellipsis,
                    style: Text_Style.medium(color: Color(0xFF6586A0)),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Consumer<UpdateMetadataViewModel>(
                  builder: (context, provider, child) {
                    return AbsorbPointer(
                      absorbing: provider.updatingMetadata,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                                "Size",
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
                                controller: provider.sizeController,
                                focusNode: provider.sizeFocusNode,
                                title: "Size",
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                "Color",
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
                                controller: provider.colorController,
                                focusNode: provider.colorFocusNode,
                                title: "Color",
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                "Quantity",
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
                                controller: provider.quantityController,
                                focusNode: provider.quantityFocusNode,
                                title: "Quantity",
                                inputFormatter: [
                                  FilteringTextInputFormatter.digitsOnly,
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
                                "Price",
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
                                controller: provider.priceController,
                                focusNode: provider.priceFocusNode,
                                title: "Price",
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
                              padding: const EdgeInsets.all(16.0),
                              child: TextButton(
                                  onPressed: () async {
                                    await provider.deleteMetadata(() {
                                      snackBarCustom(context, "Metadata Deleted Successfully");
                                      Navigator.of(context).pop(true);
                                    }, (String msg) => snackBarCustom(context, msg));
                                  },
                                  style: TextButton.styleFrom(
                                      maximumSize: Size.fromHeight(44),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(10)),
                                          side: BorderSide(color: SubAdminAppPallete.primaryColor)),
                                      backgroundColor: Colors.white),
                                  child: provider.deletingMetadata
                                      ? Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              height: 16,
                                              width: 16,
                                              child: CircularProgressIndicator(),
                                            ),
                                          ],
                                        )
                                      : Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.delete,
                                              color: SubAdminAppPallete.primaryColor,
                                              size: 16,
                                            ),
                                            Text(
                                              "Delete Metadata",
                                              style: Text_Style.medium(
                                                  fontWeight: FontWeight.w600,
                                                  color: SubAdminAppPallete.primaryColor),
                                            ),
                                          ],
                                        )),
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
      bottomSheet: Consumer<UpdateMetadataViewModel>(
        builder: (context, provider, child) {
          return Container(
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(0)),
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                    child: TextButton(
                        onPressed: () async {
                          await provider.updateMetadata(() {
                            snackBarCustom(context, "Metadata Updated Successfully");
                            Navigator.of(context).pop(true);
                          }, (String msg) => snackBarCustom(context, msg));
                        },
                        style: TextButton.styleFrom(
                            maximumSize: Size.fromHeight(44),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10))),
                            backgroundColor:
                                // provider.getCreateAdvertBtnStatus()
                                //     ?
                                Color(0xffFC5D5D)
                            //     :
                            // Color(0xff999999)
                            ),
                        child: provider.updatingMetadata
                            ? Container(
                                height: 16,
                                width: 16,
                                child: CircularProgressIndicator(),
                              )
                            : Text(
                                "Update Metadata",
                                style: Text_Style.medium(
                                    fontWeight: FontWeight.w500, color: Colors.white),
                              )))
              ],
            ),
          );
        },
      ),
    );
    ;
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
}
