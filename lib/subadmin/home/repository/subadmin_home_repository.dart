import 'package:dot_com/subadmin/home/repository/subadmin_home_url.dart';
import 'package:dot_com/subadmin/profiles/repository/update_subadmin_profile_model.dart';
import 'package:fpdart/fpdart.dart';

import '../../../admin/subadmin/data/datasources/subadmin_datasource_admin.dart';
import '../../../core/error/failure.dart';
import '../../../core/user/user_model.dart';

class SubAdminHomeRepository {
  Future<Either<Failure, UserDetails>> getUserDetails() async {
    return await get<UserDetails>(
        onSuccess: (data) {
          return UserDetails.fromJson(data);
        },
        url:SubAdminHomeURLs.getUserProfile());
  }

  Future<Either<Failure, UserDetails>> updateUserDetails(UpdateSubadminProfile user) async {
    return await put<UserDetails>(
        onSuccess: (data) {
          return UserDetails.fromJson(data);
        },
        body: user.toJson(),
        url: SubAdminHomeURLs.updateUserDetails());
  }
}