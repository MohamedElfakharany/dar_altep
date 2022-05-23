// To parse this JSON data, do
//
//     final testNameModel = testNameModelFromJson(jsonString);
import 'dart:convert';

TestNameModel testNameModelFromJson(dynamic str) => TestNameModel.fromJson(json.decode(str));

// dynamic testNameModelToJson(TestNameModel data) => json.encode(data.toJson());

class TestNameModel {
  TestNameModel({
    this.status,
    this.message,
    this.data,
  });

  dynamic status;
  dynamic message;
  List<TestModelData>? data;

  factory TestNameModel.fromJson(Map<dynamic, dynamic> json) => TestNameModel(
    status: json["status"],
    message: json["message"],
    data: List<TestModelData>.from(json["data"].map((x) => TestModelData.fromJson(x))),
  );

  // Map<dynamic, dynamic> toJson() => {
  //   "status": status,
  //   "message": message,
  //   "data": List<dynamic>.from(data.map((x) => x.toJson())),
  // };
}

class TestModelData {
  TestModelData({
    this.id,
    this.name,
  });

  dynamic id;
  dynamic name;

  factory TestModelData.fromJson(Map<dynamic, dynamic> json) => TestModelData(
    id: json["id"],
    name: json["name"],
  );

  Map<dynamic, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
