import 'dart:convert';

CancelReservationModel cancelReservationModelFromJson(dynamic str) => CancelReservationModel.fromJson(json.decode(str));

class CancelReservationModel {
  CancelReservationModel({
    this.status,
    this.message,
  });

  dynamic status;
  dynamic message;

  factory CancelReservationModel.fromJson(Map<dynamic, dynamic> json) => CancelReservationModel(
    status: json["status"],
    message: json["message"],
  );

  Map<dynamic, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}