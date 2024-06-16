// To parse this JSON data, do
//
//     final productReviewRatingModel = productReviewRatingModelFromJson(jsonString);

import 'dart:convert';

ProductReviewRatingModel productReviewRatingModelFromJson(String str) =>
    ProductReviewRatingModel.fromJson(json.decode(str));

String productReviewRatingModelToJson(ProductReviewRatingModel data) => json.encode(data.toJson());

class ProductReviewRatingModel {
  int? maxRating;
  double? averageRating;
  int? totalReviewsCount;
  double? oneStarPercentage;
  double? twoStarPercentage;
  double? threeStarPercentage;
  double? fourStarPercentage;
  double? fiveStarPercentage;

  ProductReviewRatingModel({
    this.maxRating,
    this.averageRating,
    this.totalReviewsCount,
    this.oneStarPercentage,
    this.twoStarPercentage,
    this.threeStarPercentage,
    this.fourStarPercentage,
    this.fiveStarPercentage,
  });

  factory ProductReviewRatingModel.fromJson(Map<String, dynamic> json) => ProductReviewRatingModel(
        maxRating: json["maxRating"],
        averageRating: json["averageRating"],
        totalReviewsCount: json["totalReviewsCount"],
        oneStarPercentage: json["oneStarPercentage"],
        twoStarPercentage: json["twoStarPercentage"],
        threeStarPercentage: json["threeStarPercentage"],
        fourStarPercentage: json["fourStarPercentage"],
        fiveStarPercentage: json["fiveStarPercentage"],
      );

  Map<String, dynamic> toJson() => {
        "maxRating": maxRating,
        "averageRating": averageRating,
        "totalReviewsCount": totalReviewsCount,
        "oneStarPercentage": oneStarPercentage,
        "twoStarPercentage": twoStarPercentage,
        "threeStarPercentage": threeStarPercentage,
        "fourStarPercentage": fourStarPercentage,
        "fiveStarPercentage": fiveStarPercentage,
      };
}
