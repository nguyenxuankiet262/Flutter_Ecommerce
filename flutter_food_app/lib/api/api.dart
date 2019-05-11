import 'dart:convert';
import 'package:flutter_food_app/api/model/cart.dart';
import 'package:flutter_food_app/api/model/child_menu.dart';
import 'package:flutter_food_app/api/model/menu.dart';
import 'package:flutter_food_app/api/model/product.dart';
import 'package:flutter_food_app/api/model/user.dart';
import 'package:flutter_food_app/common/bloc/api_bloc.dart';
import 'package:http/http.dart' as http;

final client = http.Client();
final String url = 'https://datnk15.herokuapp.com/api/';

//Lấy thông tin menu
fetchMenus(ApiBloc apiBloc) async {
  final response = await client.get(url + 'menu/getall');
  if (response.statusCode == 200) {
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
    List<Menu> temp = parsed.map<Menu>((json) => Menu.fromJson(json)).toList();
    temp.insert(0, Menu(id: "0", name: "Tất cả", link: ""));
    print(temp[0].link);
    apiBloc.changeMenu(temp);
  }
}

//Lấy thông tin child menu
fetchChildMenu(ApiBloc apiBloc, String id) async {
  final response = await client.get(url + 'menu/get-child/' + id);
  if (response.statusCode == 200) {
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
    List<ChildMenu> temp = parsed.map<ChildMenu>((json) => ChildMenu.fromJson(json)).toList();
    temp.insert(0, ChildMenu(id: "0", idMenu: id, name: "Tất cả", link: ""));
    apiBloc.changeChildMenu(temp);
  }
}

//Lấy thông tin sản phẩm theo id menu
fetchProductOfMenu(ApiBloc apiBloc, String idMenu) async{
  final response = await client.get(url + 'menu/get-products/' + idMenu);
  if (response.statusCode == 200) {
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
    List<Product> temp = parsed.map<Product>((json) => Product.fromJson(json)).toList();
    apiBloc.changeListProduct(temp);
  }
}

//Lấy thông tin sản phẩm theo id child menu
fetchProductOfChildMenu(ApiBloc apiBloc, String idChildMenu) async {
  final response = await client.get(url + 'childmenu/get-product/' + idChildMenu);
  if (response.statusCode == 200) {
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
    List<Product> temp = parsed.map<Product>((json) => Product.fromJson(json)).toList();
    apiBloc.changeListProduct(temp);
  }
}

//Lấy thông tin sản phẩm theo id
fetchProductById(ApiBloc apiBloc, String idProduct) async {
  final response = await client.get(url + 'product/get/' + idProduct);
  if (response.statusCode == 200) {
    apiBloc.changeProduct(Product.fromJson(json.decode(response.body)));
  }
}

//Lấy thông tin user
fetchUserById(ApiBloc apiBloc, String idUser) async {
  final response = await client.get(url + 'user/get/' + idUser);
  if (response.statusCode == 200) {
    apiBloc.changeMainUser(User.fromJson(json.decode(response.body)));
  }
}

//Lấy thông tin giỏ hàng
fetchCartByUserId(ApiBloc apiBloc, String idUser) async {
  final response = await client.get(url + 'cart/get-by-user/' + idUser);
  if (response.statusCode == 200) {
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
    List<Cart> temp = parsed.map<Cart>((json) => Cart.fromJson(json)).toList();
    apiBloc.changeCart(temp[0]);
  }
}
