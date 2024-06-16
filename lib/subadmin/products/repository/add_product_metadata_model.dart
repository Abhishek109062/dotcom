
import 'dart:convert';

AddProductMetadata addProductMetadataFromJson(Map<String,dynamic> str) => AddProductMetadata.fromJson(str);

String addProductMetadataToJson(AddProductMetadata data) => json.encode(data.toJson());

class AddProductMetadata {
  String? size;
  String? color;
  int? quantity;
  num? price;
  List<String>? productImgUrls;

  AddProductMetadata({
    this.size,
    this.color,
    this.quantity,
    this.price,
    this.productImgUrls,
  });

  AddProductMetadata copyWith({
    String? size,
    String? color,
    int? quantity,
    num? price,
    List<String>? productImgUrls,
  }) =>
      AddProductMetadata(
        size: size ?? this.size,
        color: color ?? this.color,
        quantity: quantity ?? this.quantity,
        price: price ?? this.price,
        productImgUrls: productImgUrls ?? this.productImgUrls,
      );

  factory AddProductMetadata.fromJson(Map<String, dynamic> json) => AddProductMetadata(
    size: json["size"],
    color: json["color"],
    quantity: json["quantity"],
    price: json["price"],
    productImgUrls: json["productImgUrls"] == null ? [] : List<String>.from(json["productImgUrls"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "size": size ?? "",
    "color": color ?? "",
    "quantity": quantity ?? 0,
    "price": price ?? 0,
    "productImgUrls": productImgUrls == null ? [] : List<dynamic>.from(productImgUrls!.map((x) => x)),
  };
}
