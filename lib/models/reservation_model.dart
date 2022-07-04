// To parse this JSON data, do
//
//     final reservationModel = reservationModelFromJson(jsonString);

import 'dart:convert';

ReservationsModel reservationModelFromJson(dynamic str) => ReservationsModel.fromJson(json.decode(str));

// dynamic reservationModelToJson(ReservationModel data) => json.encode(data.toJson());

class ReservationsModel {
  ReservationsModel({
    this.status,
    this.message,
    this.data,
  });

  dynamic status;
  dynamic message;
  List<ReservationData>? data;

  factory ReservationsModel.fromJson(Map<dynamic, dynamic> json) => ReservationsModel(
    status: json["status"],
    message: json["message"],
    data: List<ReservationData>.from(json["data"].map((x) => ReservationData.fromJson(x))),
  );
}

class ReservationData {
  ReservationData({
    this.id,
    this.time,
    this.timing,
    this.date,
    this.appointmentId,
    this.type,
    this.status,
    this.testName,
    this.technicalId,
  });

  dynamic id;
  dynamic time;
  dynamic timing;
  dynamic date;
  dynamic appointmentId;
  dynamic type;
  dynamic status;
  dynamic testName;
  dynamic technicalId;

  factory ReservationData.fromJson(Map<dynamic, dynamic> json) => ReservationData(
    id: json["id"],
    time: json["time"],
    timing: json["timing"],
    date: json["date"],
    appointmentId: json["appointment_id"],
    type: json["type"],
    status: json["status"],
    testName: json["test_name"],
    technicalId: json["technical_id"],
  );
}
