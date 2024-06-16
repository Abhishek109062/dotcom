import 'package:dot_com/core/feature/order/repository/order_details_model_admin.dart';
import 'package:flutter/material.dart';

import '../../../core/feature/order/repository/order_repository_admin.dart';

class OrderDetailsSubAdminViewModel extends ChangeNotifier {
  final int orderId;
  OrderRepositoryAdmin _orderRepository = OrderRepositoryAdmin();
  bool isLoading = true;
  bool error = false;
  OrderDetailsAdmin? orderDetails;

  OrderDetailsSubAdminViewModel({required this.orderId});

  Future<void> getOrderDetails() async {
    setLoading(true);
    final res = await _orderRepository.getOrderById(orderId: orderId);
    await res.fold((l) {
      error = true;
    }, (r) {
      orderDetails = r;
    });
    setLoading(false);
  }

  Future<bool> cancelOrder({String reason = ""})async{
    setLoading(true);
    final res = await _orderRepository.cancelOrderById(orderId: orderDetails!.id,reason: reason);
    setLoading(false);
    return await res.fold((l) => false, (r) => true);

  }

  setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }


}
