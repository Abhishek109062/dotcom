import 'dart:convert';

import 'package:dot_com/client/api_model/ProductCartModel.dart';
import 'package:flutter/cupertino.dart';

import '../api_model/verify_orderPrice_request_model.dart';
import '../repository/client_repository.dart';

class CartViewModel with ChangeNotifier {
  final _client_rep = ClientRepository();
  int _pageNo = 1;
  int pageSize = 20;

  double _TotalAmount = 0;
  double _TotalDiscount = 0;
  bool _outOfStockProduct = false;
  List<ProductCartModel> _cartData = [];
  bool _isLoadingMore = false;
  List<ProductCartModel> get cartData => _cartData;
  List<VerifyOrderPriceRequestModel> _verifyOrderData = [];
  bool _isLoading = false;
  set TotalAmount(double value) {
    _TotalAmount = value;
  }

  bool get outOfStockProduct => _outOfStockProduct;

  set outOfStockProduct(bool value) {
    _outOfStockProduct = value;
  }

  bool get isLoading => _isLoading;

  double get TotalAmount => _TotalAmount;
  double get TotalDiscount => _TotalDiscount;

  set TotalDiscount(double value) {
    _TotalDiscount = value;
  }

  set cartData(List<ProductCartModel> value) {
    _cartData = value;
  }

  bool get isLoadingMore => _isLoadingMore;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> initialPage() async {
    outOfStockProduct = false;
    _cartData = [];

    isLoading = true;
    _pageNo = 1;
    TotalAmount = 0;
    TotalDiscount = 0;

    await getCartProducts();
    // await Future.delayed(Duration(seconds: 4));
    isLoading = false;

    notifyListeners();
  }

  updateQuantity(index, value) {
    _cartData[index].quantity = value;
    updateTotalAndDiscount();
    notifyListeners();
  }

  updateTotalAndDiscount() {
    TotalAmount = 0;
    TotalDiscount = 0;
    for (ProductCartModel copy in _cartData) {
      TotalAmount = (TotalAmount + (copy.productMetaData?.price ?? 0) * (copy.quantity));
      TotalDiscount = TotalDiscount +
          ((copy.productMetaData?.price ?? 0) *
              (copy.quantity) *
              (copy.product?.discount ?? 0) /
              100);
    }
    notifyListeners();
  }

  List<dynamic>? getVerifyOrderRequestData() {
    List<VerifyOrderPriceRequestModel> data = [];
    for (ProductCartModel i in _cartData) {
      data.add(VerifyOrderPriceRequestModel(
          productId: i.product!.id,
          productQuantity: i.quantity,
          productMetaDataId: i.productMetaData!.id!));
    }
    print(VerifyOrderPriceRequestModelListToJson(data));
    return VerifyOrderPriceRequestModelListToJson(data);
  }

  Future<void> loadingMoreProductsTriggered() async {
    _isLoadingMore = true;
    notifyListeners();
    _pageNo++;
    await getCartProducts();

    _isLoadingMore = false;
    notifyListeners();
  }

  Future<void> getCartProducts() async {
    print("Api Called");
    // categories_list[selectedCategory]['code']
    dynamic temp = await _client_rep.callGetCartApi(_pageNo, pageSize).then((value) async {
      dynamic temp = jsonDecode(value.body);
      print(temp);
      for (Map<String, dynamic> t in temp) {
        ProductCartModel copy = ProductCartModel.fromJson(t);
        if ((copy.productMetaData?.quantity ?? 0) == 0) outOfStockProduct = true;
        _cartData.add(copy);
      }
      updateTotalAndDiscount();
      // print(_cartData.length);
      notifyListeners();
    }).catchError((e, StackTrace) {
      debugPrint("Error comming--${e.toString()}");
    });
  }

  Future<void> verifyOrderPrice() async {
    print("Api called");
  }
}
