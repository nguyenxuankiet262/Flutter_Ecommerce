import 'package:flutter_food_app/api/model/badge.dart';
import 'package:flutter_food_app/api/model/feedback.dart';
import 'package:flutter_food_app/api/model/follow_notice.dart';
import 'package:flutter_food_app/api/model/system_noti.dart';
import 'package:flutter_food_app/api/model/order.dart';
import 'package:flutter_food_app/api/model/product.dart';
import 'package:flutter_food_app/api/model/rating.dart';

class User {
  bool status;
  bool vip;
  String id;
  String username;
  String password;
  String avatar;
  String phone;
  String address;
  String name;
  String coverphoto;
  String intro;
  String link;
  DateTime day;
  String token;
  double rate;
  int amountSystemNotice = 0;
  int amountFollowNotice = 0;
  List<SystemNotice> listSystemNotice;
  List<FollowNotice> listFollowNotice;
  List<Product> listProducts;
  List<Rating> listRatings;
  List<Product> listFav;
  List<User> listFollowing;
  List<User> listFollowed;
  List<Product> listProductShow;
  List<Order> listOrders;
  List<Feedbacks> listRepFeedback;
  List<Feedbacks> listUnrepFeedback;
  Badge badge;
  int amountPost;
  int amountFollowed;
  int amountFollowing;
  List<Order> listNewOrder;
  List<Order> listSuccessOrder;
  List<Order> listCancelOrder;

  User({this.status, this.vip, this.id, this.username, this.password,
      this.avatar, this.phone, this.address, this.name, this.coverphoto, this.intro,
      this.link, this.day, this.listProducts, this.listRatings, this.rate, this.listFav, this.listFollowing, this.listFollowed, this.listProductShow, this.listOrders, this.listSystemNotice, this.badge
    ,this.amountPost, this.amountFollowed, this.amountFollowing,this.listRepFeedback, this.listUnrepFeedback, this.listNewOrder, this.listSuccessOrder, this.listCancelOrder, this.token
  });

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
      intro: json["intro"],
      token: json["firebasetoken"],
    );
  }
}