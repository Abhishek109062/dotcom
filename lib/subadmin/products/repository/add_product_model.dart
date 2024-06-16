// To parse this JSON data, do
//
//     final addProduct = addProductFromJson(jsonString);

import 'dart:convert';

AddProduct addProductFromJson(Map<String,dynamic> str) => AddProduct.fromJson(str);

String addProductToJson(AddProduct data) => json.encode(data.toJson());

class AddProduct {
  String? title;
  String? brandName;
  String? description;
  int? pincode;
  String? district;
  String? takeAwayAddress;
  String? state;
  int? estimatedDeliveryTime;
  String? category;
  List<String>? filters;
  List<String>? productImgUrls;
  num? discount;
  num? averageProductPrice;

  AddProduct({
    this.title,
    this.brandName,
    this.description,
    this.pincode,
    this.district,
    this.takeAwayAddress,
    this.state,
    this.estimatedDeliveryTime,
    this.category,
    this.filters,
    this.productImgUrls,
    this.discount,
    this.averageProductPrice,
  });

  AddProduct copyWith({
    String? title,
    String? brandName,
    String? description,
    int? pincode,
    String? district,
    String? takeAwayAddress,
    String? state,
    int? estimatedDeliveryTime,
    String? category,
    List<String>? filters,
    List<String>? productImgUrls,
    num? discount,
    num? averageProductPrice,
  }) =>
      AddProduct(
        title: title ?? this.title,
        brandName: brandName ?? this.brandName,
        description: description ?? this.description,
        pincode: pincode ?? this.pincode,
        district: district ?? this.district,
        takeAwayAddress: takeAwayAddress ?? this.takeAwayAddress,
        state: state ?? this.state,
        estimatedDeliveryTime: estimatedDeliveryTime ?? this.estimatedDeliveryTime,
        category: category ?? this.category,
        filters: filters ?? this.filters,
        productImgUrls: productImgUrls ?? this.productImgUrls,
        discount: discount ?? this.discount,
        averageProductPrice: averageProductPrice ?? this.averageProductPrice,
      );

  factory AddProduct.fromJson(Map<String, dynamic> json) => AddProduct(
        title: json["title"],
        brandName: json["brandName"],
        description: json["description"],
        pincode: json["pincode"],
        district: json["district"],
        takeAwayAddress: json["takeAwayAddress"],
        state: json["state"],
        estimatedDeliveryTime: json["estimatedDeliveryTime"],
        category: json["category"],
        filters: json["filters"] == null ? [] : List<String>.from(json["filters"]!.map((x) => x)),
        productImgUrls: json["productImgUrls"] == null
            ? []
            : List<String>.from(json["productImgUrls"]!.map((x) => x)),
        discount: json["discount"],
        averageProductPrice: json["averageProductPrice"],
      );


  Map<String, dynamic> toJson() => {
        "title": title ?? "",
        "brandName": brandName ?? "",
        "description": description ?? "",
        "pincode": pincode ?? 0,
        "district": district ?? "",
        "takeAwayAddress": takeAwayAddress ?? "",
        "state": state ?? "",
        "estimatedDeliveryTime": estimatedDeliveryTime ?? 0,
        "category": category ?? "",
        "filters": filters == null ? [] : List<dynamic>.from(filters!.map((x) => x)),
        "productImgUrls":
            productImgUrls == null ? [] : List<dynamic>.from(productImgUrls!.map((x) => x)),
        "discount": discount ?? 0,
        "averageProductPrice": averageProductPrice ?? 0,
      };
}
