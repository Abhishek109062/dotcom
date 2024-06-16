
import 'dart:convert';

List<ProductMetadataDto> productMetadataDtoFromJson(List<dynamic> str) => List<ProductMetadataDto>.from(str.map((x) => ProductMetadataDto.fromJson(x)));

String productMetadataDtoToJson(List<ProductMetadataDto> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductMetadataDto {
  int id;
  String size;
  String color;
  int quantity;
  num price;
  bool deleted;
  dynamic product;
  int createdAt;
  List<String> productImgUrls;
  int productId;

  ProductMetadataDto({
    required this.id,
    required this.size,
    required this.color,
    required this.quantity,
    required this.price,
    required this.deleted,
    required this.product,
    required this.createdAt,
    required this.productImgUrls,
    required this.productId,
  });

  ProductMetadataDto copyWith({
    int? id,
    String? size,
    String? color,
    int? quantity,
    num? price,
    bool? deleted,
    dynamic product,
    int? createdAt,
    List<String>? productImgUrls,
    int? productId,
  }) =>
      ProductMetadataDto(
        id: id ?? this.id,
        size: size ?? this.size,
        color: color ?? this.color,
        quantity: quantity ?? this.quantity,
        price: price ?? this.price,
        deleted: deleted ?? this.deleted,
        product: product ?? this.product,
        createdAt: createdAt ?? this.createdAt,
        productImgUrls: productImgUrls ?? this.productImgUrls,
        productId: productId ?? this.productId,
      );

  factory ProductMetadataDto.fromJson(Map<String, dynamic> json) => ProductMetadataDto(
    id: json["id"],
    size: json["size"] ?? "",
    color: json["color"] ?? "",
    quantity: json["quantity"] ?? 0,
    price: json["price"] ?? 0,
    deleted: json["deleted"] ?? false,
    product: json["product"],
    createdAt: json["createdAt"] ?? 0,
    productImgUrls: json["productImgUrls"]!=null ? List<String>.from(json["productImgUrls"].map((x) => x)) : [],
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
    "productImgUrls": List<dynamic>.from(productImgUrls.map((x) => x)),
    "productId": productId,
  };

  Map<String, dynamic> updateMetadata() => {
    "id": id,
    "size": size,
    "color": color,
    "quantity": quantity,
    "price": price,
    // "deleted": deleted,
    // "product": product,
    // "createdAt": createdAt,
    "productImgUrls": List<dynamic>.from(productImgUrls.map((x) => x)),
    "productId": productId,
  };
}
