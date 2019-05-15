import 'package:flutter_food_app/api/model/child_menu.dart';

class Menu {
  final String id;
  final String name;
  final String link;
  List<ChildMenu> listChildMenu;

  Menu({this.id, this.name,this.link});

  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      id: json['_id'],
      name: json['name'],
      link: json['link'],
    );
  }
}