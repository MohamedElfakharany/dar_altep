// To parse this JSON data, do
//
//     final offersModel = offersModelFromJson(jsonString);

import 'dart:convert';

OffersModel offersModelFromJson(dynamic str) => OffersModel.fromJson(json.decode(str));

dynamic offersModelToJson(OffersModel data) => json.encode(data.toJson());

class OffersModel {
  OffersModel({
    this.status,
    this.message,
    this.data,
  });

  dynamic status;
  dynamic message;
  List<OffersData>? data = [];

  factory OffersModel.fromJson(Map<dynamic, dynamic> json) => OffersModel(
    status: json["status"],
    message: json["message"],
    data: List<OffersData>.from(json["data"].map((x) => OffersData.fromJson(x))),
  );

  Map<dynamic, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class OffersData {
  OffersData({
    this.id,
    this.name,
    this.description,
    this.type,
    this.duration,
    this.price,
    this.discount,
    this.image,
  });

  dynamic id;
  dynamic name;
  dynamic description;
  dynamic type;
  dynamic duration;
  dynamic price;
  dynamic discount;
  dynamic image;

  factory OffersData.fromJson(Map<dynamic, dynamic> json) => OffersData(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    type: json["type"],
    duration: json["duration"],
    price: json["price"],
    discount: json["discount"],
    image: json["image"],
  );

  Map<dynamic, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "type": type,
    "duration": duration,
    "price": price,
    "discount": discount,
    "image": image,
  };
}

