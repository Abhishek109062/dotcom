import 'dart:convert';

import 'package:dot_com/client/api_model/Product_Metadata_model.dart';
import 'package:dot_com/client/api_model/product_details_model.dart';

List<ProductCartModel> productCartDataFromJson(String str) =>
    List<ProductCartModel>.from(json.decode(str).map((x) => ProductCartModel.fromJson(x)));

class ProductCartModel {
  int id;
  String? customer;
  ProductDetails? product;
  ProductMetaData? productMetaData;
  int quantity;
  bool deleted;
  dynamic createdAt;

  ProductCartModel(
      {required this.id,
      required this.customer,
      required this.product,
      required this.productMetaData,
      required this.quantity,
      required this.deleted,
      required this.createdAt});

  factory ProductCartModel.fromJson(Map<String, dynamic> json) => ProductCartModel(
        id: json['id'],
        productMetaData: ProductMetaData.fromJson(json['productMetaData']),
        product: ProductDetails.fromJson(json['product']),
        createdAt: json['createdAt'],
        customer: json['customer'],
        deleted: json['deleted'],
        quantity: json['quantity'],
      );
}
