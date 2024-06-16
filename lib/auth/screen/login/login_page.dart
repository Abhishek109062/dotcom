import 'package:dot_com/auth/screen/signup/sign_up_page.dart';
import 'package:dot_com/client/screens/home/client_home_page.dart';
import 'package:dot_com/components/color.dart';
import 'package:dot_com/components/custom_loader.dart';
import 'package:dot_com/components/customsnackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../components/formfields/formfields.dart';
import '../../../components/formfields/formfieldvalidators.dart';
import '../../../components/text_style.dart';
import '../../../utils/routes.dart';
import '../../viewModel/auth_viewModel.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  CustomFormFields _formFields = CustomFormFields();
  CustomFormFieldValidators _formFieldValidators = CustomFormFieldValidators();
  TextEditingController _phoneController = TextEditingController();
  FocusNode _passwordFocus = FocusNode();
  FocusNode _phoneFocus = FocusNode();
  TextEditingController _passwordController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late CustomLoader _customLoader;

  void checkAlreadyLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String role = prefs.getString('role')!;
    if (role == 'Customer') {
      Navigator.pushNamedAndRemoveUntil(context, Routes.ClientScreen, (route) => false);
    } else if (role == 'Admin') {
      Navigator.pushNamedAndRemoveUntil(context, Routes.AdminScreen, (route) => false);
    } else if (role == 'SubAdmin') {
      Navigator.pushNamedAndRemoveUntil(context, Routes.SubAdminScreen, (route) => false);
    } else {}
  }

  @override
  void initState() {
    super.initState();
    _customLoader = CustomLoader(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthViewModel>(
      builder: (_, viewModel, child) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          body: SingleChildScrollView(
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
                        Row(
                          children: [
                            Text(
                              'Login',
                              style: Text_Style.large(),
                            ),
                            Spacer(),
                            Center(
                                child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamedAndRemoveUntil(
                                    context, Routes.ClientScreen, (route) => false);
                              },
                              child: Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: AppColors.primarySecondThemeColor,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Text(
                                    "Skip Login",
                                    style: Text_Style.small(color: Colors.white),
                                  )),
                            )),
                          ],
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
                        _formFields.passwordField(
                            controller: _passwordController, focusNode: _passwordFocus),
                        SizedBox(
                          height: 4,
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Text('Forgot Password?'),
                        ),
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
                              // _customLoader.createLoader();
                              viewModel.login(
                                  _phoneController.text, _passwordController.text, context);
                              // _customLoader.dismissLoader();
                            }
                            // Navigator.push(
                            //     context, MaterialPageRoute(builder: (context) => ClientHome()));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              viewModel.isLoading
                                  ? CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : Text('Login',
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
                              'Dont hava an account? ',
                              style: Text_Style.small(),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacementNamed(context, Routes.SignUpScreen);
                                // Navigator.push(
                                //     context, MaterialPageRoute(builder: (context) => SignUpPage()));
                              },
                              child: Text(
                                'Create an account',
                                style: Text_Style.small(color: Color(0xffFC5D5D)),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
