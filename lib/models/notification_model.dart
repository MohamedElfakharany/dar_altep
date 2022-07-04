// To parse this JSON data, do
//
//     final resetPasswordModel = resetPasswordModelFromJson(jsonString);

import 'dart:convert';

NotificationsModel resetPasswordModelFromJson(dynamic str) => NotificationsModel.fromJson(json.decode(str));

class NotificationsModel {
  NotificationsModel({
    this.status,
    this.message,
    this.data,
  });

  dynamic status;
  dynamic message;
  List<NotificationsDataModel>? data;

  factory NotificationsModel.fromJson(Map<dynamic, dynamic> json) => NotificationsModel(
    status: json["status"],
    message: json["message"],
    data: List<NotificationsDataModel>.from(json["data"].map((x) => NotificationsDataModel.fromJson(x))),
  );
}

class NotificationsDataModel {
  NotificationsDataModel({
    this.type,
    this.message,
    this.title,
    this.date,
    this.time,
    this.seen,
    this.id,
  });

  dynamic type;
  dynamic message;
  dynamic title;
  dynamic date;
  dynamic time;
  dynamic seen;
  dynamic id;

  factory NotificationsDataModel.fromJson(Map<dynamic, dynamic> json) => NotificationsDataModel(
    type: json["type"],
    message: json["message"],
    title: json["title"],
    date: json["date"],
    time: json["time"],
    seen: json["seen"],
    id: json["id"],
  );
}
//////////////////////////////////////////////////////////////////////////////

DeleteNotificationsModel deleteNotificationsModelFromJson(dynamic str) => DeleteNotificationsModel.fromJson(json.decode(str));

class DeleteNotificationsModel {
  DeleteNotificationsModel({
    this.status,
    this.message,
  });

  dynamic status;
  dynamic message;

  factory DeleteNotificationsModel.fromJson(Map<dynamic, dynamic> json) => DeleteNotificationsModel(
    status: json["status"],
    message: json["message"],
  );
}

////////////////////////////////////////////////////////////////////////////////////

SeenNotificationsModel seenNotificationsModelFromJson(dynamic str) => SeenNotificationsModel.fromJson(json.decode(str));

class SeenNotificationsModel {
  SeenNotificationsModel({
    this.status,
    this.message,
  });

  dynamic status;
  dynamic message;

  factory SeenNotificationsModel.fromJson(Map<dynamic, dynamic> json) => SeenNotificationsModel(
    status: json["status"],
    message: json["message"],
  );
}