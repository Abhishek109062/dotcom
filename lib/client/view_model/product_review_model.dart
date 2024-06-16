import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../api_model/product_review_model.dart';
import '../api_model/product_review_rating_model.dart';
import '../repository/client_repository.dart';

class ProductReviewModel with ChangeNotifier {
  final _client_rep = ClientRepository();
  bool _isLoadingMore = false;

  bool _isLoading = false;
  List<ProductReviewResponseModel> _productReviewData = [];
  ProductReviewRatingModel? _productReviewRatingData = null;
  int _pageNo = 1;
  int pageSize = 10;
  bool userLoggedIn = false;

  List<ProductReviewResponseModel> get productReviewData => _productReviewData;
  int productId = 0;
  String reviewFilter = 'Top Reviews';

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  set isLoadingMore(bool value) {
    _isLoadingMore = value;
    notifyListeners();
  }

  bool get isLoadingMore => _isLoadingMore;

  Future<void> initialPage(bool userLoggedIn, int productId) async {
    isLoading = true;
    this.userLoggedIn = userLoggedIn;
    this.productId = productId;
    _pageNo = 1;
    _productReviewRatingData = null;
    _productReviewData = [];
    await getReviewsByProductId();
    await getReviewRating();
    isLoading = false;
  }

  loadingMoreProductsTriggered() async {
    _isLoadingMore = true;
    notifyListeners();
    _pageNo++;
    // await getAllProductsHome();
    await getReviewsByProductId();
    _isLoadingMore = false;
    notifyListeners();
  }

  reviewFilterApplied() async {
    _pageNo = 1;
    _productReviewData = [];
    await getReviewsByProductId();
    notifyListeners();
  }

  Future<void> getReviewsByProductId() async {
    dynamic temp = await _client_rep
        .callGetReviewByProductIdApi(userLoggedIn, productId,
            reviewFilter == 'Top Reviews' ? "topReview" : 'latest', _pageNo, pageSize)
        .then((value) async {
      for (dynamic t in jsonDecode(value.body)) {
        _productReviewData.add(ProductReviewResponseModel.fromJson(t));
      }
    }).catchError((e, StackTrace) {
      debugPrint("Error --${e.toString()}");
    });
  }

  Future<void> getReviewRating() async {
    dynamic temp =
        await _client_rep.callGetReviewRatingIdApi(userLoggedIn, productId).then((value) async {
      _productReviewRatingData = ProductReviewRatingModel.fromJson(jsonDecode(value.body));
    }).catchError((e, StackTrace) {
      debugPrint("Error --${e.toString()}");
    });
  }

  ProductReviewRatingModel? get productReviewRatingData => _productReviewRatingData;
}
