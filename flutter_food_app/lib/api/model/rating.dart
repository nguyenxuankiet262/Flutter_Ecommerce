import 'package:flutter_food_app/api/model/user.dart';

class Rating{
  bool status;
  String id;
  String iduser;
  String iduserrating;
  double rating;
  String comment;
  DateTime day;
  User user;

  Rating({
    this.status,
    this.id,
    this.iduser,
    this.iduserrating,
    this.rating,
    this.comment,
    this.day,
    this.user,
  });

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      status: json["status"],
      id: json["_id"],
      iduser: json["iduser"],
      iduserrating: json["iduserrating"],
      rating: json["rating"],
      comment: json["comment"],
      day: DateTime.parse(json["day"]),
    );
  }
}