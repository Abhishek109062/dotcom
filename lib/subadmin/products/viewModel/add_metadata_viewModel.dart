
import 'package:flutter/material.dart';

import '../../../utils/imagepicker.dart';
import '../repository/add_product_metadata_model.dart';
import '../repository/product_repository.dart';

class AddMetadataViewModel extends ChangeNotifier{
  final int productId;
  AddMetadataViewModel({required this.productId});
  ProductRepository _productRepository = ProductRepository();
  bool addingMetadata = false;

  TextEditingController sizeController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController priceController = TextEditingController();


  FocusNode sizeFocusNode = FocusNode();
  FocusNode colorFocusNode = FocusNode();
  FocusNode quantityFocusNode = FocusNode();
  FocusNode priceFocusNode = FocusNode();


  List<String> selectedImages = [];
  bool uploadingImage = false;



  selectImage() async {
    final response = await getImageFromGallery();
    response.fold((l) {}, (r) async {
      this.uploadingImage = true;
      notifyListeners();
      final imageResponse = await uploadImage(r);
      this.uploadingImage = false;
      notifyListeners();
      imageResponse.fold((l) {}, (r) {
        selectedImages.add(r);
        print(this.selectedImages);
        notifyListeners();
      });
    });
  }

  addMetaData(Function() onSuccess,Function(String) onFailure) async{
    addingMetadata = true;
    notifyListeners();
    AddProductMetadata metadata = AddProductMetadata();
    metadata.size = sizeController.text.trim();
    metadata.price = double.parse(priceController.text.trim());
    metadata.color = colorController.text.trim();
    metadata.quantity = int.parse(quantityController.text.trim());
    metadata.productImgUrls = selectedImages;

    final res = await _productRepository.addProductMetadata(productId: productId, metadata: metadata);
    res.fold((l) {
      onFailure(l.message);
    }, (r) {
      onSuccess();
    });
    addingMetadata = false;
    notifyListeners();

  }

}