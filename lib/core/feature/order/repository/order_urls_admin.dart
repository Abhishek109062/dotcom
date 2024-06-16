import '../../../../constants.dart';

class AdminOrderUrls {
  static bool checkIfExist(String? val) {
    if (val == null || val == "") {
      return false;
    }
    return true;
  }

  //METHOD GET
  static getAllOrders(
          {required int pageNo,
          required int pageSize,
          String? searchString,
          String? orderStatus,
          String? paymentMode}) =>
      "${ApiConstants.baseUrl}/admin/getAllOrdersByPagination?pageNo=$pageNo&pageSize=$pageSize${checkIfExist(searchString) ? "&searchString=$searchString" : ""}${checkIfExist(orderStatus) ? "&orderStatus=$orderStatus" : ""}${checkIfExist(paymentMode) ? "&paymentMode=$paymentMode" : ""}";

  //METHOD GET
  static getOrderById({required int orderId}) =>
      "${ApiConstants.baseUrl}/admin/getOrderDetailById?orderId=$orderId";

  //METHOD PUT
  static cancelOrder({required int orderId,String reason = ""}) =>
      "${ApiConstants.baseUrl}/user/cancelOrderById?orderId=$orderId&reason=$reason";

  static updateOrder({required int orderId}) =>
      "${ApiConstants.baseUrl}/admin/updateOrderDetails?orderId=$orderId";
}
