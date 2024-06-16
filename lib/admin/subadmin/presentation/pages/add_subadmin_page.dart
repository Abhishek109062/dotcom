import 'package:dot_com/admin/subadmin/presentation/widgets/text_field_subadmin.dart';
import 'package:dot_com/components/customsnackbar.dart';
import 'package:dot_com/components/formfields/formfieldvalidators.dart';
import 'package:dot_com/components/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../components/formfields/formfields.dart';
import '../../../snackbar_custom.dart';
import '../../repository/subadmin_repository.dart';

class AddSubadmin extends StatefulWidget {
  static Route<bool> route() => MaterialPageRoute<bool>(builder: (context) => AddSubadmin());
  const AddSubadmin({Key? key}) : super(key: key);

  @override
  State<AddSubadmin> createState() => _AddSubadminState();
}

class _AddSubadminState extends State<AddSubadmin> {
  CustomFormFieldValidators customValidators = CustomFormFieldValidators();
  CustomFormFields _formFields = CustomFormFields();
  bool showPassword = false;
  final usernameFocusNode = FocusNode();
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final phoneFocusNode = FocusNode();
  final pinCodeFocusNode = FocusNode();
  final districtFocusNode = FocusNode();
  final addressFocusNode = FocusNode();
  final stateFocusNode = FocusNode();
  final cityFocusNode = FocusNode();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final pinCodeController = TextEditingController();
  final districtController = TextEditingController();
  final addressController = TextEditingController();
  final stateController = TextEditingController();
  final cityController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _profilePicture = "";
  bool isSubmitting = false;
  void submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        if (mounted) isSubmitting = true;
      });
      String username = usernameController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();
      String phone = phoneController.text.trim();
      String pinCode = pinCodeController.text.trim();
      // String district = districtController.text.trim();
      // String address = addressController.text.trim();
      // String state = stateController.text.trim();
      // String city = cityController.text.trim();
      await SubAdminRepository()
          .addSubAdmin(
              userName: username,
              email: email,
              password: password,
              state: "",
              address: "",
              city: "",
              district: "",
              phoneNo: phone,
              pinCode: pinCode,
              profilePicture: _profilePicture)
          .then((value) => value.fold((l) {
                snackBarCustom(context, "${l.message}");
              }, (r) {
                Navigator.of(context).pop(true);
              }));
      setState(() {
        if (mounted) isSubmitting = false;
      });
    }
  }
  CustomFormFieldValidators customValidator = CustomFormFieldValidators();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        titleSpacing: 0,
        title: Text(
          "Sub-admin List / Add Sub-admin",
          style: Text_Style.medium(color: Color(0xFF6586A0)),
        ),
      ),
      body: SafeArea(
        child: this.isSubmitting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(60),
                                border: Border.all(color: Color(0xffFC5D5D), width: 4)),
                            height: 120,
                            width: 120,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Username",
                          style: Text_Style.small(
                              color: Color(0xff333333), fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        TextFieldSubAdmin(
                          controller: usernameController,
                          title: "Username",
                          focusNode: usernameFocusNode,
                        ),
                        // _formFields.textFieldWithSpace(
                        //     controller: usernameController,
                        //     focusNode: usernameFocusNode,
                        //     prefix: Text(" "),
                        //     hintText: "Username",
                        //     label: "Username",
                        //     validator: (value) {
                        //       if (value == null || value.isEmpty) return "Username is required";
                        //       return null;
                        //     }),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Email",
                          style: Text_Style.small(
                              color: Color(0xff333333), fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        TextFieldSubAdmin(
                          controller: emailController,
                          title: "Email",
                          focusNode: emailFocusNode,
                          validator: customValidator.emailValidator,
                        ),
                        // _formFields.emailField(
                        //     controller: emailController,
                        //     focusNode: emailFocusNode,
                        //     hintText: "Email",
                        //     label: "Email"),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Password",
                          style: Text_Style.small(
                              color: Color(0xff333333), fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        TextFieldSubAdmin(
                          controller:passwordController,
                          title: "Password",
                          focusNode: passwordFocusNode,
                          validator: customValidator.passwordValidator,
                        ),
                        // _formFields.passwordField(
                        //     controller: passwordController, focusNode: passwordFocusNode),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Phone Number",
                          style: Text_Style.small(
                              color: Color(0xff333333), fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        TextFieldSubAdmin(
                          controller: phoneController,
                          title: "Phone Number",
                          focusNode: phoneFocusNode,
                          validator: customValidator.phoneNumberValidatorRequired,
                          inputFormatter: [FilteringTextInputFormatter.digitsOnly],
                          textInputType: TextInputType.phone,
                        ),
                        // _formFields.phoneNumberField(
                        //     label: 'Phone Number',
                        //     controller: phoneController,
                        //     focusNode: phoneFocusNode,
                        //     validator: customValidators.phoneNumberValidatorRequired),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Pincode",
                          style: Text_Style.small(
                              color: Color(0xff333333), fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        TextFieldSubAdmin(
                          controller: pinCodeController,
                          title: "Pincode",
                          focusNode: pinCodeFocusNode,
                          inputFormatter: [FilteringTextInputFormatter.digitsOnly],
                          textInputType: TextInputType.phone,
                        ),
                        // _formFields.pinCodeField(
                        //   label: "Pincode",
                        //   controller: pinCodeController,
                        //   focusNode: pinCodeFocusNode,
                        // ),
                        // SizedBox(
                        //   height: 20,
                        // ),
                        // _formFields.addressField(
                        //     label: "Address",
                        //     controller: addressController,
                        //     focusNode: addressFocusNode),
                        // SizedBox(
                        //   height: 20,
                        // ),
                        // _formFields.textFieldWithSpace(
                        //     label: "District",
                        //     controller: districtController,
                        //     focusNode: districtFocusNode,
                        //     validator: customValidators.districtValidator),
                        // SizedBox(
                        //   height: 20,
                        // ),
                        // _formFields.textFieldWithSpace(
                        //     label: "City",
                        //     controller: cityController,
                        //     focusNode: cityFocusNode,
                        //     validator: customValidators.cityValidator),
                        // SizedBox(
                        //   height: 20,
                        // ),
                        // _formFields.textFieldWithSpace(
                        //     label: "State",
                        //     controller: stateController,
                        //     focusNode: stateFocusNode,
                        //     validator: customValidators.stateValidator),
                        SizedBox(
                          height: 100,
                        )
                      ],
                    ),
                  ),
                ),
              ),
      ),
      bottomSheet: this.isSubmitting
          ? Container(
              height: 0,
            )
          : Container(
              decoration:
                  BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(0)),
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                      child: TextButton(
                          onPressed: () {
                            submitForm();
                          },
                          style: TextButton.styleFrom(
                              maximumSize: Size.fromHeight(44),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10))),
                              backgroundColor: Color(0xffFC5D5D)),
                          child: Text(
                            "Add SubAdmin",
                            style:
                                Text_Style.medium(fontWeight: FontWeight.w500, color: Colors.white),
                          )))
                ],
              ),
            ),
    );
  }
}
