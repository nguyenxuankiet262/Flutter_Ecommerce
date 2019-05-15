import 'package:flutter_food_app/api/model/cart.dart';
import 'package:flutter_food_app/api/model/child_menu.dart';
import 'package:flutter_food_app/api/model/menu.dart';
import 'package:flutter_food_app/api/model/product.dart';
import 'package:flutter_food_app/api/model/user.dart';

class ApiState {
  final List<Menu> listMenu;
  final List<Product> listProduct;
  final Cart cart;
  final Product product;
  final User mainUser;

  const ApiState({this.listMenu, this.listProduct, this.cart, this.product, this.mainUser});

  factory ApiState.initial() => ApiState(
        listMenu: new List<Menu>(),
        listProduct: new List<Product>(),
        cart: null,
        product: null,
        mainUser: null,
      );
}
