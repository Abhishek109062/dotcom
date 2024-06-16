import 'package:dot_com/components/toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../components/color.dart';
import '../../../components/custom_loader.dart';
import '../../../components/formfields/formfields.dart';
import '../../../components/formfields/formfieldvalidators.dart';
import '../../../components/network_image_loader.dart';
import '../../../components/text_style.dart';
import '../../view_model/home_view_model.dart';
import 'package:image_picker/image_picker.dart' as ImagePick;

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  CustomFormFields _formFields = CustomFormFields();
  CustomFormFieldValidators _formFieldValidators = CustomFormFieldValidators();
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  FocusNode _fullNameFocus = FocusNode();
  FocusNode _emailFocus = FocusNode();

  void assignValues() {
    var provider = Provider.of<HomeViewModel>(context, listen: false);
    _fullNameController.text = provider.userDetails.name ?? '';
    _emailController.text = provider.userDetails.email ?? '';
  }

  late CustomLoader _customLoader;
  @override
  void initState() {
    _customLoader = CustomLoader(context: context);
    super.initState();
    assignValues();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(builder: (context, viewModel, child) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            'Edit Profile',
            style: Text_Style.large(color: Colors.grey),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 2, // Set the width of the border as needed
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3), // Adjust the shadow position as needed
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: NetworkImageLoader(
                            image: viewModel.userDetails.profilePicUrl ?? '',
                            width: 80,
                            height: 80,
                            fit: BoxFit.fill,
                            errorWidget: Image.asset("assets/person.jpg")),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 2,
                      child: GestureDetector(
                        onTap: () {
                          viewModel.getImage(ImagePick.ImageSource.gallery);
                        },
                        child: Container(
                          padding: EdgeInsets.all(4),
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: Offset(0, 3), // Adjust the shadow position as needed
                              ),
                            ],
                          ),
                          child: Center(
                            child: Icon(
                              Icons.camera_alt_outlined,
                              // You can use a different icon or SVG here
                              color: Colors.black,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                _formFields.textFieldWithSpace(
                    validator: (value) {
                      if (value == null || value == '') return "Full Name required";
                    },
                    label: 'Full Name',
                    controller: _fullNameController,
                    focusNode: _fullNameFocus),
                SizedBox(
                  height: 20,
                ),
                _formFields.emailField(
                    label: 'Email', controller: _emailController, focusNode: _emailFocus),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    backgroundColor: AppColors.primarySecondThemeColor,
                  ),
                  onPressed: () async {
                    // Toast.flushBarSuccessMessage('done');
                    if (_formKey.currentState!.validate()) {
                      _customLoader.createLoader();
                      await viewModel.updateUserDetails(
                        {'name': _fullNameController.text, 'email': _emailController.text},
                      );
                      _customLoader.dismissLoader();
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Update Profile',
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
      );
    });
  }
}
