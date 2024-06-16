import 'package:dot_com/admin/subadmin/presentation/widgets/text_field_subadmin.dart';
import 'package:dot_com/admin/subadmin/viewModel/update_subadmin_viewModel.dart';
import 'package:dot_com/components/customsnackbar.dart';
import 'package:dot_com/components/formfields/formfieldvalidators.dart';
import 'package:dot_com/components/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../../components/formfields/formfields.dart';
import '../../../snackbar_custom.dart';
import '../../repository/subadmin_repository.dart';

class UpdateSubadmin extends StatefulWidget {
  static Route<bool> route({required int id}) => MaterialPageRoute<bool>(
      builder: (_) => ChangeNotifierProvider(
        create: (BuildContext context) => UpdateSubAdminViewModel(id),
        child: UpdateSubadmin(),
      ));
  const UpdateSubadmin({Key? key}) : super(key: key);

  @override
  State<UpdateSubadmin> createState() => _UpdateSubadminState();
}

class _UpdateSubadminState extends State<UpdateSubadmin> {
  CustomFormFieldValidators customValidators = CustomFormFieldValidators();
  CustomFormFields _formFields = CustomFormFields();
  bool showPassword = false;
  final usernameFocusNode = FocusNode();
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final phoneFocusNode = FocusNode();
  final pinCodeFocusNode = FocusNode();

  // final districtFocusNode = FocusNode();
  // final addressFocusNode = FocusNode();
  // final stateFocusNode = FocusNode();
  // final cityFocusNode = FocusNode();
  // final districtController = TextEditingController();
  // final addressController = TextEditingController();
  // final stateController = TextEditingController();
  // final cityController = TextEditingController();
  final _formKey = GlobalKey<FormState>();



  CustomFormFieldValidators customValidator = CustomFormFieldValidators();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UpdateSubAdminViewModel>(context, listen: false).getSubAdminDetails();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        titleSpacing: 0,
        title: Text(
          "Sub-admin List / Update Sub-admin",
          style: Text_Style.medium(color: Color(0xFF6586A0)),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Consumer<UpdateSubAdminViewModel>(
            builder: (context, provider, child) {
              return AbsorbPointer(
                absorbing: provider.isSubmitting,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: (){
                            provider.selectImage();
                          },
                          child: Center(
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(60),
                                  border: Border.all(color: Color(0xffFC5D5D), width: 4)),
                              height: 120,
                              width: 120,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(60),
                                child: Image.network(provider.imageUrl,fit: BoxFit.fill,errorBuilder: (_,__,___){
                                  return Icon(Icons.person,size: 80,color: Colors.black,);
                                },),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextButton(
                            onPressed: () {
                              if(!provider.isBlocking){
                                provider.blockSubAdmin();
                              }
                            },
                            style: TextButton.styleFrom(
                                maximumSize: Size.fromHeight(50),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10))),
                                backgroundColor: provider.isBlocked ? Color(0xff00DBBE) : Color(0xffBB2222)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                provider.isBlocking
                                    ? Container(
                                  height: 16,
                                  width: 16,
                                  child: CircularProgressIndicator(color: Colors.white,),
                                )
                                    : Text(
                                 provider.isBlocked ? "Unblock":"Block",
                                  style:
                                  Text_Style.medium(fontWeight: FontWeight.w500, color: Colors.white),
                                ),
                              ],
                            )),
                        SizedBox(
                          height: 30,
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
                          controller: provider.usernameController,
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
                          controller: provider.emailController,
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
                          controller: provider.passwordController,
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
                          controller: provider.phoneController,
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
                          controller: provider.pinCodeController,
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
              );
            },
          ),
        ),
      ),
      bottomSheet: Consumer<UpdateSubAdminViewModel>(
        builder: (context, provider, child) {
          return Container(
            decoration:
            BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(0)),
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                    child: TextButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()){
                            provider.updateSubAdmin(() {
                              snackBarCustom(context, "SubAdmin Details Updated Successfully");
                            }, (String msg) => snackBarCustom(context, msg));
                          }
                        },
                        style: TextButton.styleFrom(
                            maximumSize: Size.fromHeight(44),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10))),
                            backgroundColor: Color(0xffFC5D5D)),
                        child: provider.isSubmitting
                            ? Container(
                          height: 16,
                          width: 16,
                          child: CircularProgressIndicator(color: Colors.white,),
                        )
                            : Text(
                          "Update SubAdmin",
                          style:
                          Text_Style.medium(fontWeight: FontWeight.w500, color: Colors.white),
                        )))
              ],
            ),
          );
        },
      ),
    );
  }
}
