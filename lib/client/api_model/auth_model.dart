import 'dart:convert';

import '../../core/user/user_model.dart';

AuthDetails authDetailsFromJson(String str) => AuthDetails.fromJson(json.decode(str));

String authDetailsToJson(AuthDetails data) => json.encode(data.toJson());

class AuthDetails {
  String? jwt;

  UserDetails? usersDto;

  AuthDetails({
    required this.jwt,
    required this.usersDto,
  });

  AuthDetails copyWith({
    String? jwt,
    String? refreshToken,
    UserDetails? usersDto,
  }) =>
      AuthDetails(
        jwt: jwt ?? this.jwt,
        usersDto: usersDto ?? this.usersDto,
      );

  factory AuthDetails.fromJson(Map<String, dynamic> json) => AuthDetails(
        jwt: json["jwt"],
        usersDto: json["usersDto"] != null ? UserDetails.fromJson(json["usersDto"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "jwt": jwt,
        "usersDto": usersDto?.toJson(),
      };
}
