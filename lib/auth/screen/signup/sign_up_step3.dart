import 'package:dot_com/components/custom_loader.dart';
import 'package:dot_com/components/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../components/color.dart';
import '../../../components/formfields/formfields.dart';
import '../../../components/formfields/formfieldvalidators.dart';
import '../../viewModel/auth_viewModel.dart';

class SignUpPage3 extends StatefulWidget {
  @override
  State<SignUpPage3> createState() => _SignUpPage3State();
}

class _SignUpPage3State extends State<SignUpPage3> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  CustomFormFields _formFields = CustomFormFields();
  CustomFormFieldValidators _formFieldValidators = CustomFormFieldValidators();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _stateController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _pincodeController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _districtController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _password2Controller = TextEditingController();

  FocusNode _nameFocus = FocusNode();
  FocusNode _emailFocus = FocusNode();
  FocusNode _stateFocus = FocusNode();
  FocusNode _cityFocus = FocusNode();
  FocusNode _pincodeFocus = FocusNode();
  FocusNode _addressFocus = FocusNode();
  FocusNode _districtFocus = FocusNode();

  FocusNode _passwordFocus = FocusNode();
  FocusNode _password2Focus = FocusNode();

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
      resizeToAvoidBottomInset: false,
      body: Consumer<AuthViewModel>(
        builder: (context, authViewModel, child) {
          return Container(
            color: AppColors.primaryThemeColor,
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
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
                          Text('Create Account', style: Text_Style.large()),
                          SizedBox(
                            height: 12,
                          ),
                          _formFields.passwordField(
                              controller: _passwordController, focusNode: _passwordFocus),
                          SizedBox(
                            height: 20,
                          ),
                          _formFields.passwordField(
                              validator: (value) {
                                if (value != _passwordController.text)
                                  return 'Password does not match';
                              },
                              label: 'Confirm Password',
                              hintText: 'Confirm Password',
                              controller: _password2Controller,
                              focusNode: _password2Focus),
                          SizedBox(
                            height: 16,
                          ),
                          _formFields.textFieldWithSpace(
                              validator: (value) {
                                if (value == null || value.isEmpty || value.trim() == '')
                                  return 'Enter Full Name';
                              },
                              label: 'Full Name',
                              controller: _nameController,
                              focusNode: _nameFocus),
                          SizedBox(
                            height: 16,
                          ),
                          _formFields.emailField(
                            controller: _emailController,
                            focusNode: _emailFocus,
                            label: 'Email',
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          _formFields.textFieldWithSpace(
                              validator: (value) {
                                if (value == null || value.isEmpty || value.trim() == '')
                                  return 'Enter State';
                              },
                              label: 'State',
                              controller: _stateController,
                              focusNode: _stateFocus),
                          SizedBox(
                            height: 16,
                          ),
                          _formFields.textFieldWithSpace(
                              validator: (value) {
                                if (value == null || value.isEmpty || value.trim() == '')
                                  return 'Enter City';
                              },
                              label: 'City',
                              controller: _cityController,
                              focusNode: _cityFocus),
                          SizedBox(
                            height: 16,
                          ),
                          _formFields.textFieldWithSpace(
                              validator: (value) {
                                if (value == null || value.isEmpty || value.trim() == '')
                                  return 'Enter District';
                              },
                              label: 'District',
                              controller: _districtController,
                              focusNode: _districtFocus),
                          SizedBox(
                            height: 16,
                          ),
                          _formFields.pinCodeField(
                              label: 'Pincode',
                              controller: _pincodeController,
                              focusNode: _pincodeFocus),
                          SizedBox(
                            height: 16,
                          ),
                          _formFields.addressField(
                              validator: (value) {
                                if (value == null || value.isEmpty || value.trim() == '')
                                  return 'Enter address';
                              },
                              label: 'Address',
                              controller: _addressController,
                              focusNode: _addressFocus),
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
                              shape:
                                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              backgroundColor: AppColors.primarySecondThemeColor,
                            ),
                            onPressed: () async {
                              if (!authViewModel.isLoading && _formKey.currentState!.validate()) {
                                authViewModel.password = _passwordController.text;
                                // await authViewModel.register(_passwordController.text, context);
                                // _customLoader.createLoader();
                                //
                                // _customLoader.dismissLoader();
                                authViewModel.page = 4;
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                authViewModel.isLoading
                                    ? CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                    : Text('Create Account',
                                        style: Text_Style.small(
                                          color: Colors.white,
                                        )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
