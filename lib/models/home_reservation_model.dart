// To parse this JSON data, do
//
//     final reservationsModel = reservationsModelFromJson(jsonString);

import 'dart:convert';

HomeReservationsModel reservationsModelFromJson(dynamic str) => HomeReservationsModel.fromJson(json.decode(str));

// dynamic reservationsModelToJson(HomeReservationsModel data) => json.encode(data.toJson());

class HomeReservationsModel {
  HomeReservationsModel({
    this.status,
    this.message,
    this.data,
  });

  dynamic status;
  dynamic message;
  Data? data;

  factory HomeReservationsModel.fromJson(Map<dynamic, dynamic> json) => HomeReservationsModel(
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
    this.userId,
    this.date,
    this.time,
    this.name,
    this.phone,
    this.address,
    this.testName,
    this.type,
  });

  dynamic userId;
  dynamic date;
  dynamic time;
  dynamic name;
  dynamic phone;
  dynamic address;
  dynamic testName;
  dynamic type;

  factory Data.fromJson(Map<dynamic, dynamic> json) => Data(
    userId: json["user_id"],
    date: json["date"],
    time: json["time"],
    name: json["name"],
    phone: json["phone"],
    address: json["Address"],
    testName: json["test_name"],
    type: json["type"],
  );

  Map<dynamic, dynamic> toJson() => {
    "user_id": userId,
    "date": date,
    "time": time,
    "name": name,
    "phone": phone,
    "Address": address,
    "test_name": testName,
    "type": type,
  };
}
