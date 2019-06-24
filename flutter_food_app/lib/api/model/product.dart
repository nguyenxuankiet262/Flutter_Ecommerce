import 'package:flutter_food_app/api/model/rating_product.dart';
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
  String unit;
  DateTime date;
  User user;
  List<Product> relativeProduct;
  List<RatingProduct> listRating;
  List<RatingProduct> listAllRating;
  double rate;
  int amountFav;
  bool isFavorite;

  Product({this.id, this.images, this.proved, this.status, this.name,
      this.idType, this.description, this.initPrice, this.currentPrice, this.idUser, this.date, this.user, this.relativeProduct, this.listRating, this.rate, this.amountFav, this.isFavorite, this.unit, this.listAllRating});

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
      unit : json['unit'],
      date: DateTime.parse(json["day"]),
      amountFav: json['like'],
      images: new List<String>.from(json["img"].map((x) => x)),
    );
  }
  Map<String, dynamic> toJson() => {
    "img": new List<dynamic>.from(images.map((x) => x)),
    "proved": proved,
    "status": status,
    "_id": id,
    "name": name,
    "idtype": idType,
    "description": description,
    "initprice": initPrice,
    "currentprice": currentPrice,
    "iduser": idUser,
    "unit": unit,
    "day": date.toIso8601String(),
  };
}