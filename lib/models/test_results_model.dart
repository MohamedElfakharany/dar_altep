// To parse this JSON data, do
//
//     final testResultModel = testResultModelFromJson(jsonString);

import 'dart:convert';

TestResultModel testResultModelFromJson(dynamic str) => TestResultModel.fromJson(json.decode(str));

// dynamic testResultModelToJson(TestResultModel data) => json.encode(data.toJson());

class TestResultModel {
  TestResultModel({
    this.status,
    this.message,
    this.data,
  });

  dynamic status;
  dynamic message;
  Data? data;

  factory TestResultModel.fromJson(Map<dynamic, dynamic> json) => TestResultModel(
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
    this.time,
    this.date,
    this.image,
    this.seen,
    this.type,
    this.name,
  });

  dynamic id;
  dynamic time;
  dynamic date;
  dynamic image;
  dynamic seen;
  dynamic type;
  dynamic name;

  factory Data.fromJson(Map<dynamic, dynamic> json) => Data(
    id: json["id"],
    time: json["time"],
    date: (json["date"]),
    image: json["image"],
    seen: json["seen"],
    type: json["type"],
    name: json["name"],
  );

  // Map<dynamic, dynamic> toJson() => {
  //   "id": id,
  //   "time": time,
  //   "date": date,
  //   "image": image,
  //   "seen": seen,
  //   "type": type,
  //   "name": name,
  // };
}
