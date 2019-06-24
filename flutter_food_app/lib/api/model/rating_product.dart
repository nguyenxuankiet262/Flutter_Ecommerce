import 'package:flutter_food_app/api/model/user.dart';

class RatingProduct{
  bool status;
  String id;
  String idproduct;
  String iduserrating;
  double rating;
  String comment;
  DateTime day;
  User user;

  RatingProduct({
    this.status,
    this.id,
    this.idproduct,
    this.iduserrating,
    this.rating,
    this.comment,
    this.day,
    this.user,
  });

  factory RatingProduct.fromJson(Map<String, dynamic> json) {
    return RatingProduct(
      status: json["status"],
      id: json["_id"],
      idproduct: json["idproduct"],
      iduserrating: json["iduserrating"],
      rating: json["rating"].toDouble(),
      comment: json["comment"],
      day: DateTime.parse(json["day"]),
    );
  }
}