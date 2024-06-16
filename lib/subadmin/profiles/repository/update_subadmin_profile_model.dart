// To parse this JSON data, do
//
//     final updateSubadminProfile = updateSubadminProfileFromJson(jsonString);

import 'dart:convert';

UpdateSubadminProfile updateSubadminProfileFromJson(String str) =>
    UpdateSubadminProfile.fromJson(json.decode(str));

String updateSubadminProfileToJson(UpdateSubadminProfile data) => json.encode(data.toJson());

class UpdateSubadminProfile {
  String? name;
  String? email;
  int? mobileNo;
  int? pincode;
  String? district;
  String? address;
  String? state;
  String? profilePicUrl;
  String? city;

  UpdateSubadminProfile({
    this.name,
    this.email,
    this.mobileNo,
    this.pincode,
    this.district,
    this.address,
    this.state,
    this.profilePicUrl,
    this.city,
  });

  UpdateSubadminProfile copyWith({
    String? name,
    String? email,
    int? mobileNo,
    int? pincode,
    String? district,
    String? address,
    String? state,
    String? profilePicUrl,
    String? city,
  }) =>
      UpdateSubadminProfile(
        name: name ?? this.name,
        email: email ?? this.email,
        mobileNo: mobileNo ?? this.mobileNo,
        pincode: pincode ?? this.pincode,
        district: district ?? this.district,
        address: address ?? this.address,
        state: state ?? this.state,
        profilePicUrl: profilePicUrl ?? this.profilePicUrl,
        city: city ?? this.city,
      );

  factory UpdateSubadminProfile.fromJson(Map<String, dynamic> json) => UpdateSubadminProfile(
        name: json["name"] ?? "",
        email: json["email"] ?? "",
        mobileNo: json["mobileNo"],
        pincode: json["pincode"],
        district: json["district"] ?? "",
        address: json["address"] ?? "",
        state: json["state"] ?? "",
        profilePicUrl: json["profilePicUrl"] ?? "",
        city: json["city"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "mobileNo": mobileNo,
        "pincode": pincode,
        "district": district,
        "address": address,
        "state": state,
        "profilePicUrl": profilePicUrl,
        "city": city,
      };
}
