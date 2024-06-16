import 'package:dot_com/admin/home/repository/home_repository.dart';
import 'package:dot_com/core/error/failure.dart';
import 'package:dot_com/client/api_model/auth_model.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';

import '../../../core/user/user_model.dart';

class UserAdminViewModel extends ChangeNotifier {
  AdminHomeRepository repository = AdminHomeRepository();

  UserDetails? user;

  bool isLoading = true;

  bool error = false;
  UserAdminViewModel() {
    print("called");
    repository.getUserDetails().then((value) {
      value.fold((l) {
        error = true;
      }, (r) {
        this.user = r;
      });
      isLoading = false;
      notifyListeners();
    });
  }

  updateProfile({required String username}) async {
    final response = await repository.updateUserDetails(username: username);
    response.fold((l) => {print("error updating")}, (r) {
      this.user = r;
    });
    notifyListeners();
  }
}
