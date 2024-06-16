// To parse this JSON data, do
//
//     final subAdminDto = subAdminDtoFromJson(jsonString);

import 'dart:convert';

List<SubAdminDto> subAdminDtoFromJson(List<dynamic> str) => List<SubAdminDto>.from(str.map((x) => SubAdminDto.fromJson(x)));

String subAdminDtoToJson(List<SubAdminDto> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SubAdminDto {
  int id;
  String name;
  dynamic dateOfBirth;
  String email;
  String mobileNo;
  int pincode;
  String district;
  String address;
  String state;
  int createdAt;
  String profilePicUrl;
  dynamic gender;
  String city;
  dynamic password;
  dynamic role;

  SubAdminDto({
    required this.id,
    required this.name,
    required this.dateOfBirth,
    required this.email,
    required this.mobileNo,
    required this.pincode,
    required this.district,
    required this.address,
    required this.state,
    required this.createdAt,
    required this.profilePicUrl,
    required this.gender,
    required this.city,
    required this.password,
    required this.role,
  });

  SubAdminDto copyWith({
    int? id,
    String? name,
    dynamic dateOfBirth,
    String? email,
    String? mobileNo,
    int? pincode,
    String? district,
    String? address,
    String? state,
    int? createdAt,
    String? profilePicUrl,
    dynamic gender,
    String? city,
    dynamic password,
    dynamic role,
  }) =>
      SubAdminDto(
        id: id ?? this.id,
        name: name ?? this.name,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        email: email ?? this.email,
        mobileNo: mobileNo ?? this.mobileNo,
        pincode: pincode ?? this.pincode,
        district: district ?? this.district,
        address: address ?? this.address,
        state: state ?? this.state,
        createdAt: createdAt ?? this.createdAt,
        profilePicUrl: profilePicUrl ?? this.profilePicUrl,
        gender: gender ?? this.gender,
        city: city ?? this.city,
        password: password ?? this.password,
        role: role ?? this.role,
      );

  factory SubAdminDto.fromJson(Map<String, dynamic> json) => SubAdminDto(
    id: json["id"] ?? -1,
    name: json["name"] ?? "",
    dateOfBirth: json["dateOfBirth"],
    email: json["email"] ?? "",
    mobileNo: json["mobileNo"] ?? "",
    pincode: json["pincode"] ?? 0,
    district: json["district"] ?? "",
    address: json["address"] ?? "",
    state: json["state"] ?? "",
    createdAt: json["createdAt"] ?? DateTime.now().millisecondsSinceEpoch,
    profilePicUrl: json["profilePicUrl"] ?? "",
    gender: json["gender"] ?? "",
    city: json["city"] ?? "",
    password: json["password"] ?? "",
    role: json["role"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "dateOfBirth": dateOfBirth,
    "email": email,
    "mobileNo": mobileNo,
    "pincode": pincode,
    "district": district,
    "address": address,
    "state": state,
    "createdAt": createdAt,
    "profilePicUrl": profilePicUrl,
    "gender": gender,
    "city": city,
    "password": password,
    "role": role,
  };
}
