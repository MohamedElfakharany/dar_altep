// To parse this JSON data, do
//
//     final homeAppointmentsModel = homeAppointmentsModelFromJson(jsonString);

import 'dart:convert';

HomeAppointmentsModel homeAppointmentsModelFromJson(dynamic str) => HomeAppointmentsModel.fromJson(json.decode(str));

class HomeAppointmentsModel {
  HomeAppointmentsModel({
    this.status,
    this.message,
    this.data,
  });

  dynamic status;
  dynamic message;
  List<HomeAppointmentsDataModel>? data;

  factory HomeAppointmentsModel.fromJson(Map<dynamic, dynamic> json) => HomeAppointmentsModel(
    status: json["status"],
    message: json["message"],
    data: List<HomeAppointmentsDataModel>.from(json["data"].map((x) => HomeAppointmentsDataModel.fromJson(x))),
  );
}

class HomeAppointmentsDataModel {
  HomeAppointmentsDataModel({
    this.timing,
    this.date,
    this.startTime,
    this.endTime,
  });

  dynamic timing;
  dynamic date;
  dynamic startTime;
  dynamic endTime;
  factory HomeAppointmentsDataModel.fromJson(Map<dynamic, dynamic> json) => HomeAppointmentsDataModel(
    timing: json["timing"],
    date: json["date"],
    startTime: json["start_period"],
    endTime: json["end_period"],
  );
}
