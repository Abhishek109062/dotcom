import 'dart:io';

import 'package:dot_com/core/services/network_api_service.dart';
import 'package:dot_com/utils/urls.dart';
import 'package:http/http.dart' as http;

class ClientRepository {
  NetworkApiService _apiService = NetworkApiService();

  Future<http.Response> callGetUserApi() async {
    try {
      final response = await _apiService.getApiResponseWithToken(ClientUrls.getUser(), null);

      return response;
    } catch (e) {
      print('throw here');
      throw Exception(e);
    }
  }

  Future<http.Response> callRegisterApi(Map<String, dynamic>? data) async {
    try {
      final response = await _apiService.postApiResponse(AuthUrls.register(), data ?? null);
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<http.Response> callSendOTPApi(String mobile) async {
    try {
      final response =
          await _apiService.postApiResponse(AuthUrls.sendOTP(contactNumber: mobile), null);
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<http.Response> callVerifyOTPApi(String mobile, String otp, String validationHash) async {
    try {
      final response = await _apiService.postApiResponse(
          AuthUrls.verifyOTP(contactNumber: mobile, otp: otp), null);
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<http.Response> callUpdateCustomerDetailsApi(Map<String, dynamic> data) async {
    try {
      final response = await _apiService.putApiResponse(ClientUrls.updateCustomerDetails(), data);
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<http.Response> callGetWishlistApi(int pageNo, int pageSize) async {
    try {
      final response =
          await _apiService.getApiResponseWithToken(ClientUrls.getWishlist(pageNo, pageSize), null);
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<http.Response> callAddProductToWishlistApi(int productId) async {
    try {
      final response = await _apiService.postApiResponseWithToken(
          ClientUrls.addProductToWishList(productId), null);
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<http.Response> callDeleteProductToWishlistApi(int productId) async {
    try {
      final response =
          await _apiService.putApiResponse(ClientUrls.deleteProductToWishList(productId), null);
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<http.Response> callUploadFileApi(File file) async {
    try {
      final response =
          await _apiService.postApiResponseWithTokenAndFile(ClientUrls.uploadFiles(), file);

      print(response);
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<http.Response> callGetAllProductsHomeApi(int pageNo, int pageSize, String pincode,
      String category, bool userLoggedIn, Map<String, dynamic> data) async {
    try {
      final response = userLoggedIn
          ? await _apiService.postApiResponseWithToken(
              ClientUrls.getAllProducts(pageNo, pageSize, pincode, category), data)
          : await _apiService.postApiResponse(
              ClientUrls.getAllProducts(pageNo, pageSize, pincode, category), data);
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<http.Response> callGetProductDetailsByIdApi(int productId, bool userLoggedIn) async {
    try {
      final response = userLoggedIn
          ? await _apiService.getApiResponseWithToken(
              ClientUrls.getProductDetailsById(productId), null)
          : await _apiService.getApiResponse(ClientUrls.getProductDetailsById(productId), null);

      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<http.Response> callGetProductMetaDataByIdApi(int productId, bool userLoggedIn) async {
    try {
      final response = userLoggedIn
          ? await _apiService.getApiResponseWithToken(
              ClientUrls.getProductMetaDataById(productId), null)
          : await _apiService.getApiResponse(ClientUrls.getProductMetaDataById(productId), null);

      print(response);
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<http.Response> callAddProductsToCartApi(
      int productId, int productMetaId, int quantity) async {
    try {
      final response = await _apiService.postApiResponseWithToken(
          ClientUrls.addProductsToCart(productId, productMetaId, quantity), null);

      print(response);
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<http.Response> callDeleteProductsToCartApi(int productId, int productMetaId) async {
    try {
      final response = await _apiService.putApiResponse(
          ClientUrls.deleteProductToCart(productId, productMetaId), null);

      print(response);
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<http.Response> callGetCartApi(int pageNo, int pageSize) async {
    try {
      final response =
          await _apiService.getApiResponseWithToken(ClientUrls.getCart(pageNo, pageSize), null);

      print(response);
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<http.Response> callGetAdvertisementApi(bool userLoggedIn) async {
    try {
      final response = userLoggedIn
          ? await _apiService.getApiResponseWithToken(ClientUrls.getAdvertisements(), null)
          : await _apiService.getApiResponse(ClientUrls.getAdvertisements(), null);

      print(response);
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<http.Response> callVerifyOrderPriceApi(Map<String, dynamic> data) async {
    try {
      final response =
          await _apiService.postApiResponseWithToken(ClientUrls.verifyOrderPrice(), data);

      print(response);
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<http.Response> callAddOrderDetailsApi(Map<String, dynamic> data) async {
    try {
      final response =
          await _apiService.postApiResponseWithToken(ClientUrls.addOrderDetails(), data);

      print(response);
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<http.Response> callGetOnlineOrdersApi(int pageNo, int pageSize) async {
    try {
      final response = await _apiService.getApiResponseWithToken(
          ClientUrls.getOnlineOrders(pageNo, pageSize), null);

      print(response);
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<http.Response> callGetTakeAwayOrdersApi(int pageNo, int pageSize) async {
    try {
      final response = await _apiService.getApiResponseWithToken(
          ClientUrls.getTakeAwayOrders(pageNo, pageSize), null);

      print(response);
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<http.Response> callGetReviewByProductIdApi(
      bool userLoggedIn, int productId, String reviewFilter, int pageNo, int pageSize) async {
    try {
      final response = userLoggedIn
          ? await _apiService.getApiResponseWithToken(
              ClientUrls.getReviewByProductId(productId, reviewFilter, pageNo, pageSize), null)
          : await _apiService.getApiResponse(
              ClientUrls.getReviewByProductId(productId, reviewFilter, pageNo, pageSize), null);

      print(response);
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<http.Response> callGetReviewRatingIdApi(bool userLoggedIn, int productId) async {
    try {
      final response = userLoggedIn
          ? await _apiService.getApiResponseWithToken(
              ClientUrls.getReviewRatingData(productId), null)
          : await _apiService.getApiResponse(ClientUrls.getReviewRatingData(productId), null);

      print(response);
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }
}
