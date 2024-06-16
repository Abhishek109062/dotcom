// To parse this JSON data, do
//
//     final verifyOrderPriceResponseModel = verifyOrderPriceResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:dot_com/client/api_model/Product_Metadata_model.dart';
import 'package:dot_com/client/api_model/product_details_model.dart';

VerifyOrderPriceResponseModel verifyOrderPriceResponseModelFromJson(String str) =>
    VerifyOrderPriceResponseModel.fromJson(json.decode(str));

String verifyOrderPriceResponseModelToJson(VerifyOrderPriceResponseModel data) =>
    json.encode(data.toJson());

class VerifyOrderPriceResponseModel {
  int? shippingCharges;
  String? paymentMode;
  List<VerifiedProductsList>? verifiedProductsList;

  VerifyOrderPriceResponseModel({
    this.shippingCharges,
    this.paymentMode,
    this.verifiedProductsList,
  });

  factory VerifyOrderPriceResponseModel.fromJson(Map<String, dynamic> json) =>
      VerifyOrderPriceResponseModel(
        shippingCharges: json["shippingCharges"],
        paymentMode: json["paymentMode"],
        verifiedProductsList: json["verifiedProductsList"] == null
            ? []
            : List<VerifiedProductsList>.from(
                json["verifiedProductsList"]!.map((x) => VerifiedProductsList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "shippingCharges": shippingCharges,
        "paymentMode": paymentMode,
        "verifiedProductsList": verifiedProductsList == null
            ? []
            : List<dynamic>.from(verifiedProductsList!.map((x) => x.toJson())),
      };
}

class VerifiedProductsList {
  ProductDetails? productDto;
  ProductMetaData? productMetaDataDto;
  int? productQuantity;
  int? productDiscount;
  int? productTotalPriceWithoutDiscount;

  VerifiedProductsList({
    this.productDto,
    this.productMetaDataDto,
    this.productQuantity,
    this.productDiscount,
    this.productTotalPriceWithoutDiscount,
  });

  factory VerifiedProductsList.fromJson(Map<String, dynamic> json) => VerifiedProductsList(
        productDto: ProductDetails.fromJson(json["productDto"]),
        productMetaDataDto: ProductMetaData.fromJson(json['productMetaDataDto']),
        productQuantity: json["productQuantity"],
        productDiscount: json["productDiscount"],
        productTotalPriceWithoutDiscount: json["productTotalPriceWithoutDiscount"],
      );

  Map<String, dynamic> toJson() => {
        "productDto": productDto,
        "productMetaDataDto": productMetaDataDto,
        "productQuantity": productQuantity,
        "productDiscount": productDiscount,
        "productTotalPriceWithoutDiscount": productTotalPriceWithoutDiscount,
      };
}
