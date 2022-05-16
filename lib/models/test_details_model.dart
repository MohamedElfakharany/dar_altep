// To parse this JSON data, do
//
//     final testDetailsModel = testDetailsModelFromJson(jsonString);

import 'dart:convert';

TestDetailsModel testDetailsModelFromJson(dynamic str) => TestDetailsModel.fromJson(json.decode(str));

// dynamic testDetailsModelToJson(TestDetailsModel data) => json.encode(data.toJson());

class TestDetailsModel {
  TestDetailsModel({
    this.status,
    this.message,
    this.data,
  });

  dynamic status;
  dynamic message;
  Data? data;

  factory TestDetailsModel.fromJson(Map<dynamic, dynamic> json) => TestDetailsModel(
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  // Map<dynamic, dynamic> toJson() => {
  //   "status": status,
  //   "message": message,
  //   "data": data.toJson(),
  // };
}

class Data {
  Data({
    this.id,
    this.name,
    this.description,
    this.type,
    this.image,
    this.tests,
  });

  dynamic id;
  dynamic name;
  dynamic description;
  dynamic type;
  dynamic image;
  List<Test>? tests = [];

  factory Data.fromJson(Map<dynamic, dynamic> json) => Data(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    type: json["type"],
    image: json["image"],
    tests: List<Test>.from(json["tests"].map((x) => Test.fromJson(x))),
  );

  // Map<dynamic, dynamic> toJson() => {
  //   "id": id,
  //   "name": name,
  //   "description": description,
  //   "type": type,
  //   "image": image,
  //   "tests": List<dynamic>.from(tests.map((x) => x.toJson())),
  // };
}

class Test {
  Test({
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

  factory Test.fromJson(Map<dynamic, dynamic> json) => Test(
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
