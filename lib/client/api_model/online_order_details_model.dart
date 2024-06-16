// To parse this JSON data, do
//
//     final orderDetailsDto = orderDetailsDtoFromJson(jsonString);

import 'dart:convert';

List<OrderDetailsDto> orderDetailsDtoFromJson(String str) =>
    List<OrderDetailsDto>.from(json.decode(str).map((x) => OrderDetailsDto.fromJson(x)));

String orderDetailsDtoToJson(List<OrderDetailsDto> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrderDetailsDto {
  int? id;
  int? userId;
  String? shippingAddress;
  String? billingAddress;
  int? dateOfOrder;
  String? orderStatusDto;
  String? paymentStatusDto;
  List<OrderedProductDetailsDto>? orderedProductDetailsDto;
  dynamic trackingServiceProvider;
  dynamic trackingLink;
  dynamic trackingId;
  PaymentInfoDto? paymentInfoDto;
  double? totalDiscountInRuppee;
  double? totalOrderPrice;
  int? createdAt;
  dynamic paymentModeDto;
  int? shippingCharge;
  dynamic refundStatus;

  OrderDetailsDto({
    this.id,
    this.userId,
    this.shippingAddress,
    this.billingAddress,
    this.dateOfOrder,
    this.orderStatusDto,
    this.paymentStatusDto,
    this.orderedProductDetailsDto,
    this.trackingServiceProvider,
    this.trackingLink,
    this.trackingId,
    this.paymentInfoDto,
    this.totalDiscountInRuppee,
    this.totalOrderPrice,
    this.createdAt,
    this.paymentModeDto,
    this.shippingCharge,
    this.refundStatus,
  });

  factory OrderDetailsDto.fromJson(Map<String, dynamic> json) => OrderDetailsDto(
        id: json["id"],
        userId: json["userId"],
        shippingAddress: json["shippingAddress"],
        billingAddress: json["billingAddress"],
        dateOfOrder: json["dateOfOrder"],
        orderStatusDto: json["orderStatusDto"],
        paymentStatusDto: json["paymentStatusDto"],
        orderedProductDetailsDto: json["orderedProductDetailsDto"] == null
            ? []
            : List<OrderedProductDetailsDto>.from(
                json["orderedProductDetailsDto"]!.map((x) => OrderedProductDetailsDto.fromJson(x))),
        trackingServiceProvider: json["trackingServiceProvider"],
        trackingLink: json["trackingLink"],
        trackingId: json["trackingId"],
        paymentInfoDto:
            json["paymentInfoDto"] == null ? null : PaymentInfoDto.fromJson(json["paymentInfoDto"]),
        totalDiscountInRuppee: json["totalDiscountInRuppee"],
        totalOrderPrice: json["totalOrderPrice"],
        createdAt: json["createdAt"],
        paymentModeDto: json["paymentModeDto"],
        shippingCharge: json["shippingCharge"],
        refundStatus: json["refundStatus"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "shippingAddress": shippingAddress,
        "billingAddress": billingAddress,
        "dateOfOrder": dateOfOrder,
        "orderStatusDto": orderStatusDto,
        "paymentStatusDto": paymentStatusDto,
        "orderedProductDetailsDto": orderedProductDetailsDto == null
            ? []
            : List<dynamic>.from(orderedProductDetailsDto!.map((x) => x.toJson())),
        "trackingServiceProvider": trackingServiceProvider,
        "trackingLink": trackingLink,
        "trackingId": trackingId,
        "paymentInfoDto": paymentInfoDto?.toJson(),
        "totalDiscountInRuppee": totalDiscountInRuppee,
        "totalOrderPrice": totalOrderPrice,
        "createdAt": createdAt,
        "paymentModeDto": paymentModeDto,
        "shippingCharge": shippingCharge,
        "refundStatus": refundStatus,
      };
}

class OrderedProductDetailsDto {
  int? id;
  dynamic productDto;
  int? orderedQuantity;
  int? orderedPrice;
  dynamic productMetaData;
  int? createdAt;
  String? productName;
  List<String>? productMetadataUrls;

  OrderedProductDetailsDto({
    this.id,
    this.productDto,
    this.orderedQuantity,
    this.orderedPrice,
    this.productMetaData,
    this.createdAt,
    this.productName,
    this.productMetadataUrls,
  });

  factory OrderedProductDetailsDto.fromJson(Map<String, dynamic> json) => OrderedProductDetailsDto(
        id: json["id"],
        productDto: json["productDto"],
        orderedQuantity: json["orderedQuantity"],
        orderedPrice: json["orderedPrice"],
        productMetaData: json["productMetaData"],
        createdAt: json["createdAt"],
        productName: json["productName"],
        productMetadataUrls: json["productMetadataUrls"] == null
            ? []
            : List<String>.from(json["productMetadataUrls"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "productDto": productDto,
        "orderedQuantity": orderedQuantity,
        "orderedPrice": orderedPrice,
        "productMetaData": productMetaData,
        "createdAt": createdAt,
        "productName": productName,
        "productMetadataUrls": productMetadataUrls == null
            ? []
            : List<dynamic>.from(productMetadataUrls!.map((x) => x)),
      };
}

class PaymentInfoDto {
  dynamic id;
  dynamic price;
  String? paymentStatusDto;
  dynamic transactionId;
  dynamic createdAt;
  dynamic razorpayOrderId;
  dynamic razorpayPaymentId;
  dynamic razorpaySignature;

  PaymentInfoDto({
    this.id,
    this.price,
    this.paymentStatusDto,
    this.transactionId,
    this.createdAt,
    this.razorpayOrderId,
    this.razorpayPaymentId,
    this.razorpaySignature,
  });

  factory PaymentInfoDto.fromJson(Map<String, dynamic> json) => PaymentInfoDto(
        id: json["id"],
        price: json["price"],
        paymentStatusDto: json["paymentStatusDto"],
        transactionId: json["transactionId"],
        createdAt: json["createdAt"],
        razorpayOrderId: json["razorpay_order_id"],
        razorpayPaymentId: json["razorpay_payment_id"],
        razorpaySignature: json["razorpay_signature"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "price": price,
        "paymentStatusDto": paymentStatusDto,
        "transactionId": transactionId,
        "createdAt": createdAt,
        "razorpay_order_id": razorpayOrderId,
        "razorpay_payment_id": razorpayPaymentId,
        "razorpay_signature": razorpaySignature,
      };
}
