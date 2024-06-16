
import 'dart:convert';

UpdateSubadminModel updateSubadminModelFromJson(String str) => UpdateSubadminModel.fromJson(json.decode(str));

String updateSubadminModelToJson(UpdateSubadminModel data) => json.encode(data.toJson());

class UpdateSubadminModel {
  int id;
  String name;
  String email;
  int mobileNo;
  int pincode;
  String district;
  String address;
  String state;
  int createdAt;
  String profilePicUrl;
  String city;
  String password;
  bool block;
  UpdateSubadminModel({
    required this.id,
    required this.name,
    required this.email,
    required this.mobileNo,
    required this.pincode,
    required this.district,
    required this.address,
    required this.state,
    required this.createdAt,
    required this.profilePicUrl,
    required this.city,
    required this.password,
    required this.block
  });

  UpdateSubadminModel copyWith({
    int? id,
    String? name,
    String? email,
    int? mobileNo,
    int? pincode,
    String? district,
    String? address,
    String? state,
    int? createdAt,
    String? profilePicUrl,
    String? city,
    String? password,
    bool? block
  }) =>
      UpdateSubadminModel(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        mobileNo: mobileNo ?? this.mobileNo,
        pincode: pincode ?? this.pincode,
        district: district ?? this.district,
        address: address ?? this.address,
        state: state ?? this.state,
        createdAt: createdAt ?? this.createdAt,
        profilePicUrl: profilePicUrl ?? this.profilePicUrl,
        city: city ?? this.city,
        password: password ?? this.password,
        block: block ?? this.block
      );

  factory UpdateSubadminModel.fromJson(Map<String, dynamic> json) => UpdateSubadminModel(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    mobileNo: int.parse(json["mobileNo"]),
    pincode: json["pincode"],
    district: json["district"] ?? "",
    address: json["address"] ?? "",
    state: json["state"] ?? "",
    createdAt: json["createdAt"] ?? DateTime.now(),
    profilePicUrl: json["profilePicUrl"] ?? "",
    city: json["city"] ?? "",
    password: json["password"] ?? "",
    block: json["block"] ?? false
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "mobileNo": mobileNo,
    "pincode": pincode,
    // "district": district ?? "",
    // "address": address ?? "",
    // "state": state ?? "",
    // "createdAt": createdAt,
    "profilePicUrl": profilePicUrl,
    // "city": city ?? "",
    "password": password ?? "",
  };
}
