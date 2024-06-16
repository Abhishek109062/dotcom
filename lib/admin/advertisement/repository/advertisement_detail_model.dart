import 'dart:convert';

List<AdvertisementDetailsDto> advertisementDetailsDtoFromJson(List<dynamic> str) => List<AdvertisementDetailsDto>.from(str.map((x) => AdvertisementDetailsDto.fromJson(x)));

String advertisementDetailsDtoToJson(List<AdvertisementDetailsDto> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AdvertisementDetailsDto {
  int id;
  int productId;
  String bannerUrl;

  AdvertisementDetailsDto({
    required this.id,
    required this.productId,
    required this.bannerUrl,
  });

  AdvertisementDetailsDto copyWith({
    int? id,
    int? productId,
    String? bannerUrl,
  }) =>
      AdvertisementDetailsDto(
        id: id ?? this.id,
        productId: productId ?? this.productId,
        bannerUrl: bannerUrl ?? this.bannerUrl,
      );

  factory AdvertisementDetailsDto.fromJson(Map<String, dynamic> json) => AdvertisementDetailsDto(
    id: json["id"],
    productId: json["productId"],
    bannerUrl: json["bannerUrl"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "productId": productId,
    "bannerUrl": bannerUrl,
  };
}
