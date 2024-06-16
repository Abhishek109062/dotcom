import 'package:dot_com/core/feature/order/repository/order_details_model_admin.dart';
import 'package:dot_com/core/feature/order/repository/order_repository_admin.dart';
import 'package:flutter/material.dart';

class OrderHomeViewModelAdmin extends ChangeNotifier {
  OrderRepositoryAdmin _orderRepository = OrderRepositoryAdmin();

  int pageNo = 1;
  int pageSize = 6;
  bool isNoMore = false;
  bool isLoading = false;
  bool isLoadingMore = false;
  List<OrderDetailsAdmin> orders = [];
  bool error = false;
  String paymentMode = "";
  String searchString = "";
  String orderStatus = "";

  resetPage() {
    pageNo = 1;
    pageSize = 6;
    isNoMore = false;
    isLoading = false;
    isLoadingMore = false;
    orders = [];
    error = false;
  }

  Future<void> getAllOrders() async {
    setLoading(true);
    final res = await _orderRepository.getAllOrders(
        pageNo: pageNo,
        pageSize: pageSize,
        paymentMode: paymentMode,
        orderStatus: orderStatus,
        searchString: searchString);
    await res.fold((l) {
      error = true;
    }, (r) {
      orders += r;
      pageNo++;
      if (r.length < pageSize) {
        isNoMore = true;
      }
    });
    setLoading(false);
  }

  setLoading(bool value) {
    if (orders.isEmpty)
      isLoading = value;
    else
      isLoadingMore = value;
    notifyListeners();
  }

  scrollListener(ScrollController controller) {
    if (isLoadingMore || isNoMore) return;
    if (controller.position.pixels == controller.position.maxScrollExtent) {
      getAllOrders();
    }
  }
}
