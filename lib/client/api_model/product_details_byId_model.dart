import 'package:dot_com/client/api_model/product_details_model.dart';

class ProductDetailsByID {
  bool? showTakeAwayAddress;
  ProductDetails productDto;

  ProductDetailsByID({required this.showTakeAwayAddress, required this.productDto});

  factory ProductDetailsByID.fromJson(Map<String, dynamic> json) => ProductDetailsByID(
      showTakeAwayAddress: json['showTakeAwayAddress'],
      productDto: ProductDetails.fromJson(json['productDto']));
}
