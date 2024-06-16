// To parse this JSON data, do
//
//     final addOrderDetailsResponseModel = addOrderDetailsResponseModelFromJson(jsonString);

import 'dart:convert';

import 'add_order_details_request_model.dart';

AddOrderDetailsResponseModel addOrderDetailsResponseModelFromJson(String str) =>
    AddOrderDetailsResponseModel.fromJson(json.decode(str));

String addOrderDetailsResponseModelToJson(AddOrderDetailsResponseModel data) =>
    json.encode(data.toJson());

class AddOrderDetailsResponseModel {
  List<CreateOrderProduct>? createOrderProduct;
  String? paymentMode;
  String? shippingAddress;
  String? billingAddress;
  RazorpayOrderDto? razorpayOrderDto;

  AddOrderDetailsResponseModel({
    required this.createOrderProduct,
    required this.paymentMode,
    required this.shippingAddress,
    required this.billingAddress,
    required this.razorpayOrderDto,
  });

  factory AddOrderDetailsResponseModel.fromJson(Map<String, dynamic> json) =>
      AddOrderDetailsResponseModel(
        createOrderProduct: json["createOrderProduct"] == null
            ? []
            : List<CreateOrderProduct>.from(
                json["createOrderProduct"]!.map((x) => CreateOrderProduct.fromJson(x))),
        paymentMode: json["paymentMode"],
        shippingAddress: json["shippingAddress"],
        billingAddress: json["billingAddress"],
        razorpayOrderDto: json["razorpayOrderDto"] == null
            ? null
            : RazorpayOrderDto.fromJson(json["razorpayOrderDto"]),
      );

  Map<String, dynamic> toJson() => {
        "createOrderProduct": createOrderProduct == null
            ? []
            : List<dynamic>.from(createOrderProduct!.map((x) => x.toJson())),
        "paymentMode": paymentMode,
        "shippingAddress": shippingAddress,
        "billingAddress": billingAddress,
        "razorpayOrderDto": razorpayOrderDto?.toJson(),
      };
}

class RazorpayOrderDto {
  int? amount;
  int? amountPaid;
  dynamic notes;
  int? createdAt;
  int? amountDue;
  String? currency;
  dynamic receipt;
  String? id;
  dynamic entity;
  String? status;
  int? attempts;

  RazorpayOrderDto({
    required this.amount,
    required this.amountPaid,
    required this.notes,
    required this.createdAt,
    required this.amountDue,
    required this.currency,
    required this.receipt,
    required this.id,
    required this.entity,
    required this.status,
    required this.attempts,
  });

  factory RazorpayOrderDto.fromJson(Map<String, dynamic> json) => RazorpayOrderDto(
        amount: json["amount"],
        amountPaid: json["amount_paid"],
        notes: json["notes"],
        createdAt: json["created_at"],
        amountDue: json["amount_due"],
        currency: json["currency"],
        receipt: json["receipt"],
        id: json["id"],
        entity: json["entity"],
        status: json["status"],
        attempts: json["attempts"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "amount_paid": amountPaid,
        "notes": notes,
        "created_at": createdAt,
        "amount_due": amountDue,
        "currency": currency,
        "receipt": receipt,
        "id": id,
        "entity": entity,
        "status": status,
        "attempts": attempts,
      };
}
