import 'package:dot_com/core/error/failure.dart';
import 'package:dot_com/subadmin/products/repository/product_metadata_model_subadmin.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/src/either.dart';

import '../../../utils/imagepicker.dart';
import '../repository/product_model_subadmin.dart';
import '../repository/product_repository.dart';

class UpdateProductViewModel extends ChangeNotifier {
  final int productId;
  UpdateProductViewModel({required this.productId});
  bool deletingProduct = false;
  ProductRepository _productRepository = ProductRepository();
  bool errorLoadingProduct = false;
  bool loadingProduct = false;
  bool uploadingImage = false;
  bool updatingProduct = false;
  List<String> selectedImages = [];
  List<ProductMetadataDto> metadata = [];
  Set<String> selectedFilters = {};

  String category = "";
  String filters = "";

  ProductDetails? product;

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

  void initializeControllerTextValues() {
    productNameController.text = product!.title;
    brandNameController.text = product!.brandName;
    descriptionController.text = product!.description;
    stateController.text = product!.state;
    pincodeController.text = product!.pincode.toString();
    discountController.text = product!.discount.toString();
    addressController.text = product!.takeAwayAddress;
    deliveryTimeController.text = product!.estimatedDeliveryTime.toString();
    averageProductPriceController.text = product!.averageProductPrice.toString();
    districtController.text = product!.district;
    this.selectedFilters = product!.filters.toSet();
    this.category = product!.category;
    this.selectedImages = product!.productImgUrls;
  }

  Future<void> updateProduct(Function() onSuccess, Function(String) onFailure) async {
    updatingProduct = true;
    notifyListeners();
    product!.title = productNameController.text;
    product!.brandName = brandNameController.text;
    product!.description = descriptionController.text;
    product!.state = stateController.text.toString();
    product!.pincode = int.parse(pincodeController.text);
    product!.discount = double.parse(discountController.text);
    product!.takeAwayAddress = addressController.text;
    product!.estimatedDeliveryTime = int.parse(deliveryTimeController.text);
    product!.averageProductPrice = double.parse(averageProductPriceController.text);
    product!.district = districtController.text;
    product!.filters = selectedFilters.toList();
    product!.category = category;
    product!.productImgUrls = selectedImages;

    final res = await _productRepository.updateProduct(updatedProduct: product!);
    res.fold((l) {
      onFailure(l.message);
    }, (r) {
      onSuccess();
    });
    updatingProduct = false;
    notifyListeners();
  }

  getAllMetaDataDetails() async {
    setProductLoading(true);
    final res = await _productRepository.getAllProductMetadata(productId: productId);
    await res.fold((l) {
      errorLoadingProduct = true;
    }, (r) {
      metadata = r;
    });
    setProductLoading(false);
  }

  setCategory(String value) {
    category = value;
    notifyListeners();
  }

  setFilter(String value) {
    filters = value;
    selectedFilters.add(filters);
    notifyListeners();
  }

  deleteFilter(String value) {
    this.selectedFilters.removeWhere((element) => element == value);
    if (this.selectedFilters.isEmpty) {
      this.filters = "";
    }
    notifyListeners();
  }

  selectImage() async {
    final response = await getImageFromGallery();
    response.fold((l) {}, (r) async {
      this.uploadingImage = true;
      notifyListeners();
      final imageResponse = await uploadImage(r);
      this.uploadingImage = false;
      notifyListeners();
      imageResponse.fold((l) {}, (r) {
        selectedImages.add(r);
        print(this.selectedImages);
        notifyListeners();
      });
    });
  }

  getProductDetail() async {
    setProductLoading(true);
    final res = await _productRepository.getProduct(productId: productId);
    await res.fold((l) {
      errorLoadingProduct = true;
    }, (r) {
      product = r;
      initializeControllerTextValues();
    });
    setProductLoading(false);
  }

  Future<void> deleteProduct(Function() onSuccess, Function(String) onFailure) async {
    deletingProduct = true;
    notifyListeners();

    final res = await _productRepository.deleteProduct(productId: productId);
    res.fold((l) {
      onFailure(l.message);
    }, (r) {
      onSuccess();
    });
    deletingProduct = false;
    notifyListeners();
  }

  setProductLoading(bool value) {
    loadingProduct = value;
    notifyListeners();
  }
}
