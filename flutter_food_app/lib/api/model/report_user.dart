import 'package:flutter_food_app/api/model/user.dart';

class ReportUser {
  bool status;
  String id;
  String idUser;
  String idUserReport;
  String reason;
  User user;
  User userReport;
  DateTime day;
  int v;

  ReportUser({
    this.status,
    this.id,
    this.idUser,
    this.idUserReport,
    this.user,
    this.userReport,
    this.reason,
    this.day,
    this.v,
  });

  factory ReportUser.fromJson(Map<String, dynamic> json) => new ReportUser(
    status: json["status"],
    id: json["_id"],
    idUser: json["IDUser"]["_id"],
    idUserReport: json["IDUserReport"]["_id"],
    reason: json["reason"],
    day: DateTime.parse(json["day"]),
    v: json["__v"],
  );
}