import 'package:flutter_food_app/api/model/user.dart';

class Product {
  String id;
  List<String> images;
  bool proved;
  bool status;
  String name;
  String idType;
  String description;
  String initPrice;
  String currentPrice;
  String idUser;
  DateTime date;
  User user;



  Product({this.id, this.images, this.proved, this.status, this.name,
      this.idType, this.description, this.initPrice, this.currentPrice, this.idUser, this.date, this.user});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'],
      proved: json['proved'],
      status: json['status'],
      name: json['name'],
      idType: json['idtype'],
      description: json['description'],
      initPrice: json['initprice'].toString(),
      currentPrice: json['currentprice'].toString(),
      idUser: json['iduser'],
      date: DateTime.parse(json["day"]),
      images: new List<String>.from(json["img"].map((x) => x)),
    );
  }
}