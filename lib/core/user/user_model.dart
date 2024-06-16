
class UserDetails {
  int? id;
  String? name;
  dynamic dateOfBirth;
  String? email;
  String? mobileNo;
  int? pincode;
  String? district;
  String? address;
  String? state;
  dynamic createdAt;
  String? profilePicUrl;
  dynamic gender;
  String? city;
  dynamic password;
  String? role;

  UserDetails({
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

  UserDetails copyWith({
    int? id,
    String? name,
    dynamic dateOfBirth,
    String? email,
    String? mobileNo,
    int? pincode,
    String? district,
    String? address,
    String? state,
    dynamic createdAt,
    String? profilePicUrl,
    dynamic gender,
    String? city,
    dynamic password,
    String? role,
  }) =>
      UserDetails(
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

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
    id: json["id"],
    name: json["name"],
    dateOfBirth: json["dateOfBirth"],
    email: json["email"],
    mobileNo: json["mobileNo"],
    pincode: json["pincode"],
    district: json["district"],
    address: json["address"],
    state: json["state"],
    createdAt: json["createdAt"],
    profilePicUrl: json["profilePicUrl"],
    gender: json["gender"],
    city: json["city"],
    password: json["password"],
    role: json["role"],
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
