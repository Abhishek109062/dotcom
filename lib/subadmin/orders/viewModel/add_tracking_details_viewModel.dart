import 'package:dot_com/core/feature/order/repository/order_repository_admin.dart';
import 'package:flutter/material.dart';

class AddTrackingDetailsViewModel extends ChangeNotifier{
  final int orderId;
  bool isSubmitting = false;
  TextEditingController linkController = TextEditingController();
  TextEditingController trackingIdController = TextEditingController();
  TextEditingController serviceProviderController = TextEditingController();

  OrderRepositoryAdmin _repository = OrderRepositoryAdmin();

  AddTrackingDetailsViewModel({required this.orderId});

  bool getAddBtnStatus(){
    if(linkController.text !="" && trackingIdController.text !="" && serviceProviderController.text !="" && isSubmitting==false){
      return true;
    }
    return false;
  }

  void updateTrackingDetails(Function() onSuccess, Function(String) onFailure)async{
    isSubmitting = true;
    notifyListeners();
    int trackingId = int.parse(trackingIdController.text);
    String link = linkController.text;
    String serviceProvider = serviceProviderController.text;
    final res = await _repository.updateOrderById(orderId: orderId, updatedDetails: {
      "trackingId": trackingId,
      "trackingLink": link,
      "trackingServiceProvider": serviceProvider
    });
    await res.fold((l) {
      onFailure(l.message);
    }, (r) {
      onSuccess();
    });
    isSubmitting = false;
    notifyListeners();
  }

}