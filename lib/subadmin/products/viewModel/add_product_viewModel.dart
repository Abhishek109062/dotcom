import 'package:dot_com/core/error/failure.dart';
import 'package:dot_com/subadmin/products/repository/add_product_model.dart';
import 'package:dot_com/subadmin/products/repository/product_model_subadmin.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';

import '../../../utils/imagepicker.dart';
import '../repository/product_repository.dart';

class AddProductViewModel extends ChangeNotifier{
  ProductRepository _productRepository = ProductRepository();

  bool uploadingImage = false;
  bool addingProduct = false;
  List<String> selectedImages = [];
  Set<String> selectedFilters = {};

  String category = "";
  String filters = "";


  setCategory(String value) {
    category = value;
    notifyListeners();
  }

  setFilter(String value) {
    filters = value;
    selectedFilters.add(filters);
    notifyListeners();
  }

  deleteFilter(String value){
    this.selectedFilters.removeWhere((element) => element == value);
    if(this.selectedFilters.isEmpty){
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

  Future<Either<Failure, ProductDetails>> addProduct(AddProduct newProduct)async{
    this.addingProduct = true;
    notifyListeners();
    newProduct.productImgUrls = selectedImages;
    newProduct.category = category;
    newProduct.filters = selectedFilters.toList();
    print(newProduct.toJson());
    final res = await _productRepository.addProduct(newProduct);
    // await Future.delayed(Duration(seconds: 5));
    this.addingProduct = false;
    notifyListeners();
    return res;
  }
}