import '../../../core/user/user_model.dart';
import 'package:flutter/material.dart';

import '../../../utils/imagepicker.dart';
import '../../profiles/repository/update_subadmin_profile_model.dart';
import '../repository/subadmin_home_repository.dart';
class UserSubAdminViewModel extends ChangeNotifier {
  SubAdminHomeRepository repository = SubAdminHomeRepository();

  UserDetails? user;

  bool isLoading = true;

  bool isSubmitting = false;
  bool error = false;
  UserSubAdminViewModel() {
    print("called");
    repository.getUserDetails().then((value) async {
      await value.fold((l) {
        error = true;
      }, (r) {
        this.user = r;
      });
      isLoading = false;
      notifyListeners();
    });
  }

  updateProfile(UpdateSubadminProfile userDetails,Function() onSuccess, Function(String) onFailure) async {
    isSubmitting = true;
    notifyListeners();
    userDetails.profilePicUrl = imageUrl;
    final response = await repository.updateUserDetails(userDetails);
    response.fold((l)  {
      onFailure(l.message);
    }, (r) {
      this.user = r;
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