// To parse this JSON data, do
//
//     final addOrderDetailsRequestModel = addOrderDetailsRequestModelFromJson(jsonString);

import 'dart:convert';

AddOrderDetailsRequestModel addOrderDetailsRequestModelFromJson(String str) =>
    AddOrderDetailsRequestModel.fromJson(json.decode(str));

Map<String, dynamic> addOrderDetailsRequestModelToJson(AddOrderDetailsRequestModel data) =>
    data.toJson();

class AddOrderDetailsRequestModel {
  List<CreateOrderProduct>? createOrderProduct;
  String? paymentMode;
  String? shippingAddress;
  String? billingAddress;

  AddOrderDetailsRequestModel({
    required this.createOrderProduct,
    required this.paymentMode,
    required this.shippingAddress,
    required this.billingAddress,
  });

  factory AddOrderDetailsRequestModel.fromJson(Map<String, dynamic> json) =>
      AddOrderDetailsRequestModel(
        createOrderProduct: json["createOrderProduct"] == null
            ? []
            : List<CreateOrderProduct>.from(
                json["createOrderProduct"]!.map((x) => CreateOrderProduct.fromJson(x))),
        paymentMode: json["paymentMode"],
        shippingAddress: json["shippingAddress"],
        billingAddress: json["billingAddress"],
      );

  Map<String, dynamic> toJson() => {
        "createOrderProduct": createOrderProduct == null
            ? []
            : List<dynamic>.from(createOrderProduct!.map((x) => x.toJson())),
        "paymentMode": paymentMode,
        "shippingAddress": shippingAddress,
        "billingAddress": billingAddress,
      };
}

class CreateOrderProduct {
  int? productId;
  int? productQuantity;
  int? productMetaDataId;

  CreateOrderProduct({
    required this.productId,
    required this.productQuantity,
    required this.productMetaDataId,
  });

  factory CreateOrderProduct.fromJson(Map<String, dynamic> json) => CreateOrderProduct(
        productId: json["productId"],
        productQuantity: json["productQuantity"],
        productMetaDataId: json["productMetaDataId"],
      );

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "productQuantity": productQuantity,
        "productMetaDataId": productMetaDataId,
      };
}
