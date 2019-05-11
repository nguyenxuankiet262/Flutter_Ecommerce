import 'package:flutter_food_app/api/model/cart.dart';
import 'package:flutter_food_app/api/model/child_menu.dart';
import 'package:flutter_food_app/api/model/menu.dart';
import 'package:flutter_food_app/api/model/product.dart';
import 'package:flutter_food_app/api/model/user.dart';

abstract class ApiEvent{}

class ChangeListMenu extends ApiEvent{
  final List<Menu> listMenu;
  ChangeListMenu(this.listMenu);
}

class ChangeListChildMenu extends ApiEvent{
  final List<ChildMenu> listChildMenu;
  ChangeListChildMenu(this.listChildMenu);
}

class ChangeListProduct extends ApiEvent{
  final List<Product> listProduct;
  ChangeListProduct(this.listProduct);
}

class ChangeProduct extends ApiEvent{
  final Product product;
  ChangeProduct(this.product);
}

class ChangeMainUser extends ApiEvent{
  final User mainUser;
  ChangeMainUser(this.mainUser);
}

class ChangeCart extends ApiEvent{
  final Cart cart;
  ChangeCart(this.cart);
}