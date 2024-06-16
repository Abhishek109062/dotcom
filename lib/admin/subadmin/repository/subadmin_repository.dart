import 'package:dot_com/admin/subadmin/data/model/subadmin_model.dart';
import 'package:dot_com/admin/subadmin/repository/subadmin_urls.dart';
import 'package:dot_com/admin/subadmin/repository/update_subadmin_model.dart';
import 'package:dot_com/core/services/network_api_service.dart';
import 'package:dot_com/utils/AppUrls.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;

import '../../../constants.dart';
import '../../../core/error/failure.dart';
import '../data/datasources/subadmin_datasource_admin.dart';

class SubAdminRepository {
  NetworkApiService _apiService = NetworkApiService();

  // Future<http.Response> callSignInApi(String mobile, String password) async {
  //   try {
  //     final response = await _apiService.getApiResponse(
  //         AppUrls()
  //             .login
  //             .replaceAll('9627091792', mobile)
  //             .replaceAll('Admin@123', password),
  //         null);
  //
  //     print(response);
  //     return response;
  //   } catch (e) {
  //     throw Exception(e);
  //   }
  // }
  //
  Future<Either<Failure, Map<String, dynamic>>> addSubAdmin({
    required String userName,
    required String email,
    required String password,
    required String phoneNo,
    required String pinCode,
    required String district,
    required String address,
    required String state,
    required String profilePicture,
    required String city,
  }) async {
    print("add called");
    return await post<Map<String, dynamic>>(
        onSuccess: (data) {
          return data;
        },
        url: "${ApiConstants.baseUrl}/admin/addSubAdmin",
        body: {
          "name": userName,
          "email": email,
          "password": password,
          "mobileNo": phoneNo,
          "pincode": pinCode,
          "district": district,
          "address": address,
          "state": state,
          "profilePicUrl": profilePicture,
          "city": city,
        });
  }

  Future<Either<Failure, Map<String, dynamic>>> updateSubAdmin(
      {required UpdateSubadminModel data}) async {
    return await put<Map<String, dynamic>>(
        onSuccess: (data) {
          return data;
        },
        url: SubAdminApiURLs.updateSubAdminDetails(),
        body: data.toJson());
  }

  Future<Either<Failure, UpdateSubadminModel>> getSubAdminById({required int subAdminId}) async {

    return await get<UpdateSubadminModel>(
        onSuccess: (data) {
          return UpdateSubadminModel.fromJson(data);
        },
        url: SubAdminApiURLs.getSubAdminById(id: subAdminId));
  }

  Future<Either<Failure, List<SubAdminDto>>> getAllSubAdmin(
      {required int pageNo,
      required int pageSize,
      required String blocStatus,
      String? searchString}) async {
    return await post<List<SubAdminDto>>(
        onSuccess: (data) {
          return subAdminDtoFromJson(data);
        },
        body: {},
        url: SubAdminApiURLs.getAllSubAdmin(
            pageNo: pageNo,
            pageSize: pageSize,
            blocStatus: blocStatus,
            searchString: searchString));
  }

  Future<Either<Failure, String>> blockSubAdminById({
    required int id,required bool isBlocking
  }) async {
    return await put<String>(
        onSuccess: (data) {
          return data;
        },
        body: {},
        url: SubAdminApiURLs.blocSubAdminById(id: id,isBlocking: isBlocking));
  }

  //
  // Future<http.Response> callSendOTPApi(String mobile) async {
  //   try {
  //     final response =
  //         await _apiService.getPostApiResponse(AppUrls().sendOTP, null);
  //     return response;
  //   } catch (e) {
  //     throw Exception(e);
  //   }
  // }
  //
  // Future<http.Response> callVerifyOTPApi(
  //     String mobile, String otp, String validationHash) async {
  //   try {
  //     final response =
  //         await _apiService.getPostApiResponse(AppUrls().verifyOTP, null);
  //     return response;
  //   } catch (e) {
  //     throw Exception(e);
  //   }
  // }
  //
  // Future<http.Response> callUpdateCustomerDetailsApi(
  //     Map<String, dynamic> data) async {
  //   try {
  //     final response = await _apiService.getPutApiResponse(
  //         AppUrls().updateCustomerDetails, data);
  //     return response;
  //   } catch (e) {
  //     throw Exception(e);
  //   }
  // }
}
