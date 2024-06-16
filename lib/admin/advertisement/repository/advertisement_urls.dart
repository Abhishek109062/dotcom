import '../../../constants.dart';

class AdvertisementsURLs {
  //METHOD POST
  static String addAdvertisement() =>
      "${ApiConstants.baseUrl}/admin/advertisement/add";

  //METHOD PUT
  static String deleteAdvertisement({required int id}) =>
      "${ApiConstants.baseUrl}/admin/advertisement/delete?advertisementId=$id";

  //METHOD POST
  static String updateAdvertisement({required int id}) =>
      "${ApiConstants.baseUrl}/admin/advertisement/delete?advertisementId=$id";

  //METHOD GET
  static String getAllAdvertisement(
          {required int pageNo, required int pageSize}) =>
      "${ApiConstants.baseUrl}/admin/advertisement/get?pageNo=$pageNo&pageSize=$pageSize";

  //METHOD POST
  static String getAllProductDetails(
          {required int pageNo, required int pageSize}) =>
      "${ApiConstants.baseUrl}/subAdmin/getProductDetailsWithPagination?pageNo=$pageNo&pageSize=$pageSize";
}
