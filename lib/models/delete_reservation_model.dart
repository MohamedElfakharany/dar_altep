import 'dart:convert';

DeleteReservationModel deleteReservationModelFromJson(dynamic str) => DeleteReservationModel.fromJson(json.decode(str));

dynamic changeFavoritesModelToJson(DeleteReservationModel data) => json.encode(data.toJson());

class DeleteReservationModel {
  DeleteReservationModel({
    this.status,
    this.message,
  });

  dynamic status;
  dynamic message;

  factory DeleteReservationModel.fromJson(Map<dynamic, dynamic> json) => DeleteReservationModel(
    status: json["status"],
    message: json["message"],
  );

  Map<dynamic, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}