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
  List<NotificationsData>? data;

  factory NotificationsModel.fromJson(Map<dynamic, dynamic> json) => NotificationsModel(
    status: json["status"],
    message: json["message"],
    data: List<NotificationsData>.from(json["data"].map((x) => NotificationsData.fromJson(x))),
  );
}

class NotificationsData {
  NotificationsData({
    this.type,
    this.message,
    this.title,
    this.date,
    this.time,
  });

  dynamic type;
  dynamic message;
  dynamic title;
  dynamic date;
  dynamic time;

  factory NotificationsData.fromJson(Map<dynamic, dynamic> json) => NotificationsData(
    type: json["type"],
    message: json["message"],
    title: json["title"],
    date: json["date"],
    time: json["time "],
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
