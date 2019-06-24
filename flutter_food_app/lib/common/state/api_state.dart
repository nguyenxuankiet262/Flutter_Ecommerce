import 'package:flutter_food_app/api/model/banner.dart';
import 'package:flutter_food_app/api/model/cart.dart';
import 'package:flutter_food_app/api/model/menu.dart';
import 'package:flutter_food_app/api/model/product.dart';
import 'package:flutter_food_app/api/model/user.dart';

class ApiState {
  final List<Menu> listMenu;
  final Cart cart;
  final User mainUser;
  final List<Banners> listBanner;
  final List<Product> tenNewest;
  final List<Product> tenMostFav;

  const ApiState({
    this.listMenu,
    this.cart,
    this.mainUser,
    this.listBanner,
    this.tenNewest,
    this.tenMostFav,
  });

  factory ApiState.initial() => ApiState(
        listMenu: new List<Menu>(),
        cart: null,
        mainUser: null,
        listBanner: new List<Banners>(),
        tenNewest: null,
        tenMostFav: null,
      );
}
