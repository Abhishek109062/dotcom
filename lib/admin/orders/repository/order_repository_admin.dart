import 'package:dot_com/admin/orders/repository/order_details_model_admin.dart';
import 'package:dot_com/admin/orders/repository/order_urls_admin.dart';
import 'package:fpdart/fpdart.dart';

import '../../../core/error/failure.dart';
import '../../subadmin/data/datasources/subadmin_datasource_admin.dart';

class OrderRepositoryAdmin {
  Future<Either<Failure, List<OrderDetailsAdmin>>> getAllOrders(
      {required int pageNo,
      required int pageSize,
      String? searchString,
      String? orderStatus,
      String? paymentMode}) async {
    return await get<List<OrderDetailsAdmin>>(
        onSuccess: (data) {
          return orderDetailsAdminFromJson(data);
        },
        url: AdminOrderUrls.getAllOrders(
            pageNo: pageNo,
            pageSize: pageSize,
            searchString: searchString,
            orderStatus: orderStatus,
            paymentMode: paymentMode));
  }

  Future<Either<Failure, OrderDetailsAdmin>> getOrderById(
      {required int orderId}) async {
    return await get<OrderDetailsAdmin>(
        onSuccess: (data) {
          return OrderDetailsAdmin.fromJson(data);
        },
        url: AdminOrderUrls.getOrderById(orderId: orderId));
  }
}
