import 'dart:convert';

import 'package:dot_com/components/custom_loader.dart';
import 'package:dot_com/client/api_model/auth_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/otp_countdown.dart';
import '../../core/user/user_model.dart';
import '../../utils/routes.dart';
import '../repository/auth_repository.dart';

class AuthViewModel with ChangeNotifier {
  final _auth = AuthRepository();
  int _page = 1;
  String _mobile_number = '';
  int get page => _page;
  late String _countDown = '00:00';
  final int _otpTimeInMS = 1000 * 60;
  String password = "";
  late OTPCountDown _otpCountDown;
  String get countDown => _countDown;
  bool _isResendButtonEnabled = false;
  bool get isResendButtonEnabled => _isResendButtonEnabled;
  String get mobile_number => _mobile_number;
  late AuthDetails _authData;
  bool _isLoading = false;

  late CustomLoader _customLoader;

  void initializeLoader(BuildContext context) {
    _customLoader = CustomLoader(context: context);
  }

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  set page(int value) {
    _page = value;
    notifyListeners();
  }

  set mobile_number(String value) {
    _mobile_number = value;
    notifyListeners();
  }

  void startCountDown() {
    _isResendButtonEnabled = false;
    notifyListeners();
    _otpCountDown = OTPCountDown.startOTPTimer(
      timeInMS: _otpTimeInMS,
      currentCountDown: (String countDown) {
        _countDown = countDown;
        print(_countDown);
        notifyListeners();
      },
      onFinish: () {
        _isResendButtonEnabled = true;
        notifyListeners();
      },
    );
  }

  void closeDown() {
    _otpCountDown.cancelTimer();
  }

  Future<void> login(String mobile, String password, BuildContext context) async {
    isLoading = true;
    dynamic temp = await _auth.callSignInApi(mobile, password).then((value) async {
      print(value.body);
      _authData = AuthDetails.fromJson(jsonDecode(value.body));
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', _authData.jwt!);
      prefs.setString('role', _authData.usersDto!.role!);
      if (_authData.usersDto!.role == 'Customer') {
        Navigator.pushNamedAndRemoveUntil(context, Routes.ClientScreen, (route) => false);
      }
      if (_authData.usersDto!.role == 'Admin') {
        Navigator.pushNamedAndRemoveUntil(context, Routes.AdminScreen, (route) => false);
      }

      if (_authData.usersDto!.role == 'SubAdmin') {
        Navigator.pushNamedAndRemoveUntil(context, Routes.SubAdminScreen, (route) => false);
      }
    }).catchError((e, StackTrace) {
      debugPrint("Error --${e.toString()}");
    });
    isLoading = false;
  }

  Future<void> sendOTP(String mobile) async {
    isLoading = true;
    dynamic temp = await _auth.callSendOTPApi(mobile).then((value) {
      print(value.body);
      print(AuthDetails.fromJson(jsonDecode(value.body)));
      // _customLoader.dismissLoader();
    }).catchError((e, StackTrace) {
      debugPrint("Error --${e.toString()}");
    });

    print("triggered");
    isLoading = false;
  }

  Future<void> verifyOTP() async {
    isLoading = true;
    dynamic temp = await _auth.callVerifyOTPApi(_mobile_number, '', '').then((value) {
      print(value.body);
      // print(AuthDetails.fromJson(jsonDecode(value.body)));
    }).catchError((e, StackTrace) {
      debugPrint("Error --${e.toString()}");
    });
    isLoading = false;
  }

  Future<void> register(Map<String, dynamic> data) async {
    isLoading = true;
    dynamic temp = await _auth.callRegisterApi(data).then((value) async {
      print(value.body);
      _authData = AuthDetails.fromJson(jsonDecode(value.body));
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', _authData.jwt!);
      prefs.setString('role', _authData.usersDto!.role!);
    }).catchError((e, StackTrace) {
      debugPrint("Error --${e.toString()}");
    });
    isLoading = false;
  }

  Future<void> updateCandidateDetails(Map<String, dynamic> data, BuildContext context) async {
    dynamic temp = await _auth.callUpdateCustomerDetailsApi(data).then((value) {
      UserDetails updatedData = UserDetails.fromJson(jsonDecode(value.body));
      _authData.usersDto = updatedData;
      Navigator.pushNamedAndRemoveUntil(context, Routes.ClientScreen, (route) => false);
    }).catchError((e, StackTrace) {
      debugPrint("Error --${e.toString()}");
    });
    ;
  }
}
