import 'dart:io';

abstract class BaseApiService {
  Future<dynamic> getApiResponse(String url, dynamic data);
  Future<dynamic> getApiResponseWithToken(String url, dynamic data);
  Future<dynamic> postApiResponse(String url, dynamic data);
  Future<dynamic> postApiResponseWithToken(String url, dynamic data);
  Future<dynamic> postApiResponseWithTokenAndFile(String url, File file);
  Future<dynamic> putApiResponse(String url, dynamic data);
}
