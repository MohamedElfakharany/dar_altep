// To parse this JSON data, do
//
//     final labReservationModel = labReservationModelFromJson(jsonString);

import 'dart:convert';

LabReservationModel labReservationModelFromJson(dynamic str) => LabReservationModel.fromJson(json.decode(str));

// dynamic labReservationModelToJson(LabReservationModel data) => json.encode(data.toJson());

class LabReservationModel {
  LabReservationModel({
    this.status,
    this.message,
    this.data,
  });

  dynamic status;
  dynamic message;
  Data? data;

  factory LabReservationModel.fromJson(Map<dynamic, dynamic> json) => LabReservationModel(
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
    this.type,
    this.testName,
  });

  dynamic userId;
  dynamic date;
  dynamic time;
  dynamic name;
  dynamic phone;
  dynamic type;
  dynamic testName;

  factory Data.fromJson(Map<dynamic, dynamic> json) => Data(
    userId: json["user_id"],
    date: json["date"],
    time: json["time"],
    name: json["name"],
    phone: json["phone"],
    type: json["type"],
    testName: json["test_name"],
  );

  // Map<dynamic, dynamic> toJson() => {
  //   "user_id": userId,
  //   "date": date,
  //   "time": time,
  //   "name": name,
  //   "phone": phone,
  //   "type": type,
  //   "test_name": testName,
  // };
}
