import 'package:dot_com/admin/advertisement/repository/advertisement_detail_model.dart';
import 'package:flutter/material.dart';

import '../repository/advertisement_repository.dart';

class AdvertisementViewModel extends ChangeNotifier {
  AdvertisementRepository _advertisementRepository = AdvertisementRepository();
  int pageNo = 1;
  int pageSize = 10;
  bool isNoMore = false;
  bool isLoading = false;
  bool isLoadingMore = false;
  bool error = false;
  List<AdvertisementDetailsDto> advertisements = [];
  void getAdvertisements() async {
    this.isLoading = true;
    notifyListeners();
    final response = await _advertisementRepository.getAllAdvertisements(
        pageNo: pageNo, pageSize: pageSize);
    response.fold((l) {
      error = true;
    }, (r) {
      advertisements += r;
      pageNo++;
      if (r.length < pageSize) {
        this.isNoMore = true;
      }
    });
    this.isLoading = false;
    notifyListeners();
  }


  reloadPage(){
    pageNo = 1;
    isNoMore = false;
    advertisements = [];
    isLoading = false;
    isLoadingMore = false;
    error = false;
    getAdvertisements();
  }

  Future<bool> deleteAdvertisement(int id) async {
   bool res = await delete(id);
   reloadPage();
   return res;
  }

  Future<bool> delete(int id) async{
    final response = await _advertisementRepository.deleteAdvertisement(id: id);
    return await response.fold((l) => false, (r) => true);
  }
}
