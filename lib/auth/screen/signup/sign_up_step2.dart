import 'package:dot_com/components/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

import '../../../components/color.dart';
import '../../../components/custom_loader.dart';
import '../../viewModel/auth_viewModel.dart';

class SignUpPage2 extends StatefulWidget {
  @override
  State<SignUpPage2> createState() => _SignUpPage2State();
}

class _SignUpPage2State extends State<SignUpPage2> {
  late CustomLoader _customLoader;
  @override
  void initState() {
    super.initState();
    _customLoader = CustomLoader(context: context);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print("build");
    return Scaffold(
      body: Consumer<AuthViewModel>(
        builder: (context, authViewModel, _) {
          return Container(
            color: AppColors.primaryThemeColor,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  color: Color(0xffFC5D5D),
                  child: SvgPicture.asset('assets/otp_screen.svg'),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Verify your mobile number', style: Text_Style.large()),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('OTP has been send to ', style: Text_Style.small()),
                          Text("+91${authViewModel.mobile_number}", style: Text_Style.small()),
                          GestureDetector(
                            onTap: () {
                              authViewModel.page = 1;
                            },
                            child: Text(
                              ' Change',
                              style: Text_Style.small(color: Colors.blue),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: Pinput(
                          length: 6,
                          androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsUserConsentApi,
                          defaultPinTheme: PinTheme(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                  border: Border.all(width: 2.0, color: Colors.grey),
                                  borderRadius: const BorderRadius.all(Radius.circular(8)))),
                          onCompleted: (pin) async {
                            authViewModel.closeDown();
                            _customLoader.createLoader();
                            await authViewModel.verifyOTP();
                            _customLoader.dismissLoader();
                            authViewModel.page = 3;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Didn\'t receive the code? ',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          authViewModel.isResendButtonEnabled
                              ? GestureDetector(
                                  onTap: () {
                                    authViewModel.startCountDown();
                                  },
                                  child: Text(
                                    "Resend OTP",
                                    style: Text_Style.small(color: Colors.blue),
                                  ),
                                )
                              : Text("Resend in ${authViewModel.countDown}")
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      // ElevatedButton(
                      //   style: ElevatedButton.styleFrom(
                      //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      //     backgroundColor: AppColors.primarySecondThemeColor,
                      //   ),
                      //   onPressed: () {
                      //     authViewModel.setPage(3);
                      //   },
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: [
                      //       Text('Verify OTP',
                      //           style: Text_Style.small(
                      //             color: Colors.white,
                      //           )),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
