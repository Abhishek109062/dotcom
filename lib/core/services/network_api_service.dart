import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dot_com/components/customsnackbar.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../base/base_service.dart';
import '../network/api_exception.dart';
import '../network/base_api.dart';

class NetworkApiService extends BaseService implements BaseApiService {
  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return response;
      case 403:
        return response;
      case 400:
      case 401:
        errorSnackBar(msg: response.body.toString());
        throw BadRequestException(response.body.toString());
      case 404:
        errorSnackBar(msg: response.body.toString());
        throw UnauthorizedException(response.body.toString());
      default:
        FetchDataException('Error while Communication with status code${response.statusCode}');
    }
  }

  @override
  Future getApiResponse(String url, dynamic data) async {
    String queryString = '';
    String requestUrl = '';
    if (data == null) {
      requestUrl = url;
    } else {
      queryString = Uri(queryParameters: data).query;
      requestUrl = '$url?$queryString';
    }
    final headers = {"Accept": "application/json"};
    dynamic responseJson;
    try {
      final response = await http.get(Uri.parse(requestUrl), headers: headers);
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    print(responseJson);
    return responseJson;
  }

  @override
  Future getApiResponseWithToken(String url, data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token')!;
    String queryString = '';
    String requestUrl = '';
    if (data == null) {
      requestUrl = url;
    } else {
      queryString = Uri(queryParameters: data).query;
      requestUrl = '$url?$queryString';
    }
    final headers = {'Authorization': 'Bearer $token', "Accept": "application/json"};
    dynamic responseJson;
    try {
      final response = await http.get(Uri.parse(requestUrl), headers: headers);
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future<http.Response> postApiResponse(String url, dynamic data) async {
    dynamic responseJson;
    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
    try {
      final response = await http
          .post(Uri.parse(url), body: json.encode(data), headers: headers)
          .timeout(const Duration(seconds: 30));

      print(response);
      return responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } catch (e) {
      log('error$e');
    }
    return responseJson;
  }

  @override
  Future<http.Response> postApiResponseWithToken(String url, data) async {
    dynamic responseJson;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token')!;
    final headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      final response = await http
          .post(Uri.parse(url), body: json.encode(data), headers: headers)
          .timeout(const Duration(seconds: 30));
      return responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } catch (e) {
      log('error$e');
    }
    return responseJson;
  }

  @override
  Future postApiResponseWithTokenAndFile(String url, File file) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token')!;
    dynamic responseJson;
    final headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      var request = http.MultipartRequest("POST", Uri.parse(url));
      request.headers.addAll(headers);
      request.files.add(http.MultipartFile.fromBytes("picture", File(file.path).readAsBytesSync(),
          filename: file.path));
      var res = await request.send();
      if (res.statusCode == 200) {
        final resp = await http.Response.fromStream(res);
        return responseJson = returnResponse(resp);
      }
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } catch (e) {
      log('error$e');
    }

    return responseJson;
  }

  @override
  Future putApiResponse(String url, dynamic data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = await prefs.getString('token') ?? '';
    dynamic responseJson;
    final headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      final response = await http
          .put(Uri.parse(url), body: json.encode(data), headers: headers)
          .timeout(const Duration(seconds: 30));
      print(response.body);
      return responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } catch (e) {
      log('error$e');
    }
    return responseJson;
  }
}
