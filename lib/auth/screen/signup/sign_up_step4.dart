import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../client/screens/home/client_home_page.dart';

import '../../../components/color.dart';
import '../../../components/custom_loader.dart';
import '../../../components/formfields/formfields.dart';
import '../../../components/formfields/formfieldvalidators.dart';
import '../../../components/location_box.dart';
import '../../../components/text_style.dart';
import '../../../utils/routes.dart';
import '../../viewModel/auth_viewModel.dart';

class SignUpPage4 extends StatefulWidget {
  const SignUpPage4({super.key});

  @override
  State<SignUpPage4> createState() => _SignUpPage4State();
}

class _SignUpPage4State extends State<SignUpPage4> {
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

  FocusNode _nameFocus = FocusNode();
  FocusNode _emailFocus = FocusNode();
  FocusNode _stateFocus = FocusNode();
  FocusNode _cityFocus = FocusNode();
  FocusNode _pincodeFocus = FocusNode();
  FocusNode _addressFocus = FocusNode();
  FocusNode _districtFocus = FocusNode();

  late CustomLoader _customLoader;
  @override
  void initState() {
    super.initState();
    _customLoader = CustomLoader(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthViewModel>(builder: (context, authViewModel, child) {
      return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          width: double.infinity,
          padding: EdgeInsets.all(8),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  locationBox('assets/india.svg', 'All India'),
                  SizedBox(
                    height: 20,
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
                    height: 20,
                  ),
                  _formFields.emailField(
                    controller: _emailController,
                    focusNode: _emailFocus,
                    label: 'Email',
                  ),
                  SizedBox(
                    height: 20,
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
                    height: 20,
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
                    height: 20,
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
                    height: 20,
                  ),
                  _formFields.pinCodeField(
                      label: 'Pincode', controller: _pincodeController, focusNode: _pincodeFocus),
                  SizedBox(
                    height: 20,
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
                    height: 20,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      backgroundColor: AppColors.primarySecondThemeColor,
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _customLoader.createLoader();
                        await authViewModel.register({
                          "name": _nameController.text,
                          "mobileNo": authViewModel.mobile_number,
                          "email": _emailController.text,
                          "password": authViewModel.password,
                          "address": _addressController.text,
                          "state": _stateController.text,
                          "district": _districtController.text,
                          "pincode": _pincodeController.text,
                          "city": _cityController.text,
                        });

                        // await authViewModel.updateCandidateDetails({
                        //   "mobileNo": authViewModel.mobile_number,
                        //   "password": authViewModel.password,
                        //   'address': _addressController.text,
                        //   'state': _stateController.text,
                        //   'pincode': _pincodeController.text,
                        //   'city': _cityController.text,
                        // }, context);
                        _customLoader.dismissLoader();

                        Navigator.pushNamedAndRemoveUntil(
                            context, Routes.ClientScreen, (route) => false);
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Done',
                            style: Text_Style.small(
                              color: Colors.white,
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
