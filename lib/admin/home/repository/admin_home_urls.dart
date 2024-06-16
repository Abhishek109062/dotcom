import 'package:dot_com/constants.dart';

class AdminHomeUrls{
  static getUserProfile() => "${ApiConstants.baseUrl}/admin/getAdminProfile";
  static updateUserDetails() => "${ApiConstants.baseUrl}/admin/updateAdmin";
}