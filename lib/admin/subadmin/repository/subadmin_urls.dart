import 'package:dot_com/constants.dart';

class SubAdminApiURLs {
  //METHOD POST
  static String addSubAdmin() => "${ApiConstants.baseUrl}/admin/addSubAdmin";

  //METHOD GET
  static String getSubAdminById({required int id}) =>
      "${ApiConstants.baseUrl}/admin/getSubAdminById?subAdminId=$id";

  //METHOD POST
  static String getAllSubAdmin(
          {required int pageNo,
          required int pageSize,
          required String blocStatus,
          String? searchString}) =>
      "${ApiConstants.baseUrl}/admin/getAllSubAdminsByPagination?pageNo=$pageNo&pageSize=$pageSize${searchString != null ? "&searchString=$searchString" : ""}${blocStatus!="" ? "&block=$blocStatus" : ""}";

  //METHOD PUT
  static String blocSubAdminById({required int id,required bool isBlocking}) =>
      "${ApiConstants.baseUrl}/admin/blockSubAdmin?subAdminId=$id${!isBlocking ? "&block=$isBlocking" : ""}";

  //METHOD PUT
  static String updateSubAdminDetails() =>
      "${ApiConstants.baseUrl}/subAdmin/updateSubAdmin";

  //METHOD GET
  static String getSubAdminProfile() =>
      "${ApiConstants.baseUrl}/subAdmin/getSubAdminProfile";
}
