// To parse this JSON data, do
//
//     final productMetaData = productMetaDataFromJson(jsonString);

import 'dart:convert';

List<ProductMetaData> productMetaDataFromJson(String str) =>
    List<ProductMetaData>.from(json.decode(str).map((x) => ProductMetaData.fromJson(x)));

String productMetaDataToJson(List<ProductMetaData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductMetaData {
  int? id;
  String? size;
  String? color;
  int? quantity;
  int? price;
  bool? deleted;
  dynamic product;
  int? createdAt;
  List<String>? productImgUrls;
  int? productId;

  ProductMetaData({
    this.id,
    this.size,
    this.color,
    this.quantity,
    this.price,
    this.deleted,
    this.product,
    this.createdAt,
    this.productImgUrls,
    this.productId,
  });

  factory ProductMetaData.fromJson(Map<String, dynamic> json) => ProductMetaData(
        id: json["id"],
        size: json["size"],
        color: json["color"],
        quantity: json["quantity"],
        price: json["price"],
        deleted: json["deleted"],
        product: json["product"],
        createdAt: json["createdAt"],
        productImgUrls: json["productImgUrls"] == null
            ? []
            : List<String>.from(json["productImgUrls"]!.map((x) => x)),
        productId: json["productId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "size": size,
        "color": color,
        "quantity": quantity,
        "price": price,
        "deleted": deleted,
        "product": product,
        "createdAt": createdAt,
        "productImgUrls":
            productImgUrls == null ? [] : List<dynamic>.from(productImgUrls!.map((x) => x)),
        "productId": productId,
      };
}
