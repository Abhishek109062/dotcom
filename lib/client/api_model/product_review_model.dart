// To parse this JSON data, do
//
//     final productReviewModel = productReviewModelFromJson(jsonString);

import 'dart:convert';

ProductReviewResponseModel productReviewModelFromJson(String str) =>
    ProductReviewResponseModel.fromJson(json.decode(str));

String productReviewModelToJson(ProductReviewResponseModel data) => json.encode(data.toJson());

class ProductReviewResponseModel {
  int? customerId;
  int? productId;
  int? orderDetailsId;
  int? rating;
  String? feedbackMessage;
  List<String>? feedbackUrls;
  String? reviewerName;
  int? createdAt;
  String? reviewerImgUrl;

  ProductReviewResponseModel({
    this.customerId,
    this.productId,
    this.orderDetailsId,
    this.rating,
    this.feedbackMessage,
    this.feedbackUrls,
    this.createdAt,
    this.reviewerName,
    this.reviewerImgUrl,
  });

  factory ProductReviewResponseModel.fromJson(Map<String, dynamic> json) =>
      ProductReviewResponseModel(
        customerId: json["customerId"],
        productId: json["productId"],
        orderDetailsId: json["orderDetailsId"],
        rating: json["rating"],
        feedbackMessage: json["feedbackMessage"],
        feedbackUrls: json["feedbackUrls"] == null
            ? []
            : List<String>.from(json["feedbackUrls"]!.map((x) => x)),
        createdAt: json['createdAt'],
        reviewerName: json["reviewerName"],
        reviewerImgUrl: json["reviewerImgUrl"],
      );

  Map<String, dynamic> toJson() => {
        "customerId": customerId,
        "productId": productId,
        "orderDetailsId": orderDetailsId,
        "rating": rating,
        "feedbackMessage": feedbackMessage,
        "feedbackUrls": feedbackUrls == null ? [] : List<dynamic>.from(feedbackUrls!.map((x) => x)),
        "reviewerName": reviewerName,
        "reviewerImgUrl": reviewerImgUrl,
      };
}
