// To parse this JSON data, do
//
//     final testsModel = testsModelFromJson(jsonString);

import 'dart:convert';

TestsModel testsModelFromJson(dynamic str) => TestsModel.fromJson(json.decode(str));

// dynamic testsModelToJson(TestsModel data) => json.encode(data.toJson());

class TestsModel {
  TestsModel({
    this.status,
    this.message,
    this.data,
  });

  dynamic status;
  dynamic message;
  List<Datum>? data = [];

  factory TestsModel.fromJson(Map<dynamic, dynamic> json) => TestsModel(
    status: json["status"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  // Map<dynamic, dynamic> toJson() => {
  //   "status": status,
  //   "message": message,
  //   "data": List<dynamic>.from(data.map((x) => x.toJson())),
  // };
}

class Datum {
  Datum({
    this.id,
    this.name,
    this.description,
    this.type,
    this.duration,
    this.price,
    this.image,
  });

  dynamic id;
  dynamic name;
  dynamic description;
  dynamic type;
  dynamic duration;
  dynamic price;
  dynamic image;

  factory Datum.fromJson(Map<dynamic, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    type: json["type"],
    duration: json["duration"],
    price: json["price"],
    image: json["image"],
  );

  Map<dynamic, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "type": type,
    "duration": duration,
    "price": price,
    "image": image,
  };
}
