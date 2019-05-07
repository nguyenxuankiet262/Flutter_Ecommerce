import 'dart:convert';
import 'package:flutter_food_app/api/model/child_menu.dart';
import 'package:flutter_food_app/api/model/menu.dart';
import 'package:flutter_food_app/api/model/product.dart';
import 'package:flutter_food_app/common/bloc/api_bloc.dart';
import 'package:http/http.dart' as http;

final client = http.Client();
final String url = 'https://datnk15.herokuapp.com/api/';

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

fetchChildMenu(ApiBloc apiBloc, String id) async {
  final response = await client.get(url + 'menu/get-child/' + id);
  if (response.statusCode == 200) {
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
    List<ChildMenu> temp = parsed.map<ChildMenu>((json) => ChildMenu.fromJson(json)).toList();
    temp.insert(0, ChildMenu(id: "0", idMenu: id, name: "Tất cả", link: ""));
    apiBloc.changeChildMenu(temp);
    fetchProduct(temp[1].id);
  }
}

fetchProduct(String idChildMenu) async {
  final response = await client.get(url + 'childmenu/get-product/' + idChildMenu);
  if (response.statusCode == 200) {
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
    List<Product> temp = parsed.map<Product>((json) => Product.fromJson(json)).toList();
    print(temp[0].name);
    print(temp[0].currentPrice);
    print(temp[0].images[0]);
  }
}

