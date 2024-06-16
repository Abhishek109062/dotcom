import 'dart:convert';

List<dynamic>? VerifyOrderPriceRequestModelListToJson(List<VerifyOrderPriceRequestModel> data) =>
    List<dynamic>.from(data.map((x) => x.toJson()));

class VerifyOrderPriceRequestModel {
  int productId;
  int productQuantity;
  int productMetaDataId;

  VerifyOrderPriceRequestModel({
    required this.productId,
    required this.productQuantity,
    required this.productMetaDataId,
  });

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "productQuantity": productQuantity,
        "productMetaDataId": productMetaDataId,
      };
}
