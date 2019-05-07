import 'package:flutter_food_app/api/model/child_menu.dart';
import 'package:flutter_food_app/api/model/menu.dart';

abstract class ApiEvent{}

class ChangeListMenu extends ApiEvent{
  final List<Menu> listMenu;
  ChangeListMenu(this.listMenu);
}

class ChangeListChildMenu extends ApiEvent{
  final List<ChildMenu> listChildMenu;
  ChangeListChildMenu(this.listChildMenu);
}

