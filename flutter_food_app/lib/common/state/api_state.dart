import 'package:flutter_food_app/api/model/child_menu.dart';
import 'package:flutter_food_app/api/model/menu.dart';

class ApiState {
  final List<Menu> listMenu;
  final List<ChildMenu> listChildMenu;

  const ApiState({this.listMenu, this.listChildMenu});

  factory ApiState.initial() => ApiState(
        listMenu: new List<Menu>(),
        listChildMenu: new List<ChildMenu>(),
      );
}
