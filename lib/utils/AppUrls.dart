import '../constants.dart';

class AppUrls {
  String login = ApiConstants.baseUrl + '/dotCom/login?contactNumber=9627091792&password=Admin@123';
  String register = ApiConstants.baseUrl + '/dotCom/signUp';
  String sendOTP = ApiConstants.baseUrl + '/dotCom/sendOTP?contactNumber=9627091792';
  String updateCustomerDetails = ApiConstants.baseUrl + '/customer/updateCustomerDetails';
  String verifyOTP =
      ApiConstants.baseUrl + '/dotCom/verifyOTP?contactNumber=9627091792&otp=9568&validationHash';
}
