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
  List<Menu> listMenu = List<Menu>();
  try {
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      listMenu = parsed.map<Menu>((json) => Menu.fromJson(json))
          .toList();
      listMenu.insert(0, Menu(id: "0", name: "Tất cả", link: ""));
      for(int i = 1; i < listMenu.length; i ++){
        final response = await client.get(url + 'menu/get-child/' + listMenu[i].id);
        if (response.statusCode == 200) {
          final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
          List<ChildMenu> listChildMenu = parsed.map<ChildMenu>((json) => ChildMenu.fromJson(json)).toList();
          listChildMenu.insert(0, ChildMenu(id: "0", idMenu: listMenu[i].id, name: "Tất cả", link: ""));
          listMenu[i].listChildMenu = listChildMenu;
        }
      }
    }
  }finally{
    apiBloc.changeMenu(listMenu);
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
  final responseProduct = await client.get(url + 'product/get/' + idProduct);
  if (responseProduct.statusCode == 200) {
    Product product = new Product(user: null);
    product = Product.fromJson(json.decode(responseProduct.body));
    final responseUser = await client.get(url + 'user/get/' + product.idUser);
    if (responseUser.statusCode == 200) {
      User user = User.fromJson(json.decode(responseUser.body));
      product.user = user;
    }
    apiBloc.changeProduct(product);
  }
}

//Lấy thông tin user
fetchUserById(ApiBloc apiBloc, String idUser, bool isAnother) async {
  final response = await client.get(url + 'user/get/' + idUser);
  if (response.statusCode == 200) {
    if(isAnother){

    }
    else{
      apiBloc.changeMainUser(User.fromJson(json.decode(response.body)));
    }
  }
}

//Lấy thông tin giỏ hàng
fetchCartByUserId(ApiBloc apiBloc, String idUser) async {
  final response = await client.get(url + 'cart/get-by-user/' + idUser);
  if (response.statusCode == 200) {
    List<Product> temp = new List<Product>();
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
    List<Cart> cart = parsed.map<Cart>((json) => Cart.fromJson(json)).toList();
    for(int i = 0; i < cart[0].items.length; i++){
      final response = await client.get(url + 'product/get/' + cart[0].items[i].id);
      if (response.statusCode == 200) {
        temp.add(Product.fromJson(json.decode(response.body)));
      }
    }
    cart[0].products = temp;
    apiBloc.changeCart(cart[0]);
  }
}

//Thêm sản phẩm vào giỏ hàng
