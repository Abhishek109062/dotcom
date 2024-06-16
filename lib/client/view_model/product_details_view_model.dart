import 'dart:convert';

import 'package:dot_com/client/api_model/Product_Metadata_model.dart';
import 'package:dot_com/client/api_model/selectedProductModel.dart';
import 'package:flutter/cupertino.dart';

import '../api_model/product_details_byId_model.dart';
import '../repository/client_repository.dart';

class ProductDetailsViewModel with ChangeNotifier {
  final _client_rep = ClientRepository();
  ProductDetailsByID? _productInfo;
  bool _isLoading = false;
  List<String> _color = [];
  Map<String, Map<String, dynamic>> _colorToSize = {};
  SelectedProductModel? _selectedProduct;
  ProductDetailsByID? get productInfo => _productInfo;
  bool get isLoading => _isLoading;

  Map<String, Map<String, dynamic>> get colorToSize => _colorToSize;

  SelectedProductModel? get selectedProduct => _selectedProduct;

  List<String> get color => _color;
  // String _selectedColor = '';
  // String _selectedSize = '';
  // List<String> _selectedImages = [];
  // String get selectedColor => _selectedColor;

  // List<String> get selectedImages => _selectedImages;

  set selectedImages(List<String> value) {
    _selectedProduct?.productImgUrls = value;
    // _selectedImages = value;
    notifyListeners();
  }

  set selectedColor(String value) {
    _selectedProduct?.color = value;
    // _selectedColor = value;
    selectedSize = (colorToSize[_selectedProduct!.color]?.keys.toList()[0] ?? '');
    notifyListeners();
  }

  // String get selectedSize => _selectedSize;

  set selectedSize(String value) {
    _selectedProduct!.size = value;

    // print(colorToSize[_selectedProduct?.color]?[_selectedProduct!.size]) ?? '';
    _selectedProduct?.price =
        colorToSize[_selectedProduct?.color]?[_selectedProduct?.size]['price'] ?? 0;
    _selectedProduct?.id = colorToSize[_selectedProduct?.color]?[_selectedProduct?.size]['id'] ?? 0;
    _selectedProduct?.quantity =
        colorToSize[_selectedProduct?.color]?[_selectedProduct?.size]['quantity'] ?? 0;
    colorToSize[_selectedProduct?.color]?[_selectedProduct!.size]['productImgUrls'] ?? [];
    print(_selectedProduct!.productImgUrls);

    notifyListeners();
  }

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> intializePage(int productId, bool userLoggedIn) async {
    print('basic called triggered');
    _selectedProduct = null;
    _color = [];
    _colorToSize = {};
    print(productId);
    isLoading = true;

    // await Future.delayed(Duration(seconds: 10));
    await getProductDetailByID(productId, userLoggedIn);
    await getProductMetaDataByID(productId, userLoggedIn);
    isLoading = false;
    print('Api called ended $isLoading');
  }

  Future<void> getProductDetailByID(int productId, bool userLoggedIn) async {
    dynamic temp =
        await _client_rep.callGetProductDetailsByIdApi(productId, userLoggedIn).then((value) {
      _productInfo = ProductDetailsByID.fromJson(jsonDecode(value.body));
      _selectedProduct = SelectedProductModel(
          size: '',
          color: '',
          id: 0,
          price: _productInfo?.productDto.averageProductPrice ?? 0,
          quantity: 0,
          productImgUrls: _productInfo?.productDto.productImgUrls ?? []);
      selectedImages = _productInfo?.productDto.productImgUrls ?? [];
      print(value.body);
    }).catchError((e, StackTrace) {
      debugPrint("Error temp --${e.toString()}");
    });
  }

  Future<void> getProductMetaDataByID(int productId, bool userLoggedIn) async {
    dynamic temp =
        await _client_rep.callGetProductMetaDataByIdApi(productId, userLoggedIn).then((value) {
      List<dynamic> data = jsonDecode(value.body);
      for (dynamic t in data)
        _productInfo!.productDto.productMetadata.add(ProductMetaData.fromJson(t));

      for (ProductMetaData t in _productInfo!.productDto.productMetadata) {
        if (t.color != null && !_color.contains(t.color)) _color.add(t.color!);
      }
      selectedColor = (_color.length > 0 ? _color[0] : '');
      // _selectedProduct?.color = _color.length > 0 ? _color[0] : '';

      for (String y in color) {
        Map<String, dynamic> sizes = {};
        for (ProductMetaData t in _productInfo!.productDto.productMetadata) {
          if (t.color != null && t.color == y)
            sizes[t.size!] = {
              'id': t.id,
              'quantity': t.quantity ?? 0,
              'price': t.price ?? 0,
              'productImgUrls': t.productImgUrls ?? [],
            };
        }
        _colorToSize[y] = sizes;
      }
      print(colorToSize);

      selectedSize = selectedProduct?.color != ''
          ? colorToSize[_selectedProduct?.color]?.keys.toList()[0] ?? ''
          : '';
      // _selectedProduct?.size = _selectedProduct?.color != ''
      //     ? colorToSize[_selectedProduct?.color]?.keys.toList()[0] ?? ''
      //     : '';
      // selectedSize = (_selectedColor != '' ? colorToSize[_selectedColor]?.keys.toList()[0] : '')!;
    }).catchError((e, StackTrace) {
      debugPrint("Error --${e.toString()}");
    });
  }

  Future<void> addProductToCart(int productId, int productMetaId, int quantity) async {
    print('Product info $productId $productMetaId');
    dynamic temp = await _client_rep
        .callAddProductsToCartApi(productId, productMetaId, quantity)
        .then((value) {
      productInfo!.productDto.productInCart = true;
      notifyListeners();
    }).catchError((e, StackTrace) {
      debugPrint("Error --${e.toString()}");
    });
  }

  Future<void> deleteProductToCart(int productId, int productMetaId) async {
    print('Product info $productId $productMetaId');
    dynamic temp =
        await _client_rep.callDeleteProductsToCartApi(productId, productMetaId).then((value) {
      notifyListeners();
    }).catchError((e, StackTrace) {
      debugPrint("Error --${e.toString()}");
    });
  }
}
