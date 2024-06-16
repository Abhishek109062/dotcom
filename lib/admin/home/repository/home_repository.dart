import 'package:dot_com/admin/home/repository/admin_home_urls.dart';
import 'package:dot_com/client/api_model/auth_model.dart';
import 'package:fpdart/fpdart.dart';

import '../../../core/error/failure.dart';
import '../../../core/user/user_model.dart';
import '../../subadmin/data/datasources/subadmin_datasource_admin.dart';

class AdminHomeRepository {
  Future<Either<Failure, UserDetails>> getUserDetails() async {
    return await get<UserDetails>(
        onSuccess: (data) {
          return UserDetails.fromJson(data);
        },
        url: AdminHomeUrls.getUserProfile());
  }

  Future<Either<Failure, UserDetails>> updateUserDetails({required String username}) async {
    return await put<UserDetails>(
        onSuccess: (data) {
          return UserDetails.fromJson(data);
        },
        body: {"name": username},
        url: AdminHomeUrls.updateUserDetails());
  }
}
