// To parse this JSON data, do
//
//     final technicalModel = technicalModelFromJson(jsonString);

import 'dart:convert';

TechnicalModel technicalModelFromJson(dynamic str) => TechnicalModel.fromJson(json.decode(str));

class TechnicalModel {
  TechnicalModel({
    this.status,
    this.message,
    this.data,
  });

  dynamic status;
  dynamic message;
  TechnicalDataModel? data;

  factory TechnicalModel.fromJson(Map<dynamic, dynamic> json) => TechnicalModel(
    status: json["status"],
    message: json["message"],
    data: TechnicalDataModel.fromJson(json["data"]),
  );
}

class TechnicalDataModel {
  TechnicalDataModel({
    this.id,
    this.name,
    this.phone,
    this.rate,
    this.profession,
    this.image,
  });

  dynamic id;
  dynamic name;
  dynamic phone;
  dynamic rate;
  dynamic profession;
  dynamic image;

  factory TechnicalDataModel.fromJson(Map<dynamic, dynamic> json) => TechnicalDataModel(
    id: json["id"],
    name: json["name"],
    phone: json["phone"],
    rate: json["rate"],
    profession: json["profession"],
    image: json["image"],
  );
}
////////////////////////////////////////////////////////////////////////////////////////////////

RateTechnicalModel rateTechnicalModelFromJson(dynamic str) => RateTechnicalModel.fromJson(json.decode(str));

class RateTechnicalModel {
  RateTechnicalModel({
    this.status,
    this.message,
  });

  dynamic status;
  dynamic message;

  factory RateTechnicalModel.fromJson(Map<dynamic, dynamic> json) => RateTechnicalModel(
    status: json["status"],
    message: json["message"],
  );
}