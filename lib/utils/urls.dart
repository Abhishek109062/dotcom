import '../constants.dart';

class AuthUrls {
  static String login({required String contactNumber, required String password}) =>
      ApiConstants.baseUrl + '/dotCom/login?contactNumber=${contactNumber}&password=${password}';
  static String register() => ApiConstants.baseUrl + '/dotCom/signUp';
  static String sendOTP({required String contactNumber}) =>
      ApiConstants.baseUrl + '/dotCom/sendOTP?contactNumber=$contactNumber';

  static String verifyOTP({required String contactNumber, required String otp}) =>
      ApiConstants.baseUrl +
      '/dotCom/verifyOTP?contactNumber=${contactNumber}&otp=${otp}&validationHash';
}

class ClientUrls {
  static String updateCustomerDetails() => ApiConstants.baseUrl + '/customer/updateCustomerDetails';
  static String getUser() => ApiConstants.baseUrl + '/user/get';
  static String getAdvertisements() =>
      ApiConstants.baseUrl + '/dotcom/advertisement?pageNo=1&pageSize=10';
  static String addProductReview() => ApiConstants.baseUrl + '/customer/addProductReview';
  static String getAllProducts(int pageNo, int pageSize, String pincode, String category) =>
      ApiConstants.baseUrl +
      "/dotcom/products/get?pageNo=$pageNo&pageSize=$pageSize&pincode=$pincode&category=$category";
  static String addProductToWishList(int productId) =>
      ApiConstants.baseUrl + '/customer/addProductToWishlist?productId=$productId';
  static String deleteProductToWishList(int productId) =>
      ApiConstants.baseUrl + '/customer/deleteWishlistProduct?productId=$productId';
  static String getWishlist(int pageNo, int pageSize) =>
      ApiConstants.baseUrl + '/customer/getWishListProducts?pageNo=$pageNo&pageSize=$pageSize';
  static String addProductsToCart(int productId, int productMetaId, int quantity) =>
      ApiConstants.baseUrl +
      '/customer/addProductToCart?productId=$productId&productMetaDataId=$productMetaId&quantity=$quantity';
  static String deleteProductToCart(int productId, int productMetaId) =>
      ApiConstants.baseUrl +
      '/customer/deleteCartProduct?productId=$productId&productMetaDataId=$productMetaId';
  static String getCart(int pageNo, int pageSize) =>
      ApiConstants.baseUrl + '/customer/getCartProducts?pageNo=$pageNo&pageSize=$pageSize';
  static String uploadFiles() => ApiConstants.baseUrl + '/dotcom/upload/file';

  static String getProductDetailsById(int productId) =>
      ApiConstants.baseUrl + '/dotcom/product?productId=$productId';

  static String getProductMetaDataById(int productId) =>
      ApiConstants.baseUrl + '/dotcom/product/metadata?productId=$productId';

  static String verifyOrderPrice() => ApiConstants.baseUrl + '/dotcom/verifyOrderPrice';
  static String addOrderDetails() => ApiConstants.baseUrl + '/customer/addOrderDetails';
  static String getOnlineOrders(int pageNo, int pageSize) =>
      ApiConstants.baseUrl +
      '/customer/getOnlineOrders?paymentMode=Online&pageNo=$pageNo&pageSize=$pageSize';
  static String getTakeAwayOrders(int pageNo, int pageSize) =>
      ApiConstants.baseUrl +
      '/customer/getTakeAwayOrders?paymentMode=TakeAway&pageNo=$pageNo&pageSize=$pageSize';
  static String getReviewByProductId(
          int productId, String reviewFilter, int pageNo, int pageSize) =>
      ApiConstants.baseUrl +
      '/customer/getAllProductReviewByIdWithPagination?productId=$productId&reviewFilter=$reviewFilter&pageNo=$pageNo&pageSize=$pageSize';
  static String getReviewRatingData(int productId) =>
      ApiConstants.baseUrl + '/customer/getReviewRatingsDataByProductId?productId=$productId';
}
