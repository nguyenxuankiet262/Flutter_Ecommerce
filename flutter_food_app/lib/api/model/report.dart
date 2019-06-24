import 'package:flutter_food_app/api/model/product.dart';
import 'package:flutter_food_app/api/model/user.dart';

class Report {
  bool status;
  String id;
  String idUser;
  User userReport;
  Product product;
  String reason;
  DateTime time;
  int v;

  Report({
    this.status,
    this.id,
    this.idUser,
    this.userReport,
    this.product,
    this.reason,
    this.time,
    this.v,
  });

  factory Report.fromJson(Map<String, dynamic> json) => new Report(
    status: json["status"],
    id: json["_id"],
    idUser: json["userreport"],
    product: Product.fromJson(json["product"]),
    reason: json["reason"],
    time: DateTime.parse(json["time"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "_id": id,
    "userreport": idUser,
    "product": product.toJson(),
    "reason": reason,
    "time": time.toIso8601String(),
    "__v": v,
  };
}