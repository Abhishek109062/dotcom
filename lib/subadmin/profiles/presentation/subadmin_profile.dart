import 'package:dot_com/components/formfields/formfieldvalidators.dart';
import 'package:dot_com/core/user/user_model.dart';
import 'package:dot_com/subadmin/home/viewModel/user_subadmin_viewModel.dart';
import 'package:dot_com/subadmin/profiles/presentation/widgets/text_field_profile.dart';
import 'package:dot_com/subadmin/profiles/repository/update_subadmin_profile_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../admin/snackbar_custom.dart';
import '../../../components/text_style.dart';
import '../../../utils/routes.dart';

class SubAdminProfile extends StatefulWidget {
  const SubAdminProfile({super.key});

  static route() => MaterialPageRoute(builder: (context) => SubAdminProfile());

  @override
  State<SubAdminProfile> createState() => _SubAdminProfileState();
}

class _SubAdminProfileState extends State<SubAdminProfile> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();

  FocusNode usernameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode pincodeFocusNode = FocusNode();
  FocusNode districtFocusNode = FocusNode();
  FocusNode addressFocusNode = FocusNode();
  FocusNode cityFocusNode = FocusNode();
  FocusNode stateFocusNode = FocusNode();
  FocusNode contactNumberFocusNode = FocusNode();

  void initializeValues(UserDetails user) {
    usernameController.text = user.name ?? "";
    emailController.text = user.email ?? "";
    pincodeController.text = user.pincode.toString() ?? "";
    districtController.text = user.district ?? "";
    addressController.text = user.address ?? "";
    cityController.text = user.city ?? "";
    stateController.text = user.state ?? "";
    contactNumberController.text = user.mobileNo.toString();
    Provider.of<UserSubAdminViewModel>(context, listen: false).setImage(user.profilePicUrl ?? "");
  }

  CustomFormFieldValidators customValidator = CustomFormFieldValidators();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initializeValues(Provider.of<UserSubAdminViewModel>(context, listen: false).user!);
    });
    super.initState();
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    pincodeController.dispose();
    districtController.dispose();
    addressController.dispose();
    cityController.dispose();
    stateController.dispose();
    contactNumberController.dispose();

    usernameFocusNode.dispose();
    emailFocusNode.dispose();
    pincodeFocusNode.dispose();
    districtFocusNode.dispose();
    addressFocusNode.dispose();
    cityFocusNode.dispose();
    stateFocusNode.dispose();
    contactNumberFocusNode.dispose();

    super.dispose();
  }

  submitForm() async {
    UpdateSubadminProfile updatedUser = UpdateSubadminProfile();
    updatedUser.name = usernameController.text.trim();
    updatedUser.mobileNo = int.parse(contactNumberController.text.trim());
    updatedUser.state = stateController.text.trim();
    updatedUser.city = cityController.text.trim();
    updatedUser.address = addressController.text.trim();
    updatedUser.district = districtController.text.trim();
    updatedUser.pincode = int.parse(pincodeController.text.trim());
    updatedUser.email = emailController.text.trim();
    await Provider.of<UserSubAdminViewModel>(context, listen: false).updateProfile(updatedUser, () {
      snackBarCustom(context, "User Details Updated Successfully");
    }, (String msg) => snackBarCustom(context, msg));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        titleSpacing: 0,
        title: Text(
          "SubAdmin Profile",
          style: Text_Style.medium(color: Color(0xFF6586A0)),
        ),
      ),
      body: Consumer<UserSubAdminViewModel>(
        builder: (context, provider, child) {
          return SafeArea(
            child:
                SingleChildScrollView(
              child: AbsorbPointer(
                absorbing: provider.isSubmitting,
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
                        height: 40,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          "Username",
                          style: Text_Style.small(
                              color: Color(0xff333333), fontWeight: FontWeight.w400),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: TextFieldProfile(
                          controller: usernameController,
                          title: "Username",
                          focusNode: usernameFocusNode,
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          "Email",
                          style: Text_Style.small(
                              color: Color(0xff333333), fontWeight: FontWeight.w400),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: TextFieldProfile(
                          controller: emailController,
                          title: "Email",
                          focusNode: emailFocusNode,
                          validator: customValidator.emailValidator,
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          "Phone Number",
                          style: Text_Style.small(
                              color: Color(0xff333333), fontWeight: FontWeight.w400),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: TextFieldProfile(
                          controller: contactNumberController,
                          title: "Phone Number",
                          focusNode: contactNumberFocusNode,
                          validator: customValidator.phoneNumberValidatorRequired,
                          inputFormatter: [FilteringTextInputFormatter.digitsOnly],
                          textInputType: TextInputType.phone,
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          "Pincode",
                          style: Text_Style.small(
                              color: Color(0xff333333), fontWeight: FontWeight.w400),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: TextFieldProfile(
                          controller: pincodeController,
                          title: "Pincode",
                          focusNode: pincodeFocusNode,
                          inputFormatter: [FilteringTextInputFormatter.digitsOnly],
                          textInputType: TextInputType.phone,
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          "District",
                          style: Text_Style.small(
                              color: Color(0xff333333), fontWeight: FontWeight.w400),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: TextFieldProfile(
                          controller: districtController,
                          title: "District",
                          focusNode: districtFocusNode,
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          "Address",
                          style: Text_Style.small(
                              color: Color(0xff333333), fontWeight: FontWeight.w400),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: TextFieldProfile(
                          controller: addressController,
                          title: "Address",
                          focusNode: addressFocusNode,
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          "City",
                          style: Text_Style.small(
                              color: Color(0xff333333), fontWeight: FontWeight.w400),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: TextFieldProfile(
                          controller: cityController,
                          title: "City",
                          focusNode: cityFocusNode,
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          "State",
                          style: Text_Style.small(
                              color: Color(0xff333333), fontWeight: FontWeight.w400),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: TextFieldProfile(
                          controller: stateController,
                          title: "State",
                          focusNode: stateFocusNode,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: TextButton(
                            onPressed: () async {
                              final SharedPreferences prefs = await SharedPreferences.getInstance();
                              prefs.clear();
                              Navigator.pushNamed(context, Routes.loginScreen);
                            },
                            style: TextButton.styleFrom(
                                padding: EdgeInsets.all(16),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    side: BorderSide(color: Color(0xffFED7C7))),
                                backgroundColor: Colors.white),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                provider.isSubmitting
                                    ? Container(
                                        height: 16,
                                        width: 16,
                                        child: CircularProgressIndicator(),
                                      )
                                    : Text(
                                        "Logout",
                                        style: Text_Style.medium(
                                            fontWeight: FontWeight.w500, color: Color(0xff333333)),
                                      ),
                              ],
                            )),
                      ),
                      SizedBox(
                        height: 100,
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
      bottomSheet: Consumer<UserSubAdminViewModel>(
        builder: (context, provider, child) {
          return Container(
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(0)),
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                    child: TextButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await submitForm();
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
                                child: CircularProgressIndicator(),
                              )
                            : Text(
                                "Save Changes",
                                style: Text_Style.medium(
                                    fontWeight: FontWeight.w500, color: Colors.white),
                              )))
              ],
            ),
          );
        },
      ),
    );
  }
}
