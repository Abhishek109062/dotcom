import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../api_model/online_order_details_model.dart';
import '../repository/client_repository.dart';

class OrderHistoryViewModel with ChangeNotifier {
  final _client_rep = ClientRepository();
  String _selectedOrderType = "Online";
  List<OrderDetailsDto> _onlineOrderInfo = [];
  List<OrderDetailsDto> _takeAwayOrderInfo = [];

  List<OrderDetailsDto> get onlineOrderInfo => _onlineOrderInfo;

  List<OrderDetailsDto> get takeAwayOrderInfo => _takeAwayOrderInfo;

  String get selectedOrderType => _selectedOrderType;
  int _pageNo = 1;
  int pageSize = 8;
  bool _isLoading = false;
  bool _isLoadingMore = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  set isLoadingMore(bool value) {
    _isLoadingMore = value;
    notifyListeners();
  }

  bool get isLoadingMore => _isLoadingMore;
  set selectedOrderType(String value) {
    _selectedOrderType = value;
    isLoading = true;

    isLoading = false;
    notifyListeners();
  }

  Future<void> initialPage() async {
    isLoading = true;
    _onlineOrderInfo = [];
    _takeAwayOrderInfo = [];
    _pageNo = 1;
    _selectedOrderType == "Online" ? await onlineOrder() : await takeAwayOrder();
    isLoading = false;
  }

  loadingMoreProductsTriggered() async {
    _isLoadingMore = true;
    notifyListeners();
    _pageNo++;
    // await getAllProductsHome();

    _isLoadingMore = false;
    notifyListeners();
  }

  Future<void> onlineOrder() async {
    dynamic temp = await _client_rep.callGetOnlineOrdersApi(_pageNo, pageSize).then((value) {
      Map<String, dynamic> pr = jsonDecode(value.body);
      for (List<dynamic> tr in pr.values) {
        // print(tr);
        _onlineOrderInfo.add(OrderDetailsDto.fromJson(tr[0]));
      }
    }).catchError((e, StackTrace) {
      debugPrint("Error --${e.toString()}");
    });

    print("triggered");
  }

  Future<void> takeAwayOrder() async {
    dynamic temp = await _client_rep.callGetTakeAwayOrdersApi(_pageNo, pageSize).then((value) {
      for (Map<String, dynamic> tr in jsonDecode(value.body)) {
        // print(tr);
        _takeAwayOrderInfo.add(OrderDetailsDto.fromJson(tr));
      }
    }).catchError((e, StackTrace) {
      debugPrint("Error --${e.toString()}");
    });

    print("triggered");
  }
}
