import 'dart:io';

import 'package:dot_com/admin/advertisement/repository/advertisement_repository.dart';
import 'package:dot_com/admin/advertisement/repository/product_model.dart';
import 'package:flutter/material.dart';

import '../../../utils/imagepicker.dart';

class AddAdvertisementViewModel extends ChangeNotifier {
  AdvertisementRepository _advertisementRepository = AdvertisementRepository();

  List<ProductDetails> products = [];
  bool loadingProducts = false;
  bool uploadingImage = false;
  // bool enableCreateAdvertisement = false;
  int pageNo = 1;
  int pageSize = 10;
  bool isNoMore = false;
  List<int> userChecked = [];

  void onSelected(bool selected, int dataName) {
    if (selected == true) {
      userChecked = [dataName];
    } else {
      userChecked = [];
    }
    notifyListeners();
  }

  String imageUrl = "";

  // selectProduct(int id){
  //   this.selectedProductId = id;
  //   notifyListeners();
  // }
  //
  // removeProduct(){
  //   selectedProductId = null;
  //   notifyListeners();
  // }

  deleteImage() {
    this.imageUrl = "";
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
        this.imageUrl = r;
        print(this.imageUrl);
        notifyListeners();
      });
    });
  }

  bool getCreateAdvertBtnStatus() {
    if (imageUrl != "" && userChecked.isNotEmpty) {
      return true;
    }
    return false;
  }

  void getAllProducts() async {
    loadingProducts = true;
    notifyListeners();
    final response = await _advertisementRepository.getAllProducts(
        pageNo: pageNo, pageSize: pageSize);
    response.fold((l) => {}, (r) {
      this.products += r;
      pageNo++;
      if (r.length < pageSize) {
        this.isNoMore = true;
      }
    });
    loadingProducts = false;
    notifyListeners();
  }

  Future<bool> addAdvertisement() async {
    final response = await _advertisementRepository.addAdvertisement(
        imageUrl: this.imageUrl, productId: this.userChecked.first);
    return await response.fold((l) {
      return false;
    }, (r) {
      return true;
    });
  }
}
