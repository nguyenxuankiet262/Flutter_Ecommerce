import 'package:flutter_food_app/api/model/menu.dart';

class ApiState{
  final List<Menu> listMenu;

  const ApiState({this.listMenu});

  factory ApiState.initial() => ApiState(listMenu: new List<Menu>());
}