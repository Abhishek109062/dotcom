
import 'dart:convert';

List<ProductDetails> productDetailsDtoFromJson(List<dynamic> str) => List<ProductDetails>.from(str.map((x) => ProductDetails.fromJson(x)));

String productDetailsDtoToJson(List<ProductDetails> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

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
  bool deleted;
  dynamic sumRating;
  dynamic ratingCount;
  bool outOfStock;
  String category;
  List<String> filters;
  List<String> productImgUrls;
  dynamic productMetadata;
  num discount;
  num rating;
  num averageProductPrice;
  dynamic productInWishList;
  dynamic productInCart;

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
    List<String>? filters,
    List<String>? productImgUrls,
    dynamic productMetadata,
    num? discount,
    num? rating,
    num? averageProductPrice,
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
    title: json["title"] ?? "",
    brandName: json["brandName"] ?? "",
    description: json["description"] ?? "",
    pincode: json["pincode"] ?? 0,
    district: json["district"] ?? "",
    takeAwayAddress: json["takeAwayAddress"] ?? "",
    state: json["state"] ?? "",
    createdAt: json["createdAt"] ?? 0,
    subAdmin: json["subAdmin"] ?? "",
    estimatedDeliveryTime: json["estimatedDeliveryTime"] ?? 0,
    deleted: json["deleted"] ?? false,
    sumRating: json["sumRating"] ,
    ratingCount: json["ratingCount"],
    outOfStock: json["outOfStock"] ?? false,
    category: json["category"] ?? "",
    filters: json["filters"]!=null ? List<String>.from(json["filters"].map((x) => x)) : [],
    productImgUrls: List<String>.from(json["productImgUrls"].map((x) => x)),
    productMetadata: json["productImgUrls"] !=null ? json["productMetadata"] : [],
    discount: json["discount"] ?? 0.0,
    rating: json["rating"] ?? 0,
    averageProductPrice: json["averageProductPrice"] ?? 0.0,
    productInWishList: json["productInWishList"] ,
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
    "filters": List<dynamic>.from(filters.map((x) => x)),
    "productImgUrls": List<dynamic>.from(productImgUrls.map((x) => x)),
    "productMetadata": productMetadata,
    "discount": discount,
    "rating": rating,
    "averageProductPrice": averageProductPrice,
    "productInWishList": productInWishList,
    "productInCart": productInCart,
  };


  Map<String, dynamic> updateProduct() => {
    "id": id,
    "title": title,
    "brandName": brandName,
    "description": description,
    "pincode": pincode,
    "district": district,
    "takeAwayAddress": takeAwayAddress,
    "state": state,
    // "createdAt": createdAt,
    // "subAdmin": subAdmin,
    "estimatedDeliveryTime": estimatedDeliveryTime,
    // "deleted": deleted,
    // "sumRating": sumRating,
    // "ratingCount": ratingCount,
    // "outOfStock": outOfStock,
    "category": category,
    "filters": List<dynamic>.from(filters.map((x) => x)),
    "productImgUrls": List<dynamic>.from(productImgUrls.map((x) => x)),
    // "productMetadata": productMetadata,
    "discount": discount,
    // "rating": rating,
    "averageProductPrice": averageProductPrice,
    // "productInWishList": productInWishList,
    // "productInCart": productInCart,
  };
}
