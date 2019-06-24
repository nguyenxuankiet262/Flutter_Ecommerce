import 'package:flutter_food_app/api/model/order.dart';

class SystemNotice {
  String idOrderSell;
  bool seen;
  DateTime day;
  String idOrderBuy;
  String idDeleted;
  String idProved;
  String img;
  Order order;

  SystemNotice({
    this.idOrderSell,
    this.seen,
    this.day,
    this.idOrderBuy,
    this.idDeleted,
    this.img,
    this.idProved,
    this.order,
  });

  factory SystemNotice.fromJson(Map<String, dynamic> json) => new SystemNotice(
    idOrderSell: json["idOrder_Sell"] == null ? null : json["idOrder_Sell"],
    seen: json["seen"],
    img: json["img"],
    day: DateTime.parse(json["day"]),
    idOrderBuy: json["idOrder_Buy"] == null ? null : json["idOrder_Buy"],
    idDeleted: json["idDeleted"] == null ? null : json["idDeleted"],
    idProved: json["idProved"] == null ? null : json["idProved"],
  );

  Map<String, dynamic> toJson() => {
    "idOrder_Sell": idOrderSell == null ? null : idOrderSell,
    "seen": seen,
    "day": day.toIso8601String(),
    "idOrder_Buy": idOrderBuy == null ? null : idOrderBuy,
    "idDeleted": idDeleted == null ? null : idDeleted,
  };
}