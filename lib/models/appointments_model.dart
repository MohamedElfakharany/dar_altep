// To parse this JSON data, do
//
//     final appointmentsModel = appointmentsModelFromJson(jsonString);

import 'dart:convert';

AppointmentsModel appointmentsModelFromJson(dynamic str) => AppointmentsModel.fromJson(json.decode(str));

// dynamic appointmentsModelToJson(AppointmentsModel data) => json.encode(data.toJson());

class AppointmentsModel {
  AppointmentsModel({
    this.status,
    this.message,
    this.data,
  });

  dynamic status;
  dynamic message;
  List<Datum>? data;

  factory AppointmentsModel.fromJson(Map<dynamic, dynamic> json) => AppointmentsModel(
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
    this.day,
    this.date,
    this.start_time,
    this.end_time,
    this.status,
  });

  dynamic id;
  dynamic day;
  dynamic date;
  dynamic start_time;
  dynamic end_time;
  dynamic status;

  factory Datum.fromJson(Map<dynamic, dynamic> json) => Datum(
    id: json["id"],
    day: json["day"],
    date: json["date"],
    start_time: json["start_time"],
    end_time: json["end_time"],
    status: json["status"],
  );

  // Map<dynamic, dynamic> toJson() => {
  //   "id": id,
  //   "day": day,
  //   "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
  //   "time": time,
  //   "status": status,
  // };
}
