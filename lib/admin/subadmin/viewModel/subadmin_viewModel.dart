import 'package:dot_com/admin/subadmin/repository/subadmin_repository.dart';
import 'package:flutter/material.dart';

import '../data/model/subadmin_model.dart';

class SubAdminViewModel extends ChangeNotifier{
  bool isLoading = true;
  SubAdminRepository _repository = SubAdminRepository();
  int page = 1;
  static int _pageSize = 10;
  bool isNoMore = false;
  List<SubAdminDto> subAdmins = [];
  bool isLoadingMore = false;

  getAllSubAdmins() async {
    setLoading(true);
    final res = await _repository.getAllSubAdmin(
        pageNo: page, pageSize: _pageSize, blocStatus: "unBlock");
    setLoading(false);
    res.fold((l) {}, (r) {
      subAdmins += r;
      page++;
      if (r.length < _pageSize) {
        this.isNoMore = true;
      }
      notifyListeners();
    });
  }

  setLoading(bool val){
    isLoading = val;
    notifyListeners();
  }


  Future<void> scrollListener(ScrollController scrollController) async {
    if (isLoadingMore || isNoMore) return;
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
        isLoadingMore = true;
        notifyListeners();
      await getAllSubAdmins();
        isLoadingMore = false;
      notifyListeners();
    }
  }

  Map<int, dynamic> blocking = {};
  blockUser(int id) async {
      blocking.addAll({id: "$id"});
      notifyListeners();
    // _repository.blockSubAdminById(id: id).then((value) {
    //   blocking.remove(id);
    //   value.fold((l) => {}, (r) {
    //     subAdmins.removeWhere((element) => element.id == id);
    //   });
    //   notifyListeners();
    // });
  }
}
