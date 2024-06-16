import 'package:dot_com/subadmin/products/repository/product_metadata_model_subadmin.dart';
import 'package:flutter/material.dart';

import '../../../utils/imagepicker.dart';
import '../repository/product_repository.dart';

class UpdateMetadataViewModel extends ChangeNotifier {
  final int productMetaDataId;
  UpdateMetadataViewModel({required this.productMetaDataId});
  ProductRepository _productRepository = ProductRepository();
  bool updatingMetadata = false;
  bool deletingMetadata = false;
  bool errorLoadingMetadata = false;
  bool errorUpdatingMetadata = false;
  bool loadingMetadata = false;
  TextEditingController sizeController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  ProductMetadataDto? metadataDto;

  FocusNode sizeFocusNode = FocusNode();
  FocusNode colorFocusNode = FocusNode();
  FocusNode quantityFocusNode = FocusNode();
  FocusNode priceFocusNode = FocusNode();

  List<String> selectedImages = [];
  bool uploadingImage = false;

  getMetadataDetails() async {
    loadingMetadata = true;
    notifyListeners();
    final res = await _productRepository.getProductMetadata(productMetadataId: productMetaDataId);
    await res.fold((l) {
      errorLoadingMetadata = true;
    }, (r) {
      metadataDto = r;
      initializeFields();
    });
    loadingMetadata = false;
    notifyListeners();
  }

  initializeFields() {
    sizeController.text = metadataDto!.size;
    colorController.text = metadataDto!.color;
    quantityController.text = metadataDto!.quantity.toString();
    priceController.text = metadataDto!.price.toString();
    selectedImages = metadataDto!.productImgUrls;
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
        selectedImages.add(r);
        print(this.selectedImages);
        notifyListeners();
      });
    });
  }

  Future<void> updateMetadata(Function() onSuccess, Function(String) onFailure) async {
    updatingMetadata = true;
    notifyListeners();
    metadataDto!.size = sizeController.text;
    metadataDto!.color = colorController.text.trim();
    metadataDto!.productImgUrls = selectedImages;
    metadataDto!.price = double.parse(priceController.text.trim());
    metadataDto!.quantity = int.parse(quantityController.text.trim());

    final res =
        await _productRepository.updateProductMetadata(updatedProductMetadata: metadataDto!);
    res.fold((l) {
      onFailure(l.message);
    }, (r) {
      onSuccess();
    });
    updatingMetadata = false;
    notifyListeners();
  }

  Future<void> deleteMetadata(Function() onSuccess, Function(String) onFailure) async {
    deletingMetadata = true;
    notifyListeners();

    final res = await _productRepository.deleteProductMedadata(productMetadataId: metadataDto!.id);
    res.fold((l) {
      onFailure(l.message);
    }, (r) {
      onSuccess();
    });
    deletingMetadata = false;
    notifyListeners();
  }
}
