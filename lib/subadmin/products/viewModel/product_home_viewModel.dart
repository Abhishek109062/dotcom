import 'package:dot_com/subadmin/products/repository/product_repository.dart';
import 'package:flutter/material.dart';

import '../repository/product_model_subadmin.dart';

class ProductHomeViewModel extends ChangeNotifier {
  ProductRepository _productRepository = ProductRepository();

  int pageNo = 1;
  int pageSize = 6;
  bool isNoMore = false;
  bool isLoading = false;
  bool isLoadingMore = false;
  List<ProductDetails> products = [];
  bool error = false;


  resetPage(){
    pageNo = 1;
    pageSize = 6;
    isNoMore = false;
    isLoading = false;
    isLoadingMore = false;
    products = [];
    error = false;
  }

  Future<void> getAllProducts() async {
    setLoading(true);
    final res = await _productRepository.getAllProductDetails(pageNo: pageNo, pageSize: pageSize);
    await res.fold((l) {
      error = true;
    }, (r) {
      products += r;
      pageNo++;
      if (r.length < pageSize) {
        isNoMore = true;
      }
    });
    setLoading(false);
  }

  setLoading(bool value) {
    if (products.isEmpty)
      isLoading = value;
    else
      isLoadingMore = value;
    notifyListeners();
  }

  scrollListener(ScrollController controller){
    if (isLoadingMore || isNoMore) return;
    if (controller.position.pixels ==
        controller.position.maxScrollExtent) {
       getAllProducts();
    }
  }

}
