import 'package:dot_com/admin/subadmin/repository/subadmin_repository.dart';
import 'package:flutter/material.dart';

import '../../../utils/imagepicker.dart';
import '../repository/update_subadmin_model.dart';

class UpdateSubAdminViewModel extends ChangeNotifier{
  final int id;
  SubAdminRepository _repository = SubAdminRepository();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final pinCodeController = TextEditingController();
  bool isSubmitting = false;
  UpdateSubadminModel? subAdminDetails;
  bool isLoading = true;
  bool errorLoadingSubAdmin =false;
  UpdateSubAdminViewModel(this.id);
  bool isBlocked = false;
  bool isBlocking = false;
  getSubAdminDetails()async{

    setSubAdminLoading(true);
    final res = await _repository.getSubAdminById(subAdminId: id);
    await res.fold((l) {
      errorLoadingSubAdmin = true;
    }, (r) {
      subAdminDetails = r;
      initializeDetails(subAdminDetails!);
    });
    setSubAdminLoading(false);
  }

  setSubAdminLoading(bool value){
    isLoading = value;
    notifyListeners();
  }

  initializeDetails(UpdateSubadminModel subadmin){
    usernameController.text = subadmin.name;
    emailController.text = subadmin.email;
    passwordController.text = subadmin.password;
    phoneController.text = subadmin.mobileNo.toString();
    pinCodeController.text= subadmin.pincode.toString();
    isBlocked = subadmin.block;
    imageUrl = subadmin.profilePicUrl;
  }


  blockSubAdmin() async {
    isBlocking = true;
    notifyListeners();
    final res  = await _repository.blockSubAdminById(id: id,isBlocking: !isBlocked);
    await res.fold((l) =>{}, (r){
      isBlocked = !isBlocked;
      notifyListeners();
    });
    isBlocking = false;
    notifyListeners();
  }

  void updateSubAdmin(Function() onSuccess, Function(String) onFailure) async {
    isSubmitting = true;
    notifyListeners();
      String username = usernameController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();
      String phone = phoneController.text.trim();
      String pinCode = pinCodeController.text.trim();
      subAdminDetails!.name = username;
      subAdminDetails!.email = email;
      subAdminDetails!.password = password;
      subAdminDetails!.profilePicUrl = imageUrl;
      subAdminDetails!.mobileNo = int.parse(phone);
      subAdminDetails!.pincode = int.parse(pinCode);
      final res = await _repository.updateSubAdmin(data: subAdminDetails!);
      await res.fold((l) {
        onFailure(l.message);
      }, (r) {
        onSuccess();
      });
      isSubmitting = false;
      notifyListeners();

  }

  bool uploadingImage = false;
  String imageUrl = "";


  deleteImage() {
    this.imageUrl = "";
    notifyListeners();
  }

  setImage(String url) {
    this.imageUrl = url;
    notifyListeners();
  }

  selectImage() async {
    final response = await getImageFromGallery();
    response.fold((l) {}, (r) async {
      this.uploadingImage = true;
      notifyListeners();
      final imageResponse = await uploadImage(r);
      this.uploadingImage = false;
      notifyListeners();
      imageResponse.fold((l) {}, (r) {
        this.imageUrl = r;
        print(this.imageUrl);
        notifyListeners();
      });
    });
  }
}