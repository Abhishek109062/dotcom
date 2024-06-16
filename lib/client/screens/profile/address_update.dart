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
import '../../view_model/home_view_model.dart';

class AddressUpdate extends StatefulWidget {
  const AddressUpdate({super.key});

  @override
  State<AddressUpdate> createState() => _AddressUpdateState();
}

class _AddressUpdateState extends State<AddressUpdate> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  CustomFormFields _formFields = CustomFormFields();
  CustomFormFieldValidators _formFieldValidators = CustomFormFieldValidators();
  TextEditingController _stateController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _pincodeController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _districtController = TextEditingController();

  FocusNode _districtFocus = FocusNode();
  FocusNode _stateFocus = FocusNode();
  FocusNode _cityFocus = FocusNode();
  FocusNode _pincodeFocus = FocusNode();
  FocusNode _addressFocus = FocusNode();
  late CustomLoader _customLoader;
  initialValue(HomeViewModel authViewModel) {
    _addressController.text = authViewModel.userDetails.address ?? '';
    _districtController.text = authViewModel.userDetails.district ?? '';
    _pincodeController.text = (authViewModel.userDetails.pincode ?? '').toString();
    _stateController.text = authViewModel.userDetails.state ?? '';
    _cityController.text = authViewModel.userDetails.city ?? '';
  }

  @override
  void initState() {
    super.initState();
    _customLoader = CustomLoader(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(builder: (context, authViewModel, child) {
      initialValue(authViewModel);
      return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text(
            "Update Address",
            style: Text_Style.large(color: Colors.grey),
          ),
        ),
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
                    height: 40,
                  ),
                  locationBox('assets/india.svg', 'All India'),
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
                      label: 'Address', controller: _addressController, focusNode: _addressFocus),
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
                        await authViewModel.updateUserDetails({
                          "address": _addressController.text,
                          "state": _stateController.text,
                          "district": _districtController.text,
                          "pincode": _pincodeController.text,
                          "city": _cityController.text,
                        });
                        _customLoader.dismissLoader();
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Update Address',
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
