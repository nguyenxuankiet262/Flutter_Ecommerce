import 'package:flutter_food_app/api/model/items.dart';
import 'package:flutter_food_app/api/model/product.dart';
import 'package:flutter_food_app/api/model/user.dart';

class Order {
  List<Items> product;
  List<Product> listProduct;
  User userSeller;
  User userOrder;
  int status;
  String id;
  String idUser;
  String idOrder;
  DateTime day;
  int v;

  Order({
    this.product,
    this.status,
    this.id,
    this.idUser,
    this.idOrder,
    this.day,
    this.v,
  });

  factory Order.fromJson(Map<String, dynamic> json) => new Order(
    product: new List<Items>.from(json["product"].map((x) => Items.fromJson(x))),
    status: json["status"],
    id: json["_id"],
    idUser: json["IDUser"],
    idOrder: json["IDOrder"],
    day: DateTime.parse(json["day"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "product": new List<dynamic>.from(product.map((x) => x.toJson())),
    "status": status,
    "_id": id,
    "IDUser": idUser,
    "IDOrder": idOrder,
    "day": day.toIso8601String(),
    "__v": v,
  };
}