import 'package:dot_com/core/feature/order/repository/order_details_model_admin.dart';
import 'package:dot_com/core/feature/order/repository/order_urls_admin.dart';
import 'package:fpdart/fpdart.dart';

import '../../../error/failure.dart';
import '../../../../admin/subadmin/data/datasources/subadmin_datasource_admin.dart';

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

  Future<Either<Failure, String>> cancelOrderById(
      {required int orderId,String reason = ""}) async {
    return await put<String>(
        onSuccess: (data) {
          return data;
        },
        body: {},
        url: AdminOrderUrls.cancelOrder(orderId: orderId,reason: reason));
  }

  Future<Either<Failure, String>> updateOrderById(
      {required int orderId,required Map<String,dynamic> updatedDetails}) async {
    return await put<String>(
        onSuccess: (data) {
          return data;
        },
        body: updatedDetails,
        url: AdminOrderUrls.updateOrder(orderId: orderId));
  }

}
