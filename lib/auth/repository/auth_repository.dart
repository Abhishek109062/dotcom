import 'package:dot_com/core/services/network_api_service.dart';
import 'package:dot_com/utils/urls.dart';
import 'package:dot_com/utils/AppUrls.dart';
import 'package:http/http.dart' as http;

class AuthRepository {
  NetworkApiService _apiService = NetworkApiService();

  Future<http.Response> callSignInApi(String mobile, String password) async {
    try {
      final response = await _apiService.getApiResponse(
          AuthUrls.login(contactNumber: mobile, password: password), null);

      print(response);
      return response;
    } catch (e) {
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
}
