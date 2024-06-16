import 'dart:convert';

import 'Product_Metadata_model.dart';

class ProductDetails {
  int id;
  String title;
  String brandName;
  String description;
  int pincode;
  String district;
  String takeAwayAddress;

  dynamic state;
  int createdAt;
  dynamic subAdmin;
  int estimatedDeliveryTime;
  bool? deleted;
  dynamic sumRating;
  dynamic ratingCount;
  bool? outOfStock;
  String category;
  dynamic filters;
  List<String> productImgUrls;
  List<ProductMetaData> productMetadata;
  int discount;
  double rating;
  int averageProductPrice;
  bool? productInWishList;
  bool? productInCart;

  ProductDetails({
    required this.id,
    required this.title,
    required this.brandName,
    required this.description,
    required this.pincode,
    required this.district,
    required this.takeAwayAddress,
    required this.state,
    required this.createdAt,
    required this.subAdmin,
    required this.estimatedDeliveryTime,
    required this.deleted,
    required this.sumRating,
    required this.ratingCount,
    required this.outOfStock,
    required this.category,
    required this.filters,
    required this.productImgUrls,
    required this.productMetadata,
    required this.discount,
    required this.rating,
    required this.averageProductPrice,
    required this.productInWishList,
    required this.productInCart,
  });

  ProductDetails copyWith({
    int? id,
    String? title,
    String? brandName,
    String? description,
    int? pincode,
    String? district,
    String? takeAwayAddress,
    dynamic state,
    int? createdAt,
    dynamic subAdmin,
    int? estimatedDeliveryTime,
    bool? deleted,
    dynamic sumRating,
    dynamic ratingCount,
    bool? outOfStock,
    String? category,
    dynamic filters,
    List<String>? productImgUrls,
    List<ProductMetaData>? productMetadata,
    int? discount,
    double? rating,
    int? averageProductPrice,
    dynamic productInWishList,
    dynamic productInCart,
  }) =>
      ProductDetails(
        id: id ?? this.id,
        title: title ?? this.title,
        brandName: brandName ?? this.brandName,
        description: description ?? this.description,
        pincode: pincode ?? this.pincode,
        district: district ?? this.district,
        takeAwayAddress: takeAwayAddress ?? this.takeAwayAddress,
        state: state ?? this.state,
        createdAt: createdAt ?? this.createdAt,
        subAdmin: subAdmin ?? this.subAdmin,
        estimatedDeliveryTime: estimatedDeliveryTime ?? this.estimatedDeliveryTime,
        deleted: deleted ?? this.deleted,
        sumRating: sumRating ?? this.sumRating,
        ratingCount: ratingCount ?? this.ratingCount,
        outOfStock: outOfStock ?? this.outOfStock,
        category: category ?? this.category,
        filters: filters ?? this.filters,
        productImgUrls: productImgUrls ?? this.productImgUrls,
        productMetadata: productMetadata ?? this.productMetadata,
        discount: discount ?? this.discount,
        rating: rating ?? this.rating,
        averageProductPrice: averageProductPrice ?? this.averageProductPrice,
        productInWishList: productInWishList ?? this.productInWishList,
        productInCart: productInCart ?? this.productInCart,
      );

  factory ProductDetails.fromJson(Map<String, dynamic> json) => ProductDetails(
        id: json["id"],
        title: json["title"],
        brandName: json["brandName"] ?? '',
        description: json["description"],
        pincode: json["pincode"],
        district: json["district"] ?? '',
        takeAwayAddress: json["takeAwayAddress"],
        state: json["state"],
        createdAt: json["createdAt"],
        subAdmin: json["subAdmin"],
        estimatedDeliveryTime: json["estimatedDeliveryTime"],
        deleted: json["deleted"],
        sumRating: json["sumRating"],
        ratingCount: json["ratingCount"],
        outOfStock: json["outOfStock"],
        category: json["category"],
        filters: json["filters"],
        productImgUrls: List<String>.from(json["productImgUrls"].map((x) => x)),
        productMetadata: [],
        discount: json["discount"],
        rating: json["rating"],
        averageProductPrice: json["averageProductPrice"],
        productInWishList: json["productInWishList"],
        productInCart: json["productInCart"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "brandName": brandName,
        "description": description,
        "pincode": pincode,
        "district": district,
        "takeAwayAddress": takeAwayAddress,
        "state": state,
        "createdAt": createdAt,
        "subAdmin": subAdmin,
        "estimatedDeliveryTime": estimatedDeliveryTime,
        "deleted": deleted,
        "sumRating": sumRating,
        "ratingCount": ratingCount,
        "outOfStock": outOfStock,
        "category": category,
        "filters": filters,
        "productImgUrls": List<dynamic>.from(productImgUrls.map((x) => x)),
        "productMetadata": productMetadata,
        "discount": discount,
        "rating": rating,
        "averageProductPrice": averageProductPrice,
        "productInWishList": productInWishList,
        "productInCart": productInCart,
      };
}
