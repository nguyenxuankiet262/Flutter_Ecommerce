import 'package:flutter_food_app/api/model/user.dart';

class Feedbacks {
  String id;
  String userFb;
  String feedBack;
  String title;
  DateTime day;
  User user;
  int v;
  String reply;

  Feedbacks({
    this.id,
    this.userFb,
    this.feedBack,
    this.title,
    this.day,
    this.v,
    this.reply,
    this.user,
  });

  factory Feedbacks.fromJson(Map<String, dynamic> json) => new Feedbacks(
    id: json["_id"],
    userFb: json["userFB"],
    feedBack: json["feedBack"],
    title: json["title"],
    day: DateTime.parse(json["day"]),
    v: json["__v"],
    reply: json["reply"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userFB": userFb,
    "feedBack": feedBack,
    "title": title,
    "day": day.toIso8601String(),
    "__v": v,
    "reply": reply,
  };
}