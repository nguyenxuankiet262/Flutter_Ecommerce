import 'package:flutter_food_app/api/model/product.dart';
import 'package:flutter_food_app/api/model/rating.dart';

class User {
  final bool status;
  final bool vip;
  final String id;
  final String username;
  final String password;
  final String avatar;
  final String phone;
  final String address;
  final String name;
  final String coverphoto;
  final String intro;
  final String link;
  final DateTime day;
  List<Product> listProducts;
  List<Rating> listRatings;

  User({this.status, this.vip, this.id, this.username, this.password,
      this.avatar, this.phone, this.address, this.name, this.coverphoto, this.intro,
      this.link, this.day, this.listProducts, this.listRatings});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      status: json["status"],
      vip: json["vip"],
      id: json["_id"],
      username: json["username"],
      password: json["password"],
      avatar: json["avatar"],
      phone: json["phone"],
      address: json["address"],
      name: json["name"],
      coverphoto: json["coverphoto"],
      link: json["link"],
      day: DateTime.parse(json["day"]),
      intro: json["intro"]
    );
  }
}