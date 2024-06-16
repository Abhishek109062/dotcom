import 'dart:convert';
import 'package:flutter/cupertino.dart';
import '../api_model/product_details_model.dart';
import '../repository/client_repository.dart';

class WishListViewModel extends ChangeNotifier {
  final _client_rep = ClientRepository();
  int _pageNo = 1;
  int _pageSize = 6;
  List<ProductDetails> _allProducts = [];
  bool _isLoadingMore = false;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool get isLoadingMore => _isLoadingMore;

  set isLoadingMore(bool value) {
    _isLoadingMore = value;
    notifyListeners();
  }

  List<ProductDetails> get allProducts => _allProducts;

  initialPage() async {
    isLoading = true;
    _allProducts = [];
    _pageNo = 1;
    await getWishlistProducts();
    isLoading = false;
    notifyListeners();
  }

  loadingMoreProductsTriggered() async {
    isLoadingMore = true;
    _pageNo++;
    // await getAllProductsHome();
    await getWishlistProducts();
    isLoadingMore = false;
    notifyListeners();
  }

  Future<void> getWishlistProducts() async {
    // categories_list[selectedCategory]['code']
    dynamic temp = await _client_rep.callGetWishlistApi(_pageNo, _pageSize).then((value) async {
      dynamic store = jsonDecode(value.body);
      for (var productData in store) {
        _allProducts.add(ProductDetails.fromJson(productData['product']));
      }
      notifyListeners();
    }).catchError((e, StackTrace) {
      debugPrint("Error --${e.toString()}");
    });
  }

  Future<void> addProductToWishList(int productId) async {
    dynamic temp = await _client_rep.callAddProductToWishlistApi(productId).then((value) async {
      notifyListeners();
    }).catchError((e, StackTrace) {
      debugPrint("Error --${e.toString()}");
    });
  }

  Future<void> deleteProductToWishList(int productId) async {
    dynamic temp = await _client_rep.callDeleteProductToWishlistApi(productId).then((value) async {
      notifyListeners();
    }).catchError((e, StackTrace) {
      debugPrint("Error --${e.toString()}");
    });
  }
}
