// To parse this JSON data, do
//
//     final orderDetailsAdmin = orderDetailsAdminFromJson(jsonString);

import 'dart:convert';

List<OrderDetailsAdmin> orderDetailsAdminFromJson(List<dynamic> str) => List<OrderDetailsAdmin>.from(str.map((x) => OrderDetailsAdmin.fromJson(x)));

String orderDetailsAdminToJson(List<OrderDetailsAdmin> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrderDetailsAdmin {
  int id;
  int userId;
  String shippingAddress;
  String billingAddress;
  int dateOfOrder;
  String orderStatusDto;
  String paymentStatusDto;
  List<OrderedProductDetailsDto> orderedProductDetailsDto;
  String? trackingServiceProvider;
  String? trackingLink;
  int? trackingId;
  PaymentInfoDto paymentInfoDto;
  num totalDiscountInRuppee;
  num totalOrderPrice;
  int createdAt;
  dynamic paymentModeDto;
  int shippingCharge;
  dynamic refundStatus;

  OrderDetailsAdmin({
    required this.id,
    required this.userId,
    required this.shippingAddress,
    required this.billingAddress,
    required this.dateOfOrder,
    required this.orderStatusDto,
    required this.paymentStatusDto,
    required this.orderedProductDetailsDto,
    required this.trackingServiceProvider,
    required this.trackingLink,
    required this.trackingId,
    required this.paymentInfoDto,
    required this.totalDiscountInRuppee,
    required this.totalOrderPrice,
    required this.createdAt,
    required this.paymentModeDto,
    required this.shippingCharge,
    required this.refundStatus,
  });

  OrderDetailsAdmin copyWith({
    int? id,
    int? userId,
    String? shippingAddress,
    String? billingAddress,
    int? dateOfOrder,
    String? orderStatusDto,
    String? paymentStatusDto,
    List<OrderedProductDetailsDto>? orderedProductDetailsDto,
    String? trackingServiceProvider,
    String? trackingLink,
    int? trackingId,
    PaymentInfoDto? paymentInfoDto,
    num? totalDiscountInRuppee,
    num? totalOrderPrice,
    int? createdAt,
    dynamic paymentModeDto,
    int? shippingCharge,
    dynamic refundStatus,
  }) =>
      OrderDetailsAdmin(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        shippingAddress: shippingAddress ?? this.shippingAddress,
        billingAddress: billingAddress ?? this.billingAddress,
        dateOfOrder: dateOfOrder ?? this.dateOfOrder,
        orderStatusDto: orderStatusDto ?? this.orderStatusDto,
        paymentStatusDto: paymentStatusDto ?? this.paymentStatusDto,
        orderedProductDetailsDto: orderedProductDetailsDto ?? this.orderedProductDetailsDto,
        trackingServiceProvider: trackingServiceProvider ?? this.trackingServiceProvider,
        trackingLink: trackingLink ?? this.trackingLink,
        trackingId: trackingId ?? this.trackingId,
        paymentInfoDto: paymentInfoDto ?? this.paymentInfoDto,
        totalDiscountInRuppee: totalDiscountInRuppee ?? this.totalDiscountInRuppee,
        totalOrderPrice: totalOrderPrice ?? this.totalOrderPrice,
        createdAt: createdAt ?? this.createdAt,
        paymentModeDto: paymentModeDto ?? this.paymentModeDto,
        shippingCharge: shippingCharge ?? this.shippingCharge,
        refundStatus: refundStatus ?? this.refundStatus,
      );

  factory OrderDetailsAdmin.fromJson(Map<String, dynamic> json) => OrderDetailsAdmin(
    id: json["id"],
    userId: json["userId"],
    shippingAddress: json["shippingAddress"],
    billingAddress: json["billingAddress"],
    dateOfOrder: json["dateOfOrder"],
    orderStatusDto: json["orderStatusDto"],
    paymentStatusDto: json["paymentStatusDto"],
    orderedProductDetailsDto: List<OrderedProductDetailsDto>.from(json["orderedProductDetailsDto"].map((x) => OrderedProductDetailsDto.fromJson(x))),
    trackingServiceProvider: json["trackingServiceProvider"],
    trackingLink: json["trackingLink"],
    trackingId: json["trackingId"],
    paymentInfoDto: PaymentInfoDto.fromJson(json["paymentInfoDto"]),
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
    "orderedProductDetailsDto": List<dynamic>.from(orderedProductDetailsDto.map((x) => x.toJson())),
    "trackingServiceProvider": trackingServiceProvider,
    "trackingLink": trackingLink,
    "trackingId": trackingId,
    "paymentInfoDto": paymentInfoDto.toJson(),
    "totalDiscountInRuppee": totalDiscountInRuppee,
    "totalOrderPrice": totalOrderPrice,
    "createdAt": createdAt,
    "paymentModeDto": paymentModeDto,
    "shippingCharge": shippingCharge,
    "refundStatus": refundStatus,
  };
}

class OrderedProductDetailsDto {
  int id;
  dynamic productDto;
  int orderedQuantity;
  int orderedPrice;
  dynamic productMetaData;
  int createdAt;
  String productName;
  List<String> productMetadataUrls;

  OrderedProductDetailsDto({
    required this.id,
    required this.productDto,
    required this.orderedQuantity,
    required this.orderedPrice,
    required this.productMetaData,
    required this.createdAt,
    required this.productName,
    required this.productMetadataUrls,
  });

  OrderedProductDetailsDto copyWith({
    int? id,
    dynamic productDto,
    int? orderedQuantity,
    int? orderedPrice,
    dynamic productMetaData,
    int? createdAt,
    String? productName,
    List<String>? productMetadataUrls,
  }) =>
      OrderedProductDetailsDto(
        id: id ?? this.id,
        productDto: productDto ?? this.productDto,
        orderedQuantity: orderedQuantity ?? this.orderedQuantity,
        orderedPrice: orderedPrice ?? this.orderedPrice,
        productMetaData: productMetaData ?? this.productMetaData,
        createdAt: createdAt ?? this.createdAt,
        productName: productName ?? this.productName,
        productMetadataUrls: productMetadataUrls ?? this.productMetadataUrls,
      );

  factory OrderedProductDetailsDto.fromJson(Map<String, dynamic> json) => OrderedProductDetailsDto(
    id: json["id"],
    productDto: json["productDto"],
    orderedQuantity: json["orderedQuantity"],
    orderedPrice: json["orderedPrice"],
    productMetaData: json["productMetaData"],
    createdAt: json["createdAt"],
    productName: json["productName"],
    productMetadataUrls: List<String>.from(json["productMetadataUrls"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "productDto": productDto,
    "orderedQuantity": orderedQuantity,
    "orderedPrice": orderedPrice,
    "productMetaData": productMetaData,
    "createdAt": createdAt,
    "productName": productName,
    "productMetadataUrls": List<dynamic>.from(productMetadataUrls.map((x) => x)),
  };
}

class PaymentInfoDto {
  dynamic id;
  dynamic price;
  String paymentStatusDto;
  dynamic transactionId;
  dynamic createdAt;
  dynamic razorpayOrderId;
  dynamic razorpayPaymentId;
  dynamic razorpaySignature;

  PaymentInfoDto({
    required this.id,
    required this.price,
    required this.paymentStatusDto,
    required this.transactionId,
    required this.createdAt,
    required this.razorpayOrderId,
    required this.razorpayPaymentId,
    required this.razorpaySignature,
  });

  PaymentInfoDto copyWith({
    dynamic id,
    dynamic price,
    String? paymentStatusDto,
    dynamic transactionId,
    dynamic createdAt,
    dynamic razorpayOrderId,
    dynamic razorpayPaymentId,
    dynamic razorpaySignature,
  }) =>
      PaymentInfoDto(
        id: id ?? this.id,
        price: price ?? this.price,
        paymentStatusDto: paymentStatusDto ?? this.paymentStatusDto,
        transactionId: transactionId ?? this.transactionId,
        createdAt: createdAt ?? this.createdAt,
        razorpayOrderId: razorpayOrderId ?? this.razorpayOrderId,
        razorpayPaymentId: razorpayPaymentId ?? this.razorpayPaymentId,
        razorpaySignature: razorpaySignature ?? this.razorpaySignature,
      );

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
