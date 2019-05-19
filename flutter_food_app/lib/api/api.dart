import 'dart:convert';
import 'package:flutter_food_app/api/model/cart.dart';
import 'package:flutter_food_app/api/model/child_menu.dart';
import 'package:flutter_food_app/api/model/menu.dart';
import 'package:flutter_food_app/api/model/product.dart';
import 'package:flutter_food_app/api/model/rating.dart';
import 'package:flutter_food_app/api/model/user.dart';
import 'package:flutter_food_app/common/bloc/api_bloc.dart';
import 'package:flutter_food_app/common/bloc/loading_bloc.dart';
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
      for (int i = 1; i < listMenu.length; i ++) {
        final response = await client.get(
            url + 'menu/get-child/' + listMenu[i].id);
        if (response.statusCode == 200) {
          final parsed = json.decode(response.body).cast<
              Map<String, dynamic>>();
          List<ChildMenu> listChildMenu = parsed.map<ChildMenu>((json) =>
              ChildMenu.fromJson(json)).toList();
          listChildMenu.insert(0, ChildMenu(
              id: "0", idMenu: listMenu[i].id, name: "Tất cả", link: ""));
          listMenu[i].listChildMenu = listChildMenu;
        }
      }
    }
  } finally {
    apiBloc.changeMenu(listMenu);
  }
}

//Lấy thông tin sản phẩm theo id menu
fetchProductOfMenu(ApiBloc apiBloc, LoadingBloc loadingBloc,
    String idMenu) async {
  final response = await client.get(url + 'menu/get-products/' + idMenu);
  if (response.statusCode == 200) {
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
    List<Product> temp = parsed.map<Product>((json) => Product.fromJson(json))
        .toList();
    if (temp.isNotEmpty) {
      apiBloc.changeListProduct(temp);
    }
    loadingBloc.changeLoadingDetail(false);
  }
}

//Lấy thông tin sản phẩm theo id child menu
fetchProductOfChildMenu(ApiBloc apiBloc, LoadingBloc loadingBloc,
    String idChildMenu) async {
  final response = await client.get(
      url + 'childmenu/get-product/' + idChildMenu);
  if (response.statusCode == 200) {
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
    List<Product> temp = parsed.map<Product>((json) => Product.fromJson(json))
        .toList();
    if (temp.isNotEmpty) {
      apiBloc.changeListProduct(temp);
    }
    loadingBloc.changeLoadingDetail(false);
  }
}

//Lấy thông tin sản phẩm theo id
fetchProductById(ApiBloc apiBloc, String idProduct) async {
  final responseProduct = await client.get(url + 'product/get/' + idProduct);
  Product product = new Product(user: null);
  try {
    if (responseProduct.statusCode == 200) {
      product = Product.fromJson(json.decode(responseProduct.body));
      final responseUser = await client.get(url + 'user/get/' + product.idUser);
      if (responseUser.statusCode == 200) {
        User user = User.fromJson(json.decode(responseUser.body));
        product.user = user;
      }
    }
  }
  finally {
    final responseRelativePost = await client.get(
        url + 'product/relative/' + idProduct);
    if (responseRelativePost.statusCode == 200) {
      final parsed = json.decode(responseRelativePost.body).cast<
          Map<String, dynamic>>();
      List<Product> listRelativePosts = parsed.map<Product>((json) =>
          Product.fromJson(json)).toList();
      if (listRelativePosts.isNotEmpty) {
        product.relativeProduct = listRelativePosts;
      }
    }
    apiBloc.changeProduct(product);
  }
}

//Lấy thông tin user
fetchUserById(ApiBloc apiBloc, String idUser, bool isAnother, int begin,
    int end) async {
  final response = await client.get(url + 'user/get/' + idUser);
  User user = new User();
  try {
    if (response.statusCode == 200) {
      if (isAnother) {

      }
      else {
        user = User.fromJson(json.decode(response.body));
      }
    }
  }
  finally {
    try {
      if (user != null) {
        final responseProducts = await client.get(
            url + 'product/get-by-user/' + idUser + '/' + begin.toString() +
                '/' + end.toString());
        final parsed = json.decode(responseProducts.body).cast<
            Map<String, dynamic>>();
        List<Product> listProduct = parsed.map<Product>((json) =>
            Product.fromJson(json)).toList();
        if (listProduct.isNotEmpty) {
          user.listProducts = listProduct;
        }
      }
    }
    finally {
      if (user != null) {
        final responseRatings = await client.get(
            url + 'rating/get-user-rating/' + idUser);
        final parsed = json.decode(responseRatings.body).cast<
            Map<String, dynamic>>();
        List<Rating> listRatings = parsed.map<Rating>((json) =>
            Rating.fromJson(json)).toList();
        if (listRatings.isNotEmpty) {
          for (int i = 0; i < listRatings.length; i++) {
            User user = new User();
            try {
              final responseUserRating = await client.get(
                  url + 'user/get/' + listRatings[i].iduserrating);
              user = User.fromJson(json.decode(responseUserRating.body));
            }
            finally {
              listRatings[i].user = user;
            }
          }
          user.listRatings = listRatings;
        }
        if (isAnother) {

        }
        else {
          apiBloc.changeMainUser(user);
        }
      }
    }
  }
}

//Login

checkLogin(ApiBloc apiBloc, String username, String password) async {
  final response = await client.post(
      url + 'login',
      body: {
        'username': username,
        'password': password,
      }
  );
  if (response.statusCode == 200) {
    //fetchUserById(apiBloc, "5ccbeef21d3ee00017f572cd", false, 1, 10);
  }
}

//Lấy thông tin giỏ hàng
fetchCartByUserId(ApiBloc apiBloc, LoadingBloc loadingBloc,
    String idUser) async {
  final response = await client.get(url + 'cart/get-by-user/' + idUser);
  if (response.statusCode == 200) {
    List<Product> temp = new List<Product>();
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
    List<Cart> cart = parsed.map<Cart>((json) => Cart.fromJson(json)).toList();
    if (cart.isNotEmpty) {
      for (int i = 0; i < cart[0].items.length; i++) {
        final response = await client.get(
            url + 'product/get/' + cart[0].items[i].id);
        if (response.statusCode == 200) {
          temp.add(Product.fromJson(json.decode(response.body)));
        }
        else {}
      }
      cart[0].products = temp;
      apiBloc.changeCart(cart[0]);
    }
    loadingBloc.changeLoadingCart(false);
  }
}

//Thêm sản phẩm vào giỏ hàng
addToCart(ApiBloc apiBloc, Cart cart, String idUser) async {
  final response = await client.post(
      url + 'cart/cart/add',
      body: {
        "iduser": idUser,
      }
  );
}