import 'package:dot_com/client/screens/home/client_home_page.dart';

import 'package:dot_com/components/color.dart';
import 'package:dot_com/components/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:passwordfield/passwordfield.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:provider/provider.dart';

import '../../../components/formfields/formfields.dart';
import '../../../components/formfields/formfieldvalidators.dart';
import '../../../components/text_style.dart';
import '../../../utils/routes.dart';

import '../../viewModel/auth_viewModel.dart';
import '../login/login_page.dart';

class SignUpPage1 extends StatefulWidget {
  const SignUpPage1({super.key});

  @override
  State<SignUpPage1> createState() => _SignUpPage1State();
}

class _SignUpPage1State extends State<SignUpPage1> {
  CustomFormFields _formFields = CustomFormFields();
  CustomFormFieldValidators _formFieldValidators = CustomFormFieldValidators();
  TextEditingController _phoneController = TextEditingController();
  FocusNode _phoneFocus = FocusNode();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late CustomLoader _customLoader;
  @override
  void initState() {
    super.initState();
    _customLoader = CustomLoader(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Consumer<AuthViewModel>(
        builder: (context, viewModel, child) {
          return Container(
            color: AppColors.primaryThemeColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  color: Color(0xffFC5D5D),
                  child: SvgPicture.asset('assets/login.svg'),
                ),
                Container(
                  color: Color(0xffFFFBF3),
                  padding: EdgeInsets.all(12),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Sign Up',
                          style: Text_Style.large(),
                        ),
                        SizedBox(height: 16),
                        _formFields.phoneNumberField(
                            label: 'Phone Number',
                            controller: _phoneController,
                            focusNode: _phoneFocus,
                            validator: _formFieldValidators.phoneNumberValidatorRequired),
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                          "By proceeding you agree with Company's terms and conditions and privacy policy",
                          style: Text_Style.small(),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            backgroundColor: AppColors.primarySecondThemeColor,
                          ),
                          onPressed: () async {
                            if (!viewModel.isLoading && _formKey.currentState!.validate()) {
                              viewModel.startCountDown();
                              _customLoader.createLoader();
                              await viewModel.sendOTP(_phoneController.text);
                              _customLoader.dismissLoader();
                              viewModel.mobile_number = _phoneController.text;
                              viewModel.page = 2;
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              viewModel.isLoading
                                  ? CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : Text('Send OTP',
                                      style: Text_Style.small(
                                        color: Colors.white,
                                      )),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already hava an account? ',
                              style: Text_Style.small(),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacementNamed(context, Routes.loginScreen);
                              },
                              child: Text(
                                'Log in',
                                style: Text_Style.small(color: Color(0xffFC5D5D)),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
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
