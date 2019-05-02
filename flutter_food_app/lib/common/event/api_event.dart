import 'package:flutter_food_app/api/model/menu.dart';

abstract class ApiEvent{}

class ChangeListMenu extends ApiEvent{
  final List<Menu> listMenu;
  ChangeListMenu(this.listMenu);
}
