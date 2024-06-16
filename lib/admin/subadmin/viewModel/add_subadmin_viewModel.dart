import 'package:flutter/material.dart';

import '../repository/subadmin_repository.dart';

class AddSubAdminViewModel with ChangeNotifier {
  bool isSubmitting = false;
  String profilePicture = "";

  addSubAdmin({
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
    await SubAdminRepository()
        .addSubAdmin(
            userName: userName,
            email: email,
            password: password,
            state: state,
            address: address,
            city: city,
            district: district,
            phoneNo: phoneNo,
            pinCode: pinCode,
            profilePicture: profilePicture)
        .then((value) => value.fold((l) {
              print(l);
              print(l.message);
              print("failute");
            }, (r) {
              // successSnackBar(msg: "UserCreated SuccessFully");
              print("Created success");
            }));
  }
  // final _auth = AuthRepository();
  // int _page = 1;
  // String _mobile_number = '';
  // int get page => _page;
  // late String _countDown = '00:00';
  // final int _otpTimeInMS = 1000 * 60;
  // late OTPCountDown _otpCountDown;
  // String get countDown => _countDown;
  // bool _isResendButtonEnabled = false;
  // bool get isResendButtonEnabled => _isResendButtonEnabled;
  // String get mobile_number => _mobile_number;
  // late AuthDetails _authData;
  // bool _isLoading = false;
  // late CustomLoader _customLoader;
  //
  // void initializeLoader(BuildContext context) {
  //   _customLoader = CustomLoader(context: context);
  // }
  //
  // void isLoading(bool value) {
  //   _isLoading = value;
  //   notifyListeners();
  // }
  //
  // set page(int value) {
  //   _page = value;
  //   notifyListeners();
  // }
  //
  // set mobile_number(String value) {
  //   _mobile_number = value;
  //   notifyListeners();
  // }
  //
  // void startCountDown() {
  //   _isResendButtonEnabled = false;
  //   notifyListeners();
  //   _otpCountDown = OTPCountDown.startOTPTimer(
  //     timeInMS: _otpTimeInMS,
  //     currentCountDown: (String countDown) {
  //       _countDown = countDown;
  //       print(_countDown);
  //       notifyListeners();
  //     },
  //     onFinish: () {
  //       _isResendButtonEnabled = true;
  //       notifyListeners();
  //     },
  //   );
  // }
  //
  // void closeDown() {
  //   _otpCountDown.cancelTimer();
  // }
  //
  // Future<void> login(String mobile, String password, BuildContext context) async {
  //   dynamic temp = await _auth.callSignInApi(mobile, password).then((value) async {
  //     print(value.body);
  //     _authData = AuthDetails.fromJson(jsonDecode(value.body));
  //     final SharedPreferences prefs = await SharedPreferences.getInstance();
  //     prefs.setString('token', _authData.jwt!);
  //     prefs.setString('role', _authData.usersDto!.role!);
  //     if (_authData.usersDto!.role == 'Customer') {
  //       Navigator.pushNamedAndRemoveUntil(context, Routes.ClientScreen, (route) => false);
  //     }
  //   }).catchError((e, StackTrace) {
  //     debugPrint("Error --${e.toString()}");
  //   });
  // }
  //
  // Future<void> sendOTP(String mobile) async {
  //   dynamic temp = await _auth.callSendOTPApi(mobile).then((value) {
  //     print(value.body);
  //     print(AuthDetails.fromJson(jsonDecode(value.body)));
  //     // _customLoader.dismissLoader();
  //   }).catchError((e, StackTrace) {
  //     debugPrint("Error --${e.toString()}");
  //   });
  //
  //   print("triggered");
  // }
  //
  // Future<void> verifyOTP() async {
  //   dynamic temp = await _auth.callVerifyOTPApi(_mobile_number, '', '').then((value) {
  //     print(value.body);
  //     // print(AuthDetails.fromJson(jsonDecode(value.body)));
  //   }).catchError((e, StackTrace) {
  //     debugPrint("Error --${e.toString()}");
  //   });
  // }
  //
  // Future<void> register(String password, BuildContext context) async {
  //   dynamic temp = await _auth
  //       .callRegisterApi({"mobileNo": _mobile_number, "password": password}).then((value) async {
  //     print(value.body);
  //     _authData = AuthDetails.fromJson(jsonDecode(value.body));
  //     final SharedPreferences prefs = await SharedPreferences.getInstance();
  //     prefs.setString('token', _authData.jwt!);
  //     prefs.setString('role', _authData.usersDto!.role!);
  //   }).catchError((e, StackTrace) {
  //     debugPrint("Error --${e.toString()}");
  //   });
  // }
  //
  // Future<void> updateCandidateDetails(Map<String, dynamic> data, BuildContext context) async {
  //   dynamic temp = await _auth.callUpdateCustomerDetailsApi(data).then((value) {
  //     UserDetails updatedData = UserDetails.fromJson(jsonDecode(value.body));
  //     _authData.usersDto = updatedData;
  //     Navigator.pushNamedAndRemoveUntil(context, Routes.ClientScreen, (route) => false);
  //   }).catchError((e, StackTrace) {
  //     debugPrint("Error --${e.toString()}");
  //   });
  //   ;
  // }
}
