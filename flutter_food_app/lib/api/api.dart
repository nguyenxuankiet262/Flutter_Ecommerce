import 'dart:convert';
import 'dart:io';
import 'package:flutter_food_app/api/model/amount_fav.dart';
import 'package:flutter_food_app/api/model/badge.dart';
import 'package:flutter_food_app/api/model/banner.dart';
import 'package:flutter_food_app/api/model/cart.dart';
import 'package:flutter_food_app/api/model/check_phone.dart';
import 'package:flutter_food_app/api/model/child_menu.dart';
import 'package:flutter_food_app/api/model/favFilter.dart';
import 'package:flutter_food_app/api/model/favourite.dart';
import 'package:flutter_food_app/api/model/feedback.dart';
import 'package:flutter_food_app/api/model/follow.dart';
import 'package:flutter_food_app/api/model/follow_notice.dart';
import 'package:flutter_food_app/api/model/items.dart';
import 'package:flutter_food_app/api/model/liked.dart';
import 'package:flutter_food_app/api/model/login.dart';
import 'package:flutter_food_app/api/model/menu.dart';
import 'package:flutter_food_app/api/model/report.dart';
import 'package:flutter_food_app/api/model/system_noti.dart';
import 'package:flutter_food_app/api/model/order.dart';
import 'package:flutter_food_app/api/model/product.dart';
import 'package:flutter_food_app/api/model/rate.dart';
import 'package:flutter_food_app/api/model/rating.dart';
import 'package:flutter_food_app/api/model/rating_product.dart';
import 'package:flutter_food_app/api/model/user.dart';
import 'package:flutter_food_app/common/bloc/admin_bloc.dart';
import 'package:flutter_food_app/common/bloc/another_user_bloc.dart';
import 'package:flutter_food_app/common/bloc/api_bloc.dart';
import 'package:flutter_food_app/common/bloc/follow_bloc.dart';
import 'package:flutter_food_app/common/bloc/list_product_bloc.dart';
import 'package:flutter_food_app/common/bloc/list_search_order_bloc.dart';
import 'package:flutter_food_app/common/bloc/list_search_product_bloc.dart';
import 'package:flutter_food_app/common/bloc/loading_bloc.dart';
import 'package:flutter_food_app/common/bloc/product_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final client = http.Client();
final String url = 'https://datnk15.herokuapp.com/api/';

fetchBanner(ApiBloc apiBloc) async {
  final response = await client.get(url + 'banner/getlist/');
  if (response.statusCode == 200) {
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
    List<Banners> listBanner = new List<Banners>();
    listBanner = parsed.map<Banners>((json) => Banners.fromJson(json)).toList();
    if (listBanner.isNotEmpty) {
      apiBloc.changeListBanner(listBanner);
    }
  }
}

//Lấy thông tin menu
fetchMenus(ApiBloc apiBloc) async {
  final response = await client.get(url + 'menu/getall');
  List<Menu> listMenu = List<Menu>();
  try {
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      listMenu = parsed.map<Menu>((json) => Menu.fromJson(json)).toList();
      listMenu.insert(0, Menu(id: "0", name: "Tất cả", link: ""));
      for (int i = 1; i < listMenu.length; i++) {
        final response =
            await client.get(url + 'menu/get-child/' + listMenu[i].id);
        if (response.statusCode == 200) {
          final parsed =
              json.decode(response.body).cast<Map<String, dynamic>>();
          List<ChildMenu> listChildMenu = parsed
              .map<ChildMenu>((json) => ChildMenu.fromJson(json))
              .toList();
          listChildMenu.insert(
              0,
              ChildMenu(
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
fetchProductOfMenu(
    ListProductBloc listProductBloc,
    LoadingBloc loadingBloc,
    String idMenu,
    String code,
    String min,
    String max,
    String begin,
    String end,
    String address) async {
  final response = await client.post(url + 'menu/get-products', body: {
    "id": idMenu,
    "code": code,
    "min": min,
    "max": max,
    "begin": begin,
    "end": end,
    "address": address,
  });
  if (response.statusCode == 200) {
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
    if (code == "5" || code == "6") {
      List<FavFilter> temp =
          parsed.map<FavFilter>((json) => FavFilter.fromJson(json)).toList();
      if (temp.isNotEmpty) {
        List<Product> tempListPro = new List<Product>();
        for (int i = 0; i < temp.length; i++) {
          temp[i].product.amountFav = temp[i].like;
          tempListPro.add(temp[i].product);
        }
        if (listProductBloc.currentState.listProduct != null) {
          List<Product> listProduct =
              List.from(listProductBloc.currentState.listProduct)
                ..addAll(tempListPro);
          listProductBloc.changeListProduct(listProduct);
        } else {
          listProductBloc.changeListProduct(tempListPro);
        }
      }
    } else {
      List<Product> temp =
          parsed.map<Product>((json) => Product.fromJson(json)).toList();
      if (temp.isNotEmpty) {
        for (int i = 0; i < temp.length; i++) {
          final responseTotalFav =
              await client.get(url + 'favourite/total-like/' + temp[i].id);
          if (responseTotalFav.statusCode == 200) {
            AmountFav amountFav = new AmountFav();
            amountFav = AmountFav.fromJson(json.decode(responseTotalFav.body));
            temp[i].amountFav = amountFav.like;
          }
        }
        if (listProductBloc.currentState.listProduct.isNotEmpty) {
          List<Product> listProduct =
              List.from(listProductBloc.currentState.listProduct)..addAll(temp);
          listProductBloc.changeListProduct(listProduct);
        } else {
          listProductBloc.changeListProduct(temp);
        }
      }
    }
    loadingBloc.changeLoadingDetail(false);
  }
}

//Lấy thông tin sản phẩm theo id child menu
fetchProductOfChildMenu(
    ListProductBloc listProductBloc,
    LoadingBloc loadingBloc,
    String idChildMenu,
    String code,
    String min,
    String max,
    String begin,
    String end,
    String address) async {
  final response = await client.post(url + 'childmenu/get-product', body: {
    "id": idChildMenu,
    "code": code,
    "min": min,
    "max": max,
    "begin": begin,
    "end": end,
    "address": address,
  });
  if (response.statusCode == 200) {
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
    if (code == "5" || code == "6") {
      List<FavFilter> temp =
          parsed.map<FavFilter>((json) => FavFilter.fromJson(json)).toList();
      if (temp.isNotEmpty) {
        List<Product> tempListPro = new List<Product>();
        for (int i = 0; i < temp.length; i++) {
          temp[i].product.amountFav = temp[i].like;
          tempListPro.add(temp[i].product);
        }
        if (listProductBloc.currentState.listProduct.isNotEmpty) {
          List<Product> listProduct =
              List.from(listProductBloc.currentState.listProduct)
                ..addAll(tempListPro);
          listProductBloc.changeListProduct(listProduct);
        } else {
          listProductBloc.changeListProduct(tempListPro);
        }
      }
    } else {
      List<Product> temp =
          parsed.map<Product>((json) => Product.fromJson(json)).toList();
      if (temp.isNotEmpty) {
        for (int i = 0; i < temp.length; i++) {
          final responseTotalFav =
              await client.get(url + 'favourite/total-like/' + temp[i].id);
          if (responseTotalFav.statusCode == 200) {
            AmountFav amountFav = new AmountFav();
            amountFav = AmountFav.fromJson(json.decode(responseTotalFav.body));
            temp[i].amountFav = amountFav.like;
          }
        }
        if (listProductBloc.currentState.listProduct != null) {
          List<Product> listProduct =
              List.from(listProductBloc.currentState.listProduct)..addAll(temp);
          listProductBloc.changeListProduct(listProduct);
        } else {
          listProductBloc.changeListProduct(temp);
        }
      }
    }
    loadingBloc.changeLoadingDetail(false);
  } else {
    print("Response CM: " + "Lỗi");
  }
}

//Thêm sản phẩm

Future<bool> addProduct(
    String idUser,
    String name,
    String description,
    String img,
    String idType,
    String initprice,
    String currentprice,
    String unit) async {
  final response = await client.post(url + 'product/add', body: {
    "iduser": idUser,
    "name": name,
    "description": description,
    "idType": idType,
    "img": img,
    "initprice": initprice,
    "currentprice": currentprice,
    "unit": unit
  });
  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

fetchTopTenNewestProduct(ApiBloc apiBloc, String address) async {
  final response = await client.get(url + 'product/getall/4/$address/1/10');
  if (response.statusCode == 200) {
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
    List<Product> temp =
        parsed.map<Product>((json) => Product.fromJson(json)).toList();
    if (temp.isNotEmpty) {
      for (int i = 0; i < temp.length; i++) {
        final responseTotalFav =
            await client.get(url + 'favourite/total-like/' + temp[i].id);
        if (responseTotalFav.statusCode == 200) {
          AmountFav amountFav = new AmountFav();
          amountFav = AmountFav.fromJson(json.decode(responseTotalFav.body));
          temp[i].amountFav = amountFav.like;
        }
      }
    }
    apiBloc.changeTopNewest(temp);
  }
}

fetchTopTenFavProduct(ApiBloc apiBloc, String address) async {
  final response = await client.get(url + 'product/getall/6/$address/1/10');
  if (response.statusCode == 200) {
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
    List<FavFilter> temp = List<FavFilter>();
    temp = parsed.map<FavFilter>((json) => FavFilter.fromJson(json)).toList();
    List<Product> tempListPro = new List<Product>();
    if (temp.isNotEmpty) {
      for (int i = 0; i < temp.length; i++) {
        temp[i].product.amountFav = temp[i].like;
        tempListPro.add(temp[i].product);
      }
    }
    apiBloc.changeTopFav(tempListPro);
  }
}

//Kiểm tra đã favorite
Future<int> checkIsFavorite(String idUser, String idProduct) async {
  final response =
      await client.get(url + 'favourite/is-liked/' + idUser + '/' + idProduct);
  Liked liked = new Liked();
  if (response.statusCode == 200) {
    liked = Liked.fromJson(json.decode(response.body));
    return liked.liked;
  }
  return 0;
}

Future<int> reportProduct(String idUser, String idProduct, String code) async {
  final response = await client.post(url + 'report/create-report', body: {
    "user": idUser,
    "product": idProduct,
    "code": code,
  });
  if (response.statusCode == 200) {
    Code code = Code.fromJson(json.decode(response.body));
    return code.code;
  } else {
    return -1;
  }
}

Future<int> reportProductAnother(
    String idUser, String idProduct, String reason) async {
  final response = await client.post(url + 'report/create-report', body: {
    "user": idUser,
    "product": idProduct,
    "code": "5",
    "reason": reason
  });
  if (response.statusCode == 200) {
    Code code = Code.fromJson(json.decode(response.body));
    return code.code;
  } else {
    return -1;
  }
}

Future<List<RatingProduct>> fetchListRatingOfProduct(
    String idProduct, String begin, String end) async {
  final responseListRating = await client
      .get(url + 'product-rating/get-product/' + idProduct + '/$begin/$end');
  if (responseListRating.statusCode == 200) {
    final parsed =
        json.decode(responseListRating.body).cast<Map<String, dynamic>>();
    List<RatingProduct> listRatingProducts = parsed
        .map<RatingProduct>((json) => RatingProduct.fromJson(json))
        .toList();
    for (int i = 0; i < listRatingProducts.length; i++) {
      User user = new User();
      final responseUserRating = await client
          .get(url + 'user/get/' + listRatingProducts[i].iduserrating);
      user = User.fromJson(json.decode(responseUserRating.body));
      listRatingProducts[i].user = user;
    }
    return listRatingProducts;
  } else {
    return null;
  }
}

//Lấy thông tin sản phẩm theo id
fetchProductById(ProductBloc productBloc, String idProduct) async {
  final responseProduct = await client.get(url + 'product/get/' + idProduct);
  Product product = new Product(user: null);
  try {
    if (responseProduct.statusCode == 200) {
      product = Product.fromJson(json.decode(responseProduct.body));
      final responseUser = await client.get(url + 'user/get/' + product.idUser);
      if (responseUser.statusCode == 200) {
        User user = User.fromJson(json.decode(responseUser.body));
        if (user != null) {
          final responseRate = await client.get(url + 'rating/rate/' + user.id);
          if (responseRate.statusCode == 200) {
            Rate rate = new Rate();
            rate = Rate.fromJson(json.decode(responseRate.body));
            user.rate = rate.rate;
            product.user = user;
          }
        }
      }
    }
  } finally {
    final responseRelativePost =
        await client.get(url + 'product/relative/' + idProduct);
    try {
      if (responseRelativePost.statusCode == 200) {
        final parsed =
            json.decode(responseRelativePost.body).cast<Map<String, dynamic>>();
        List<Product> listRelativePosts =
            parsed.map<Product>((json) => Product.fromJson(json)).toList();
        if (listRelativePosts.isNotEmpty) {
          product.relativeProduct = listRelativePosts;
          for (int i = 0; i < listRelativePosts.length; i++) {
            final responseTotalFav = await client
                .get(url + 'favourite/total-like/' + listRelativePosts[i].id);
            if (responseTotalFav.statusCode == 200) {
              AmountFav amountFav = new AmountFav();
              amountFav =
                  AmountFav.fromJson(json.decode(responseTotalFav.body));
              product.relativeProduct[i].amountFav = amountFav.like;
            }
          }
        }
      }
    } finally {
      final responseListRating = await client
          .get(url + 'product-rating/get-product/' + idProduct + '/1/4');
      try {
        if (responseListRating.statusCode == 200) {
          final parsed =
              json.decode(responseListRating.body).cast<Map<String, dynamic>>();
          List<RatingProduct> listRatingProducts = parsed
              .map<RatingProduct>((json) => RatingProduct.fromJson(json))
              .toList();
          if (listRatingProducts.isNotEmpty) {
            for (int i = 0; i < listRatingProducts.length; i++) {
              User user = new User();
              try {
                final responseUserRating = await client.get(
                    url + 'user/get/' + listRatingProducts[i].iduserrating);
                user = User.fromJson(json.decode(responseUserRating.body));
              } finally {
                listRatingProducts[i].user = user;
              }
            }
            product.listRating = listRatingProducts;
          }
        }
      } finally {
        final responseRate =
            await client.get(url + 'product-rating/rate/' + idProduct);
        if (responseRate.statusCode == 200) {
          Rate rate = new Rate();
          rate = Rate.fromJson(json.decode(responseRate.body));
          product.rate = rate.rate;
        }
        final responseTotalFav =
            await client.get(url + 'favourite/total-like/' + idProduct);
        if (responseTotalFav.statusCode == 200) {
          AmountFav amountFav = new AmountFav();
          amountFav = AmountFav.fromJson(json.decode(responseTotalFav.body));
          product.amountFav = amountFav.like;
        }
        productBloc.changeProduct(product);
      }
    }
  }
}

Future<int> addRatingUser(AnotherUserBloc anotherUserBloc, String idUser,
    String idRating, String rating, String comment) async {
  final response = await client.post(url + 'rating/add', body: {
    "idrating": idRating,
    "iduser": idUser,
    "rating": rating,
    "comment": comment,
  });
  if (response.statusCode == 200) {
    Code code = Code.fromJson(json.decode(response.body));
    if (code.code == 1) {
      User anotherUser = anotherUserBloc.currentState.user;
      final responseRate = await client.get(url + 'rating/rate/' + idUser);
      if (responseRate.statusCode == 200) {
        Rate rate = new Rate();
        rate = Rate.fromJson(json.decode(responseRate.body));
        anotherUser.rate = rate.rate;
      }
      final responseRatings =
          await client.get(url + 'rating/get-user-rating/$idUser/1/2');
      if (responseRatings.statusCode == 200) {
        final parsed =
            json.decode(responseRatings.body).cast<Map<String, dynamic>>();
        List<Rating> listRatings = List<Rating>();
        listRatings =
            parsed.map<Rating>((json) => Rating.fromJson(json)).toList();
        User user = new User();
        try {
          final responseUserRating =
              await client.get(url + 'user/get/' + listRatings[0].iduserrating);
          user = User.fromJson(json.decode(responseUserRating.body));
        } finally {
          listRatings[0].user = user;
        }
        if (anotherUserBloc.currentState.user.listRatings != null) {
          List<Rating> listRating =
              anotherUserBloc.currentState.user.listRatings;
          for (int i = 0; i < listRating.length; i++) {
            if (idRating == listRating[i].iduserrating) {
              listRating.removeAt(i);
            }
          }
          if (listRatings != null) {
            listRating.insert(0, listRatings[0]);
          } else {
            anotherUser.listRatings = listRatings;
          }
          anotherUser.listRatings = listRating;
        } else {
          anotherUser.listRatings = listRatings;
        }
        anotherUserBloc.changeAnotherUser(anotherUser);
      }
    }
    return code.code;
  } else {
    return 0;
  }
}

Future<int> addRatingProduct(
    String idUser, String idProduct, String rating, String comment) async {
  print(idUser);
  print(idProduct);
  final response = await client.post(url + 'product-rating/add', body: {
    "idrating": idUser,
    "idproduct": idProduct,
    "rating": rating,
    "comment": comment,
  });
  if (response.statusCode == 200) {
    Code code = Code.fromJson(json.decode(response.body));
    return code.code;
  } else {
    return 0;
  }
}

fetchRatingByUser(
    ApiBloc apiBloc, String idUser, String begin, String end) async {
  final responseRatings =
      await client.get(url + 'rating/get-user-rating/$idUser/$begin/$end');
  if (responseRatings.statusCode == 200) {
    final parsed =
        json.decode(responseRatings.body).cast<Map<String, dynamic>>();
    List<Rating> listRatings = List<Rating>();
    listRatings = parsed.map<Rating>((json) => Rating.fromJson(json)).toList();
    if (listRatings.isNotEmpty) {
      for (int i = 0; i < listRatings.length; i++) {
        User user = new User();
        try {
          final responseUserRating =
              await client.get(url + 'user/get/' + listRatings[i].iduserrating);
          user = User.fromJson(json.decode(responseUserRating.body));
        } finally {
          listRatings[i].user = user;
        }
      }
    }
    User user = apiBloc.currentState.mainUser;
    if (apiBloc.currentState.mainUser.listRatings != null) {
      List<Rating> listRating =
          List.from(apiBloc.currentState.mainUser.listRatings)
            ..addAll(listRatings);
      user.listRatings = listRating;
    } else {
      user.listRatings = listRatings;
    }
    apiBloc.changeMainUser(user);
  }
}

fetchCountNewOrder(ApiBloc apiBloc, String idUser) async {
  final response = await client.get(url + 'order/count-new/' + idUser);
  if (response.statusCode == 200) {
    Badge badge = new Badge();
    badge = Badge.fromJson(json.decode(response.body));
    User user = apiBloc.currentState.mainUser;
    user.badge = badge;
    apiBloc.changeMainUser(user);
  }
}

//Lấy thông tin user
fetchUserById(ApiBloc apiBloc, String idUser) async {
  final response = await client.get(url + 'user/get/' + idUser);
  User user = new User();
  if (response.statusCode == 200) {
    user = User.fromJson(json.decode(response.body));
    if (user != null) {
      final responseRate = await client.get(url + 'rating/rate/' + idUser);
      if (responseRate.statusCode == 200) {
        Rate rate = new Rate();
        rate = Rate.fromJson(json.decode(responseRate.body));
        user.rate = rate.rate;
      }
      final responseAmountPost =
          await client.get(url + 'product/count-by-user/$idUser');
      if (responseAmountPost.statusCode == 200) {
        user.amountPost = json.decode(responseAmountPost.body);
      }
      final responseAmountFollow =
          await client.get(url + 'follow/info/$idUser');
      if (responseAmountFollow.statusCode == 200) {
        Follow follow = Follow.fromJson(json.decode(responseAmountFollow.body));
        user.amountFollowed = follow.follower;
        user.amountFollowing = follow.following;
      }
    }
    print(user.amountPost);
    apiBloc.changeMainUser(user);
  }
}

fetchFollowingByUser(
    ApiBloc apiBloc, String idUser, String begin, String end) async {
  User user = apiBloc.currentState.mainUser;
  final responseFollow =
      await client.get(url + 'follow/get-following/$idUser/$begin/$end');
  if (responseFollow.statusCode == 200) {
    if (responseFollow.body != null) {
      List<String> listFollowingId =
          List<String>.from(json.decode(responseFollow.body));
      List<User> tempFollowingList = new List<User>();
      if (responseFollow.body != null) {
        for (int i = 0; i < listFollowingId.length; i++) {
          final responseUserFollowing =
              await client.get(url + 'user/get/' + listFollowingId[i]);
          User userFollowing = new User();
          if (responseUserFollowing.statusCode == 200) {
            userFollowing =
                User.fromJson(json.decode(responseUserFollowing.body));
            if (userFollowing != null) {
              tempFollowingList.add(userFollowing);
            }
          }
        }
        if (apiBloc.currentState.mainUser.listFollowing != null) {
          List<User> listUser =
              List.from(apiBloc.currentState.mainUser.listFollowing)
                ..addAll(tempFollowingList);
          user.listFollowing = listUser;
        } else {
          user.listFollowing = tempFollowingList;
        }
        apiBloc.changeMainUser(user);
      }
    }
  }
}

fetchFollowedByUser(
    ApiBloc apiBloc, String idUser, String begin, String end) async {
  User user = apiBloc.currentState.mainUser;
  final responseFollow =
      await client.get(url + 'follow/get-follower/$idUser/$begin/$end');
  if (responseFollow.statusCode == 200) {
    if (responseFollow.body != null) {
      List<String> listFollowedId =
          List<String>.from(json.decode(responseFollow.body));
      List<User> tempFollowedList = new List<User>();
      if (responseFollow.body != null) {
        for (int i = 0; i < listFollowedId.length; i++) {
          final responseUserFollowing =
              await client.get(url + 'user/get/' + listFollowedId[i]);
          User userFollower = new User();
          if (responseUserFollowing.statusCode == 200) {
            userFollower =
                User.fromJson(json.decode(responseUserFollowing.body));
            if (userFollower != null) {
              tempFollowedList.add(userFollower);
            }
          }
        }
        if (apiBloc.currentState.mainUser.listFollowed != null) {
          List<User> listUser =
              List.from(apiBloc.currentState.mainUser.listFollowing)
                ..addAll(tempFollowedList);
          user.listFollowed = listUser;
        } else {
          user.listFollowed = tempFollowedList;
        }
        apiBloc.changeMainUser(user);
      }
    }
  }
}

Future<int> checkIsFollowing(String idCheck, String idUser) async {
  final response = await client.get(url + 'follow/isliked/$idCheck/$idUser');
  if (response.statusCode == 200) {
    return json.decode(response.body);
  }
  return -1;
}

fetchListFavUser(
    ApiBloc apiBloc, LoadingBloc loadingBloc, String idUser) async {
  final responseFav = await client.get(url + 'favourite/get-by-user/' + idUser);
  if (responseFav.statusCode == 200) {
    final parsed = json.decode(responseFav.body).cast<Map<String, dynamic>>();
    List<Favourite> listFav = List<Favourite>();
    listFav =
        parsed.map<Favourite>((json) => Favourite.fromJson(json)).toList();
    if (listFav.isNotEmpty) {
      List<Product> temp = new List<Product>();
      for (int i = 0; i < listFav.length; i++) {
        final responseFavProduct =
            await client.get(url + 'product/get/' + listFav[i].idproduct);
        Product product = new Product(user: null);
        if (responseFavProduct.statusCode == 200) {
          product = Product.fromJson(json.decode(responseFavProduct.body));
        }
        final responseTotalFav = await client
            .get(url + 'favourite/total-like/' + listFav[i].idproduct);
        if (responseTotalFav.statusCode == 200) {
          AmountFav amountFav = new AmountFav();
          amountFav = AmountFav.fromJson(json.decode(responseTotalFav.body));
          product.amountFav = amountFav.like;
        }
        temp.add(product);
      }
      User mainUser = apiBloc.currentState.mainUser;
      mainUser.listFav = temp;
      apiBloc.changeMainUser(mainUser);
    }
    loadingBloc.changeLoadingFavManage(false);
  }
}

fetchListPostUser(ApiBloc apiBloc, LoadingBloc loadingBloc, String idUser,
    int begin, int end) async {
  final responseProducts = await client.get(url +
      'product/get-by-user/' +
      idUser +
      '/' +
      begin.toString() +
      '/' +
      end.toString());
  if (responseProducts.statusCode == 200) {
    final parsed =
        json.decode(responseProducts.body).cast<Map<String, dynamic>>();
    List<Product> temp =
        parsed.map<Product>((json) => Product.fromJson(json)).toList();
    if (temp.isNotEmpty) {
      for (int i = 0; i < temp.length; i++) {
        final responseTotalFav =
            await client.get(url + 'favourite/total-like/' + temp[i].id);
        if (responseTotalFav.statusCode == 200) {
          AmountFav amountFav = new AmountFav();
          amountFav = AmountFav.fromJson(json.decode(responseTotalFav.body));
          temp[i].amountFav = amountFav.like;
        }
      }
    }
    User user = apiBloc.currentState.mainUser;
    if (apiBloc.currentState.mainUser.listProductShow != null) {
      List<Product> listProduct =
          List.from(apiBloc.currentState.mainUser.listProductShow)
            ..addAll(temp);
      user.listProductShow = listProduct;
    } else {
      user.listProductShow = temp;
    }
    apiBloc.changeMainUser(user);
    loadingBloc.changeLoadingPostManage(false);
  }
}

isAddToFav(ApiBloc apiBloc, String idUser, String id, bool isAdd) async {
  if (isAdd) {
    final response = await client.post(url + 'favourite/like', body: {
      "iduser": idUser,
      "idproduct": id,
    });
    if (response.statusCode == 200) {
      if (apiBloc.currentState.cart != null) {
        for (int i = 0; i < apiBloc.currentState.cart.items.length; i++) {
          if (id == apiBloc.currentState.cart.items[i].id) {
            Cart cart = apiBloc.currentState.cart;
            cart.products[i].isFavorite = true;
            apiBloc.changeCart(cart);
          }
        }
      }
    }
  } else {
    final response = await client.post(url + 'favourite/unlike', body: {
      "iduser": idUser,
      "idproduct": id,
    });
    if (response.statusCode == 200) {
      if (apiBloc.currentState.cart != null) {
        for (int i = 0; i < apiBloc.currentState.cart.items.length; i++) {
          if (id == apiBloc.currentState.cart.items[i].id) {
            Cart cart = apiBloc.currentState.cart;
            cart.products[i].isFavorite = false;
            apiBloc.changeCart(cart);
          }
        }
      }
    }
  }
}

//Lấy thông tin another user

fetchAnotherById(AnotherUserBloc anotherUserBloc, String idUser) async {
  final response = await client.get(url + 'user/get/' + idUser);
  User user = new User();
  if (response.statusCode == 200) {
    user = User.fromJson(json.decode(response.body));
    if (user != null) {
      final responseRate = await client.get(url + 'rating/rate/' + idUser);
      if (responseRate.statusCode == 200) {
        Rate rate = new Rate();
        rate = Rate.fromJson(json.decode(responseRate.body));
        user.rate = rate.rate;
      }
      final responseAmountPost =
          await client.get(url + 'product/count-by-user/$idUser');
      if (responseAmountPost.statusCode == 200) {
        user.amountPost = json.decode(responseAmountPost.body);
      }
      final responseAmountFollow =
          await client.get(url + 'follow/info/$idUser');
      if (responseAmountFollow.statusCode == 200) {
        Follow follow = Follow.fromJson(json.decode(responseAmountFollow.body));
        user.amountFollowed = follow.follower;
        user.amountFollowing = follow.following;
      }
    }
    anotherUserBloc.changeAnotherUser(user);
  }
}

fetchFollowingByAnotherUser(
    FollowBloc followBloc, String idUser, String begin, String end) async {
  List<User> listFollow = followBloc.currentState.listFollow;
  final responseFollow =
      await client.get(url + 'follow/get-following/$idUser/$begin/$end');
  if (responseFollow.statusCode == 200) {
    if (responseFollow.body != null) {
      List<String> listFollowingId =
          List<String>.from(json.decode(responseFollow.body));
      List<User> tempFollowingList = new List<User>();
      if (responseFollow.body != null) {
        for (int i = 0; i < listFollowingId.length; i++) {
          final responseUserFollowing =
              await client.get(url + 'user/get/' + listFollowingId[i]);
          User userFollowing = new User();
          if (responseUserFollowing.statusCode == 200) {
            userFollowing =
                User.fromJson(json.decode(responseUserFollowing.body));
            if (userFollowing != null) {
              tempFollowingList.add(userFollowing);
            }
          }
        }
        if (followBloc.currentState.listFollow != null) {
          List<User> listUser = List.from(followBloc.currentState.listFollow)
            ..addAll(tempFollowingList);
          listFollow = listUser;
        } else {
          listFollow = tempFollowingList;
        }
        followBloc.changeFollow(listFollow);
      }
    }
  }
}

fetchFollowedByAnotherUser(
    FollowBloc followBloc, String idUser, String begin, String end) async {
  List<User> listFollow = followBloc.currentState.listFollow;
  final responseFollow =
      await client.get(url + 'follow/get-follower/$idUser/$begin/$end');
  if (responseFollow.statusCode == 200) {
    if (responseFollow.body != null) {
      List<String> listFollowedId =
          List<String>.from(json.decode(responseFollow.body));
      List<User> tempFollowedList = new List<User>();
      if (responseFollow.body != null) {
        for (int i = 0; i < listFollowedId.length; i++) {
          final responseUserFollowing =
              await client.get(url + 'user/get/' + listFollowedId[i]);
          User userFollower = new User();
          if (responseUserFollowing.statusCode == 200) {
            userFollower =
                User.fromJson(json.decode(responseUserFollowing.body));
            if (userFollower != null) {
              tempFollowedList.add(userFollower);
            }
          }
        }
        if (followBloc.currentState.listFollow != null) {
          List<User> listUser = List.from(followBloc.currentState.listFollow)
            ..addAll(tempFollowedList);
          listFollow = listUser;
        } else {
          listFollow = tempFollowedList;
        }
        followBloc.changeFollow(listFollow);
      }
    }
  }
}

fetchListPostAnotherUser(
    AnotherUserBloc anotherUserBloc, String idUser, int begin, int end) async {
  final responseProducts = await client.get(url +
      'product/get-by-user/' +
      idUser +
      '/' +
      begin.toString() +
      '/' +
      end.toString());
  if (responseProducts.statusCode == 200) {
    final parsed =
        json.decode(responseProducts.body).cast<Map<String, dynamic>>();
    List<Product> temp =
        parsed.map<Product>((json) => Product.fromJson(json)).toList();
    if (temp.isNotEmpty) {
      for (int i = 0; i < temp.length; i++) {
        final responseTotalFav =
            await client.get(url + 'favourite/total-like/' + temp[i].id);
        if (responseTotalFav.statusCode == 200) {
          AmountFav amountFav = new AmountFav();
          amountFav = AmountFav.fromJson(json.decode(responseTotalFav.body));
          temp[i].amountFav = amountFav.like;
        }
      }
    }
    User user = anotherUserBloc.currentState.user;
    if (anotherUserBloc.currentState.user.listProductShow != null) {
      List<Product> listProduct =
          List.from(anotherUserBloc.currentState.user.listProductShow)
            ..addAll(temp);
      user.listProductShow = listProduct;
    } else {
      user.listProductShow = temp;
    }
    anotherUserBloc.changeAnotherUser(user);
  }
}

fetchRatingByAnotherUser(AnotherUserBloc anotherUserBloc, String idUser,
    String begin, String end) async {
  final responseRatings =
      await client.get(url + 'rating/get-user-rating/$idUser/$begin/$end');
  if (responseRatings.statusCode == 200) {
    final parsed =
        json.decode(responseRatings.body).cast<Map<String, dynamic>>();
    List<Rating> listRatings = List<Rating>();
    listRatings = parsed.map<Rating>((json) => Rating.fromJson(json)).toList();
    if (listRatings.isNotEmpty) {
      for (int i = 0; i < listRatings.length; i++) {
        User user = new User();
        try {
          final responseUserRating =
              await client.get(url + 'user/get/' + listRatings[i].iduserrating);
          user = User.fromJson(json.decode(responseUserRating.body));
        } finally {
          listRatings[i].user = user;
        }
      }
    }
    User user = anotherUserBloc.currentState.user;
    if (anotherUserBloc.currentState.user.listRatings != null) {
      List<Rating> listRating =
          List.from(anotherUserBloc.currentState.user.listRatings)
            ..addAll(listRatings);
      user.listRatings = listRating;
    } else {
      user.listRatings = listRatings;
    }
    anotherUserBloc.changeAnotherUser(user);
  }
}

//Login

Future<Login> checkLogin(String username, String password) async {
  final response = await client.post(url + 'signin', body: {
    'info': username,
    'password': password,
  });
  if (response.statusCode == 200) {
    Login login = Login.fromJson(json.decode(response.body));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', login.token);
    return login;
  } else {
    return null;
  }
}

//***************************************************************GIỎ HÀNG *********************************************************

//Lấy thông tin giỏ hàng
fetchCartByUserId(
    ApiBloc apiBloc, LoadingBloc loadingBloc, String idUser) async {
  final response = await client.get(url + 'cart/get-by-user/' + idUser);
  try {
    if (response.statusCode == 200) {
      if (response.body != "null") {
        List<Product> temp = new List<Product>();
        final parsed = json.decode(response.body);
        Cart cart = Cart.fromJson(parsed);
        if (cart != null) {
          for (int i = 0; i < cart.items.length; i++) {
            Product product = new Product();
            final response =
                await client.get(url + 'product/get/' + cart.items[i].id);
            if (response.statusCode == 200) {
              product = Product.fromJson(json.decode(response.body));
            }
            final responseTotalFav = await client
                .get(url + 'favourite/total-like/' + cart.items[i].id);
            if (responseTotalFav.statusCode == 200) {
              AmountFav amountFav = new AmountFav();
              amountFav =
                  AmountFav.fromJson(json.decode(responseTotalFav.body));
              product.amountFav = amountFav.like;
            }
            if (await checkIsFavorite(
                    apiBloc.currentState.mainUser.id, cart.items[i].id) ==
                1) {
              product.isFavorite = true;
            } else {
              product.isFavorite = false;
            }
            temp.add(product);
          }
          cart.products = temp;
          apiBloc.changeCart(cart);
        }
      }
    }
  } finally {
    loadingBloc.changeLoadingCart(false);
  }
}

Future<int> checkStatusProduct(String idProduct) async {
  final response = await client.get(url + 'product/get/' + idProduct);
  if (response.statusCode == 200) {
    if (json.decode(response.body)["status"]){
      return 1;
    }
    else {
      return 0;
    }
  } else {
    return -1;
  }
}

//Thêm hoặc cập nhật giỏ hàng
updateProductOfCart(
    ApiBloc apiBloc, String idUser, Items item, Product product) async {
  Map data = item.toJson();
  final response = await client.post(url + 'cart/update',
      body: {'iduser': idUser, 'product': json.encode(data)});
  if (response.statusCode == 200) {
    bool flag = false;
    Cart tempCart = apiBloc.currentState.cart;
    if (tempCart == null) {
      tempCart = new Cart();
      tempCart.items = new List<Items>();
      tempCart.products = new List<Product>();
      tempCart.items.add(item);
      tempCart.products.add(product);
    } else {
      for (int i = 0; i < tempCart.items.length; i++) {
        if (item.id == tempCart.items[i].id) {
          tempCart.items[i].qty = item.qty;
          flag = true;
          break;
        }
      }
      if (!flag) {
        tempCart.items.add(item);
        tempCart.products.add(product);
      }
    }
    apiBloc.changeCart(tempCart);
  }
}

//Xóa sản phẩm vào giỏ hàng
deleteProductOfCart(ApiBloc apiBloc, String idUser, String idProduct) async {
  final response = await client.post(url + 'cart/delete',
      body: {'iduser': idUser, 'idproduct': idProduct});
  if (response.statusCode == 200) {
    Cart tempCart = apiBloc.currentState.cart;
    for (int i = 0; i < tempCart.items.length; i++) {
      if (idProduct == tempCart.items[i].id) {
        tempCart.items.removeAt(i);
        tempCart.products.removeAt(i);
        break;
      }
    }
    apiBloc.changeCart(tempCart);
  }
}

//*********************************************FOLLOW ***********************************

isFollowUser(
    ApiBloc apiBloc, String idUser, User userFollow, bool isFollow) async {
  if (isFollow) {
    final response = await client.post(url + 'follow/following',
        body: {'iduser': idUser, 'idfollow': userFollow.id});
    if (response.statusCode == 200) {}
  } else {
    final response = await client.post(url + 'follow/unfollow',
        body: {'iduser': idUser, 'idfollow': userFollow.id});
    if (response.statusCode == 200) {}
  }
}

//*********************************************ORDER************************************
fetchOrderById(ApiBloc apiBloc, String idUser, int status, bool isSeller,
    String begin, String end) async {
  String address = "";
  try {
    if (isSeller) {
      if (status == 0) {
        address = 'order/get-pending-by-seller/';
      } else if (status == 1) {
        address = 'order/get-success-by-seller/';
      } else {
        address = 'order/get-cancel-by-seller/';
      }
    } else {
      if (status == 0) {
        address = 'order/get-pending-by-order/';
      } else if (status == 1) {
        address = 'order/get-success-by-order/';
      } else {
        address = 'order/get-cancel-by-order/';
      }
    }
  } finally {
    final responseOrders =
        await client.get(url + address + idUser + "/$begin/$end");
    if (responseOrders.statusCode == 200) {
      final parsed =
          json.decode(responseOrders.body).cast<Map<String, dynamic>>();
      List<Order> listOrders = new List<Order>();
      listOrders = parsed.map<Order>((json) => Order.fromJson(json)).toList();
      if (listOrders.isNotEmpty) {
        for (int i = 0; i < listOrders.length; i++) {
          List<Product> tempListProducts = List<Product>();
          for (int j = 0; j < listOrders[i].product.length; j++) {
            final responseProduct = await client
                .get(url + 'product/get/' + listOrders[i].product[j].id);
            Product tempProduct = new Product(user: null);
            if (responseProduct.statusCode == 200) {
              tempProduct = Product.fromJson(json.decode(responseProduct.body));
              tempListProducts.add(tempProduct);
            }
          }
          listOrders[i].listProduct = tempListProducts;
          final responseUserSeller =
              await client.get(url + 'user/get/' + listOrders[i].idUser);
          User userSeller = new User();
          if (responseUserSeller.statusCode == 200) {
            userSeller = User.fromJson(json.decode(responseUserSeller.body));
            listOrders[i].userSeller = userSeller;
          }
          final responseUserOrder =
              await client.get(url + 'user/get/' + listOrders[i].idOrder);
          User userOrder = new User();
          if (responseUserOrder.statusCode == 200) {
            userOrder = User.fromJson(json.decode(responseUserOrder.body));
            listOrders[i].userOrder = userOrder;
          }
        }
        if (status == 0) {
          if (apiBloc.currentState.mainUser.listNewOrder != null) {
            List<Order> listTemp =
                List.from(apiBloc.currentState.mainUser.listNewOrder)
                  ..addAll(listOrders);
            User user = apiBloc.currentState.mainUser;
            user.listNewOrder = listTemp;
            apiBloc.changeMainUser(user);
          } else {
            User user = apiBloc.currentState.mainUser;
            user.listNewOrder = listOrders;
            apiBloc.changeMainUser(user);
          }
        } else if (status == 1) {
          if (apiBloc.currentState.mainUser.listSuccessOrder != null) {
            List<Order> listTemp =
                List.from(apiBloc.currentState.mainUser.listSuccessOrder)
                  ..addAll(listOrders);
            User user = apiBloc.currentState.mainUser;
            user.listSuccessOrder = listTemp;
            apiBloc.changeMainUser(user);
          } else {
            User user = apiBloc.currentState.mainUser;
            user.listSuccessOrder = listOrders;
            apiBloc.changeMainUser(user);
          }
        } else {
          if (apiBloc.currentState.mainUser.listCancelOrder != null) {
            List<Order> listTemp =
                List.from(apiBloc.currentState.mainUser.listCancelOrder)
                  ..addAll(listOrders);
            User user = apiBloc.currentState.mainUser;
            user.listCancelOrder = listTemp;
            apiBloc.changeMainUser(user);
          } else {
            User user = apiBloc.currentState.mainUser;
            user.listCancelOrder = listOrders;
            apiBloc.changeMainUser(user);
          }
        }
      }
    }
  }
}

Future<Order> getOrderById(String id) async {
  final response = await client.get(url + 'order/get/' + id);
  if (response.statusCode == 200) {
    Order order = Order.fromJson(json.decode(response.body));
    if (order != null) {
      List<Product> tempListProducts = List<Product>();
      for (int j = 0; j < order.product.length; j++) {
        final responseProduct =
            await client.get(url + 'product/get/' + order.product[j].id);
        Product tempProduct = new Product(user: null);
        if (responseProduct.statusCode == 200) {
          tempProduct = Product.fromJson(json.decode(responseProduct.body));
          tempListProducts.add(tempProduct);
        }
      }
      order.listProduct = tempListProducts;
      final responseUserSeller =
          await client.get(url + 'user/get/' + order.idUser);
      User userSeller = new User();
      if (responseUserSeller.statusCode == 200) {
        userSeller = User.fromJson(json.decode(responseUserSeller.body));
        order.userSeller = userSeller;
      }
      final responseUserOrder =
          await client.get(url + 'user/get/' + order.idOrder);
      User userOrder = new User();
      if (responseUserOrder.statusCode == 200) {
        userOrder = User.fromJson(json.decode(responseUserOrder.body));
        order.userOrder = userOrder;
        return order;
      } else {
        return null;
      }
    } else {
      return null;
    }
  } else {
    return null;
  }
}

updateStatusOrder(String idOrder, String status) async {
  final response = await client.post(url + 'order/update-order', body: {
    "id": idOrder,
    "status": status,
  });
  if (response.statusCode == 200) {}
}

addOrder(
    ApiBloc apiBloc, String idSeller, List<Items> items, String idUser) async {
  var product = jsonEncode(items.map((item) => item.toJson()).toList());
  final response = await client.post(url + 'order/create-order', body: {
    "iduser": apiBloc.currentState.mainUser.id,
    "idseller": idSeller,
    "product": product,
  });
  if (response.statusCode == 200) {
    final responseDeleteCart = await client.get(url + 'cart/delete/' + idUser);
    if (responseDeleteCart.statusCode == 200) {
      Cart cart =
          new Cart(items: new List<Items>(), products: new List<Product>());
      apiBloc.changeCart(cart);
    }
  }
}

searchOrder(
    ListSearchOrderBloc searchOrderBloc,
    LoadingBloc loadingBloc,
    String idUser,
    String idOrder,
    String code,
    String status,
    String begin,
    String end) async {
  final response = await client.get(
      url + 'order/search-filter/$idUser/$idOrder/$code/$status/$begin/$end');
  if (response.statusCode == 200) {
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
    List<Order> listOrders = new List<Order>();
    listOrders = parsed.map<Order>((json) => Order.fromJson(json)).toList();
    if (listOrders.isNotEmpty) {
      for (int i = 0; i < listOrders.length; i++) {
        List<Product> tempListProducts = List<Product>();
        for (int j = 0; j < listOrders[i].product.length; j++) {
          final responseProduct = await client
              .get(url + 'product/get/' + listOrders[i].product[j].id);
          Product tempProduct = new Product(user: null);
          if (responseProduct.statusCode == 200) {
            tempProduct = Product.fromJson(json.decode(responseProduct.body));
            tempListProducts.add(tempProduct);
          }
        }
        listOrders[i].listProduct = tempListProducts;
        final responseUserSeller =
            await client.get(url + 'user/get/' + listOrders[i].idUser);
        User userSeller = new User();
        if (responseUserSeller.statusCode == 200) {
          userSeller = User.fromJson(json.decode(responseUserSeller.body));
          listOrders[i].userSeller = userSeller;
        }
        final responseUserOrder =
            await client.get(url + 'user/get/' + listOrders[i].idOrder);
        User userOrder = new User();
        if (responseUserOrder.statusCode == 200) {
          userOrder = User.fromJson(json.decode(responseUserOrder.body));
          listOrders[i].userOrder = userOrder;
        }
      }
      if (searchOrderBloc.currentState.listOrder != null) {
        List<Order> listTemp = List.from(searchOrderBloc.currentState.listOrder)
          ..addAll(listOrders);
        searchOrderBloc.changeListSearchOrder(listTemp);
      } else {
        searchOrderBloc.changeListSearchOrder(listOrders);
      }
    }
  }
  loadingBloc.changeLoadingSearch(false);
}

searchProductsAll(
    ListSearchProductBloc searchProductBloc,
    LoadingBloc loadingBloc,
    String name,
    String begin,
    String end,
    String address) async {
  final response = await client.post(url + 'search',
      body: {"name": name, "begin": begin, "end": end, "address": address});
  if (response.statusCode == 200) {
    if (response.body != '"err"') {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      List<Product> tempListPro = List<Product>();
      tempListPro =
          parsed.map<Product>((json) => Product.fromJson(json)).toList();
      if (tempListPro.isNotEmpty) {
        if (searchProductBloc.currentState.listProduct.isNotEmpty) {
          List<Product> listProduct =
              List.from(searchProductBloc.currentState.listProduct)
                ..addAll(tempListPro);
          searchProductBloc.changeListSearchProduct(listProduct);
        } else {
          searchProductBloc.changeListSearchProduct(tempListPro);
        }
      }
    } else {
      searchProductBloc.changeListSearchProduct(new List<Product>());
    }
    loadingBloc.changeLoadingSearch(false);
  }
}

searchProductsOfMenu(
    ListSearchProductBloc searchProductBloc,
    LoadingBloc loadingBloc,
    String id,
    String name,
    String code,
    String min,
    String max,
    String begin,
    String end,
    String address) async {
  final response = await client.post(url + 'search-filter-menu', body: {
    "id": id,
    "name": name,
    "code": code,
    "min": min,
    "max": max,
    "begin": begin,
    "end": end,
    "address": address
  });
  if (response.statusCode == 200) {
    if (response.body != '"err"') {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      if (code == "5" || code == "6") {
        List<FavFilter> temp = List<FavFilter>();
        temp =
            parsed.map<FavFilter>((json) => FavFilter.fromJson(json)).toList();
        if (temp.isNotEmpty) {
          List<Product> tempListPro = new List<Product>();
          for (int i = 0; i < temp.length; i++) {
            temp[i].product.amountFav = temp[i].like;
            tempListPro.add(temp[i].product);
          }
          if (searchProductBloc.currentState.listProduct.isNotEmpty) {
            List<Product> listProduct =
                List.from(searchProductBloc.currentState.listProduct)
                  ..addAll(tempListPro);
            searchProductBloc.changeListSearchProduct(listProduct);
          } else {
            searchProductBloc.changeListSearchProduct(tempListPro);
          }
        } else {
          searchProductBloc.changeListSearchProduct(List<Product>());
        }
      } else {
        List<Product> tempListPro = List<Product>();
        tempListPro =
            parsed.map<Product>((json) => Product.fromJson(json)).toList();
        if (tempListPro.isNotEmpty) {
          if (searchProductBloc.currentState.listProduct.isNotEmpty) {
            List<Product> listProduct =
                List.from(searchProductBloc.currentState.listProduct)
                  ..addAll(tempListPro);
            searchProductBloc.changeListSearchProduct(listProduct);
          } else {
            searchProductBloc.changeListSearchProduct(tempListPro);
          }
        } else {
          searchProductBloc.changeListSearchProduct(List<Product>());
        }
      }
    } else {
      searchProductBloc.changeListSearchProduct(new List<Product>());
    }
    loadingBloc.changeLoadingSearch(false);
  }
}

searchProductsOfChildMenu(
    ListSearchProductBloc searchProductBloc,
    LoadingBloc loadingBloc,
    String id,
    String name,
    String code,
    String min,
    String max,
    String begin,
    String end,
    String address) async {
  final response = await client.post(url + 'search-filter-childmenu', body: {
    "id": id,
    "name": name,
    "code": code,
    "min": min,
    "max": max,
    "begin": begin,
    "end": end,
    "address": address
  });
  if (response.statusCode == 200) {
    if (response.body != '"err"') {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      if (code == "5" || code == "6") {
        List<FavFilter> temp = List<FavFilter>();
        temp =
            parsed.map<FavFilter>((json) => FavFilter.fromJson(json)).toList();
        if (temp.isNotEmpty) {
          List<Product> tempListPro = new List<Product>();
          for (int i = 0; i < temp.length; i++) {
            temp[i].product.amountFav = temp[i].like;
            tempListPro.add(temp[i].product);
          }
          if (searchProductBloc.currentState.listProduct.isNotEmpty) {
            List<Product> listProduct =
                List.from(searchProductBloc.currentState.listProduct)
                  ..addAll(tempListPro);
            searchProductBloc.changeListSearchProduct(listProduct);
          } else {
            searchProductBloc.changeListSearchProduct(tempListPro);
          }
        }
      } else {
        List<Product> tempListPro = List<Product>();
        tempListPro =
            parsed.map<Product>((json) => Product.fromJson(json)).toList();
        if (tempListPro.isNotEmpty) {
          if (searchProductBloc.currentState.listProduct.isNotEmpty) {
            List<Product> listProduct =
                List.from(searchProductBloc.currentState.listProduct)
                  ..addAll(tempListPro);
            searchProductBloc.changeListSearchProduct(listProduct);
          } else {
            searchProductBloc.changeListSearchProduct(tempListPro);
          }
        }
      }
    } else {
      searchProductBloc.changeListSearchProduct(new List<Product>());
    }
    loadingBloc.changeLoadingSearch(false);
  }
}

// ************************************************** USER ****************************************************
// ************************************************** POST ****************************************************

fetchProductOfUser(ApiBloc apiBloc, LoadingBloc loadingBloc, String idUser,
    String code, String min, String max, String begin, String end) async {
  final response = await client.post(url + 'filter-user', body: {
    "iduser": idUser,
    "code": code,
    "min": min,
    "max": max,
    "begin": begin,
    "end": end,
  });
  if (response.statusCode == 200) {
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
    if (code == "5" || code == "6") {
      List<FavFilter> temp =
          parsed.map<FavFilter>((json) => FavFilter.fromJson(json)).toList();
      if (temp.isNotEmpty) {
        List<Product> tempListPro = new List<Product>();
        for (int i = 0; i < temp.length; i++) {
          temp[i].product.amountFav = temp[i].like;
          tempListPro.add(temp[i].product);
        }
        User user = apiBloc.currentState.mainUser;
        if (apiBloc.currentState.mainUser.listProducts != null) {
          List<Product> listProduct =
              List.from(apiBloc.currentState.mainUser.listProducts)
                ..addAll(tempListPro);
          user.listProducts = listProduct;
        } else {
          user.listProducts = tempListPro;
        }
        apiBloc.changeMainUser(user);
      }
    } else {
      List<Product> temp =
          parsed.map<Product>((json) => Product.fromJson(json)).toList();
      if (temp.isNotEmpty) {
        for (int i = 0; i < temp.length; i++) {
          final responseTotalFav =
              await client.get(url + 'favourite/total-like/' + temp[i].id);
          if (responseTotalFav.statusCode == 200) {
            AmountFav amountFav = new AmountFav();
            amountFav = AmountFav.fromJson(json.decode(responseTotalFav.body));
            temp[i].amountFav = amountFav.like;
          }
        }
        User user = apiBloc.currentState.mainUser;
        if (apiBloc.currentState.mainUser.listProducts != null) {
          List<Product> listProduct =
              List.from(apiBloc.currentState.mainUser.listProducts)
                ..addAll(temp);
          user.listProducts = listProduct;
        } else {
          user.listProducts = temp;
        }
        apiBloc.changeMainUser(user);
      }
    }
    loadingBloc.changeLoadingPostManage(false);
  }
}

fetchProductOfMenuOfUser(
    ApiBloc apiBloc,
    LoadingBloc loadingBloc,
    String idUser,
    String idMenu,
    String code,
    String min,
    String max,
    String begin,
    String end) async {
  final response = await client.post(url + 'filter-menu-user', body: {
    "iduser": idUser,
    "id": idMenu,
    "code": code,
    "min": min,
    "max": max,
    "begin": begin,
    "end": end,
  });
  if (response.statusCode == 200) {
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
    if (code == "5" || code == "6") {
      List<FavFilter> temp =
          parsed.map<FavFilter>((json) => FavFilter.fromJson(json)).toList();
      if (temp.isNotEmpty) {
        List<Product> tempListPro = new List<Product>();
        for (int i = 0; i < temp.length; i++) {
          temp[i].product.amountFav = temp[i].like;
          tempListPro.add(temp[i].product);
        }
        User user = apiBloc.currentState.mainUser;
        if (apiBloc.currentState.mainUser.listProducts != null) {
          List<Product> listProduct =
              List.from(apiBloc.currentState.mainUser.listProducts)
                ..addAll(tempListPro);
          user.listProducts = listProduct;
        } else {
          user.listProducts = tempListPro;
        }
        apiBloc.changeMainUser(user);
      }
    } else {
      List<Product> temp =
          parsed.map<Product>((json) => Product.fromJson(json)).toList();
      if (temp.isNotEmpty) {
        for (int i = 0; i < temp.length; i++) {
          final responseTotalFav =
              await client.get(url + 'favourite/total-like/' + temp[i].id);
          if (responseTotalFav.statusCode == 200) {
            AmountFav amountFav = new AmountFav();
            amountFav = AmountFav.fromJson(json.decode(responseTotalFav.body));
            temp[i].amountFav = amountFav.like;
          }
        }
        User user = apiBloc.currentState.mainUser;
        if (apiBloc.currentState.mainUser.listProducts != null) {
          List<Product> listProduct =
              List.from(apiBloc.currentState.mainUser.listProducts)
                ..addAll(temp);
          user.listProducts = listProduct;
        } else {
          user.listProducts = temp;
        }
        apiBloc.changeMainUser(user);
      }
    }
    loadingBloc.changeLoadingPostManage(false);
  }
}

fetchProductOfChildMenuOfUser(
    ApiBloc apiBloc,
    LoadingBloc loadingBloc,
    String idUser,
    String idChildMenu,
    String code,
    String min,
    String max,
    String begin,
    String end) async {
  final response = await client.post(url + 'filter-childmenu-user', body: {
    "iduser": idUser,
    "id": idChildMenu,
    "code": code,
    "min": min,
    "max": max,
    "begin": begin,
    "end": end,
  });
  if (response.statusCode == 200) {
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
    if (code == "5" || code == "6") {
      List<FavFilter> temp =
          parsed.map<FavFilter>((json) => FavFilter.fromJson(json)).toList();
      if (temp.isNotEmpty) {
        List<Product> tempListPro = new List<Product>();
        for (int i = 0; i < temp.length; i++) {
          temp[i].product.amountFav = temp[i].like;
          tempListPro.add(temp[i].product);
        }
        User user = apiBloc.currentState.mainUser;
        if (apiBloc.currentState.mainUser.listProducts != null) {
          List<Product> listProduct =
              List.from(apiBloc.currentState.mainUser.listProducts)
                ..addAll(tempListPro);
          user.listProducts = listProduct;
        } else {
          user.listProducts = tempListPro;
        }
        apiBloc.changeMainUser(user);
      }
    } else {
      List<Product> temp =
          parsed.map<Product>((json) => Product.fromJson(json)).toList();
      if (temp.isNotEmpty) {
        for (int i = 0; i < temp.length; i++) {
          final responseTotalFav =
              await client.get(url + 'favourite/total-like/' + temp[i].id);
          if (responseTotalFav.statusCode == 200) {
            AmountFav amountFav = new AmountFav();
            amountFav = AmountFav.fromJson(json.decode(responseTotalFav.body));
            temp[i].amountFav = amountFav.like;
          }
        }
        User user = apiBloc.currentState.mainUser;
        if (apiBloc.currentState.mainUser.listProducts != null) {
          List<Product> listProduct =
              List.from(apiBloc.currentState.mainUser.listProducts)
                ..addAll(temp);
          user.listProducts = listProduct;
        } else {
          user.listProducts = temp;
        }
        apiBloc.changeMainUser(user);
      }
    }
    loadingBloc.changeLoadingPostManage(false);
  }
}

searchProductsAllOfUser(
    ListSearchProductBloc searchProductBloc,
    LoadingBloc loadingBloc,
    String idUser,
    String name,
    String code,
    String min,
    String max,
    String begin,
    String end) async {
  final response = await client.post(url + 'search-filter-user', body: {
    "iduser": idUser,
    "name": name,
    "code": code,
    "min": min,
    "max": max,
    "begin": begin,
    "end": end,
  });
  if (response.statusCode == 200) {
    if (response.body != '"err"') {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      if (code == "5" || code == "6") {
        List<FavFilter> temp = List<FavFilter>();
        temp =
            parsed.map<FavFilter>((json) => FavFilter.fromJson(json)).toList();
        if (temp.isNotEmpty) {
          List<Product> tempListPro = new List<Product>();
          for (int i = 0; i < temp.length; i++) {
            temp[i].product.amountFav = temp[i].like;
            tempListPro.add(temp[i].product);
          }
          if (searchProductBloc.currentState.listProduct.isNotEmpty) {
            List<Product> listProduct =
                List.from(searchProductBloc.currentState.listProduct)
                  ..addAll(tempListPro);
            searchProductBloc.changeListSearchProduct(listProduct);
          } else {
            searchProductBloc.changeListSearchProduct(tempListPro);
          }
        }
      } else {
        List<Product> tempListPro = List<Product>();
        tempListPro =
            parsed.map<Product>((json) => Product.fromJson(json)).toList();
        if (tempListPro.isNotEmpty) {
          if (searchProductBloc.currentState.listProduct.isNotEmpty) {
            List<Product> listProduct =
                List.from(searchProductBloc.currentState.listProduct)
                  ..addAll(tempListPro);
            searchProductBloc.changeListSearchProduct(listProduct);
          } else {
            searchProductBloc.changeListSearchProduct(tempListPro);
          }
        }
      }
    } else {
      searchProductBloc.changeListSearchProduct(new List<Product>());
    }
    loadingBloc.changeLoadingSearch(false);
  }
}

searchProductsOfMenuOfUser(
    ListSearchProductBloc searchProductBloc,
    LoadingBloc loadingBloc,
    String idMenu,
    String idUser,
    String name,
    String code,
    String min,
    String max,
    String begin,
    String end) async {
  final response = await client.post(url + 'search-filter-menu-user', body: {
    "id": idMenu,
    "iduser": idUser,
    "name": name,
    "code": code,
    "min": min,
    "max": max,
    "begin": begin,
    "end": end,
  });
  if (response.statusCode == 200) {
    if (response.body != '"err"') {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      if (code == "5" || code == "6") {
        List<FavFilter> temp = List<FavFilter>();
        temp =
            parsed.map<FavFilter>((json) => FavFilter.fromJson(json)).toList();
        if (temp.isNotEmpty) {
          List<Product> tempListPro = new List<Product>();
          for (int i = 0; i < temp.length; i++) {
            temp[i].product.amountFav = temp[i].like;
            tempListPro.add(temp[i].product);
          }
          if (searchProductBloc.currentState.listProduct.isNotEmpty) {
            List<Product> listProduct =
                List.from(searchProductBloc.currentState.listProduct)
                  ..addAll(tempListPro);
            searchProductBloc.changeListSearchProduct(listProduct);
          } else {
            searchProductBloc.changeListSearchProduct(tempListPro);
          }
        } else {
          searchProductBloc.changeListSearchProduct(List<Product>());
        }
      } else {
        List<Product> tempListPro = List<Product>();
        tempListPro =
            parsed.map<Product>((json) => Product.fromJson(json)).toList();
        if (tempListPro.isNotEmpty) {
          if (searchProductBloc.currentState.listProduct.isNotEmpty) {
            List<Product> listProduct =
                List.from(searchProductBloc.currentState.listProduct)
                  ..addAll(tempListPro);
            searchProductBloc.changeListSearchProduct(listProduct);
          } else {
            searchProductBloc.changeListSearchProduct(tempListPro);
          }
        } else {
          searchProductBloc.changeListSearchProduct(List<Product>());
        }
      }
    } else {
      searchProductBloc.changeListSearchProduct(new List<Product>());
    }
    loadingBloc.changeLoadingSearch(false);
  }
}

searchProductsOfChildMenuOfUser(
    ListSearchProductBloc searchProductBloc,
    LoadingBloc loadingBloc,
    String idChildMenu,
    String idUser,
    String name,
    String code,
    String min,
    String max,
    String begin,
    String end) async {
  final response =
      await client.post(url + 'search-filter-childmenu-user', body: {
    "id": idChildMenu,
    "iduser": idUser,
    "name": name,
    "code": code,
    "min": min,
    "max": max,
    "begin": begin,
    "end": end,
  });
  if (response.statusCode == 200) {
    if (response.body != '"err"') {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      if (code == "5" || code == "6") {
        List<FavFilter> temp = List<FavFilter>();
        temp =
            parsed.map<FavFilter>((json) => FavFilter.fromJson(json)).toList();
        if (temp.isNotEmpty) {
          List<Product> tempListPro = new List<Product>();
          for (int i = 0; i < temp.length; i++) {
            temp[i].product.amountFav = temp[i].like;
            tempListPro.add(temp[i].product);
          }
          if (searchProductBloc.currentState.listProduct.isNotEmpty) {
            List<Product> listProduct =
                List.from(searchProductBloc.currentState.listProduct)
                  ..addAll(tempListPro);
            searchProductBloc.changeListSearchProduct(listProduct);
          } else {
            searchProductBloc.changeListSearchProduct(tempListPro);
          }
        }
      } else {
        List<Product> tempListPro = List<Product>();
        tempListPro =
            parsed.map<Product>((json) => Product.fromJson(json)).toList();
        if (tempListPro.isNotEmpty) {
          if (searchProductBloc.currentState.listProduct.isNotEmpty) {
            List<Product> listProduct =
                List.from(searchProductBloc.currentState.listProduct)
                  ..addAll(tempListPro);
            searchProductBloc.changeListSearchProduct(listProduct);
          } else {
            searchProductBloc.changeListSearchProduct(tempListPro);
          }
        }
      }
    } else {
      searchProductBloc.changeListSearchProduct(new List<Product>());
    }
    loadingBloc.changeLoadingSearch(false);
  }
}

//******************************************************* FAVORITE *********************************************************
// ************************************************** POST ****************************************************

fetchFavOfUser(ApiBloc apiBloc, LoadingBloc loadingBloc, String idUser,
    String code, String min, String max, String begin, String end) async {
  final response = await client.post(url + 'filter-favourite', body: {
    "iduser": idUser,
    "code": code,
    "min": min,
    "max": max,
    "begin": begin,
    "end": end,
  });
  if (response.statusCode == 200) {
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
    List<Product> temp =
        parsed.map<Product>((json) => Product.fromJson(json)).toList();
    if (temp.isNotEmpty) {
      User user = apiBloc.currentState.mainUser;
      if (apiBloc.currentState.mainUser.listFav != null) {
        List<Product> listProduct =
            List.from(apiBloc.currentState.mainUser.listFav)..addAll(temp);
        user.listFav = listProduct;
      } else {
        user.listFav = temp;
      }
      apiBloc.changeMainUser(user);
    }
    loadingBloc.changeLoadingFavManage(false);
  }
}

fetchFavOfMenuOfUser(
    ApiBloc apiBloc,
    LoadingBloc loadingBloc,
    String idUser,
    String idMenu,
    String code,
    String min,
    String max,
    String begin,
    String end) async {
  final response = await client.post(url + 'filter-favourite-menu', body: {
    "iduser": idUser,
    "id": idMenu,
    "code": code,
    "min": min,
    "max": max,
    "begin": begin,
    "end": end,
  });
  if (response.statusCode == 200) {
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
    List<Product> temp =
        parsed.map<Product>((json) => Product.fromJson(json)).toList();
    if (temp.isNotEmpty) {
      User user = apiBloc.currentState.mainUser;
      if (apiBloc.currentState.mainUser.listFav != null) {
        List<Product> listProduct =
            List.from(apiBloc.currentState.mainUser.listFav)..addAll(temp);
        user.listFav = listProduct;
      } else {
        user.listFav = temp;
      }
      apiBloc.changeMainUser(user);
    }
    loadingBloc.changeLoadingFavManage(false);
  }
}

fetchFavOfChildMenuOfUser(
    ApiBloc apiBloc,
    LoadingBloc loadingBloc,
    String idUser,
    String idChildMenu,
    String code,
    String min,
    String max,
    String begin,
    String end) async {
  final response = await client.post(url + 'filter-favourite-childmenu', body: {
    "iduser": idUser,
    "id": idChildMenu,
    "code": code,
    "min": min,
    "max": max,
    "begin": begin,
    "end": end,
  });
  if (response.statusCode == 200) {
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
    List<Product> temp =
        parsed.map<Product>((json) => Product.fromJson(json)).toList();
    if (temp.isNotEmpty) {
      User user = apiBloc.currentState.mainUser;
      if (apiBloc.currentState.mainUser.listFav != null) {
        List<Product> listProduct =
            List.from(apiBloc.currentState.mainUser.listFav)..addAll(temp);
        user.listFav = listProduct;
      } else {
        user.listFav = temp;
      }
      apiBloc.changeMainUser(user);
    }
    loadingBloc.changeLoadingFavManage(false);
  }
}

searchFavAllOfUser(
    ListSearchProductBloc searchProductBloc,
    LoadingBloc loadingBloc,
    String idUser,
    String name,
    String code,
    String min,
    String max,
    String begin,
    String end) async {
  final response = await client.post(url + 'search-filter-favourite', body: {
    "iduser": idUser,
    "name": name,
    "code": code,
    "min": min,
    "max": max,
    "begin": begin,
    "end": end,
  });
  if (response.statusCode == 200) {
    if (response.body != '"err"') {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      List<Product> tempListPro = List<Product>();
      tempListPro =
          parsed.map<Product>((json) => Product.fromJson(json)).toList();
      if (tempListPro.isNotEmpty) {
        if (searchProductBloc.currentState.listProduct.isNotEmpty) {
          List<Product> listProduct =
              List.from(searchProductBloc.currentState.listProduct)
                ..addAll(tempListPro);
          searchProductBloc.changeListSearchProduct(listProduct);
        } else {
          searchProductBloc.changeListSearchProduct(tempListPro);
        }
      }
    } else {
      searchProductBloc.changeListSearchProduct(new List<Product>());
    }
    loadingBloc.changeLoadingSearch(false);
  }
}

searchFavOfMenuOfUser(
    ListSearchProductBloc searchProductBloc,
    LoadingBloc loadingBloc,
    String idMenu,
    String idUser,
    String name,
    String code,
    String min,
    String max,
    String begin,
    String end) async {
  final response =
      await client.post(url + 'search-filter-favourite-menu', body: {
    "id": idMenu,
    "iduser": idUser,
    "name": name,
    "code": code,
    "min": min,
    "max": max,
    "begin": begin,
    "end": end,
  });
  if (response.statusCode == 200) {
    if (response.body != '"err"') {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      List<Product> tempListPro = List<Product>();
      tempListPro =
          parsed.map<Product>((json) => Product.fromJson(json)).toList();
      if (tempListPro.isNotEmpty) {
        if (searchProductBloc.currentState.listProduct.isNotEmpty) {
          List<Product> listProduct =
              List.from(searchProductBloc.currentState.listProduct)
                ..addAll(tempListPro);
          searchProductBloc.changeListSearchProduct(listProduct);
        } else {
          searchProductBloc.changeListSearchProduct(tempListPro);
        }
      } else {
        searchProductBloc.changeListSearchProduct(List<Product>());
      }
    } else {
      searchProductBloc.changeListSearchProduct(new List<Product>());
    }
    loadingBloc.changeLoadingSearch(false);
  }
}

searchFavOfChildMenuOfUser(
    ListSearchProductBloc searchProductBloc,
    LoadingBloc loadingBloc,
    String idChildMenu,
    String idUser,
    String name,
    String code,
    String min,
    String max,
    String begin,
    String end) async {
  final response =
      await client.post(url + 'search-filter-favourite-childmenu', body: {
    "id": idChildMenu,
    "iduser": idUser,
    "name": name,
    "code": code,
    "min": min,
    "max": max,
    "begin": begin,
    "end": end,
  });
  if (response.statusCode == 200) {
    if (response.body != '"err"') {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      List<Product> tempListPro = List<Product>();
      tempListPro =
          parsed.map<Product>((json) => Product.fromJson(json)).toList();
      if (tempListPro.isNotEmpty) {
        if (searchProductBloc.currentState.listProduct.isNotEmpty) {
          List<Product> listProduct =
              List.from(searchProductBloc.currentState.listProduct)
                ..addAll(tempListPro);
          searchProductBloc.changeListSearchProduct(listProduct);
        } else {
          searchProductBloc.changeListSearchProduct(tempListPro);
        }
      }
    } else {
      searchProductBloc.changeListSearchProduct(new List<Product>());
    }
    loadingBloc.changeLoadingSearch(false);
  }
}

//*******************************Info********************

Future<int> checkInfoUser(String info) async {
  final response = await client.get(url + 'user/check-info/' + info);
  if (response.statusCode == 200) {
    Code code = Code.fromJson(json.decode(response.body));
    return code.code;
  } else {
    return 0;
  }
}

Future<int> changeInfoUser(
    String idUser,
    String username,
    String name,
    String phone,
    String address,
    String link,
    String info,
    String coverphoto,
    String avatar) async {
  final response = await client.post(url + 'user/change-profile', body: {
    "iduser": idUser,
    "username": username,
    "name": name,
    "phone": phone,
    "address": address,
    "link": link,
    "description": info,
    "coverphoto": coverphoto,
    "avatar": avatar
  });
  if (response.statusCode == 200) {
    Code code = Code.fromJson(json.decode(response.body));
    return code.code;
  } else {
    return -1;
  }
}

//********************PRIVATE***********

changePassword(String idUser, String oldPass, String newPass) async {
  final response = await client.post(url + 'user/change-password', body: {
    "iduser": idUser,
    "oldpassword": oldPass,
    "password": newPass,
  });

  if (response.statusCode == 200) {
    Code code = Code.fromJson(json.decode(response.body));
    return code.code;
  } else {
    return -1;
  }
}

//*******************NOTI***************

updateSeenSystemNoti(ApiBloc apiBloc, String idUser, String code,
    String idUpdate, int index) async {
  final response =
      await client.get(url + 'noti/update/$code/$idUser/$idUpdate');
  if (response.statusCode == 200) {
    if (json.decode(response.body) == 1) {
      User user = apiBloc.currentState.mainUser;
      user.listSystemNotice[index].seen = true;
      user.amountSystemNotice--;
      apiBloc.changeMainUser(user);
    }
  }
}

updateSeenFollowNoti(
    ApiBloc apiBloc, String idUser, String idProduct, int index) async {
  final response =
      await client.get(url + 'update-user-notice/$idUser/$idProduct');
  if (response.statusCode == 200) {
    if (json.decode(response.body) == 1) {
      User user = apiBloc.currentState.mainUser;
      user.listFollowNotice[index].seen = true;
      user.amountFollowNotice--;
      apiBloc.changeMainUser(user);
    }
  }
}

fetchAmountNewFollowNoti(ApiBloc apiBloc, String idUser) async {
  final response = await client.get(url + 'get-qty-user-notice/$idUser');
  if (response.statusCode == 200) {
    User user = apiBloc.currentState.mainUser;
    user.amountFollowNotice = json.decode(response.body);
    apiBloc.changeMainUser(user);
  }
}

fetchAmountNewSystemNoti(ApiBloc apiBloc, String idUser) async {
  final response = await client.get(url + 'noti/count-new/$idUser');
  if (response.statusCode == 200) {
    User user = apiBloc.currentState.mainUser;
    user.amountSystemNotice = json.decode(response.body);
    apiBloc.changeMainUser(user);
  }
}

updateNewestFollowNotice(
    ApiBloc apiBloc, LoadingBloc loadingBloc, String idUser) async {
  final response = await client.get(url + 'get-user-notice/$idUser/1/1');
  if (response.statusCode == 200) {
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
    List<FollowNotice> tempListNotice = List<FollowNotice>();
    tempListNotice = parsed
        .map<FollowNotice>((json) => FollowNotice.fromJson(json))
        .toList();
    if (tempListNotice.isNotEmpty) {
      User user = apiBloc.currentState.mainUser;
      if (!loadingBloc.currentState.loadingFollowNoti) {
        user.listFollowNotice.insert(0, tempListNotice[0]);
      }
      user.amountFollowNotice++;
      apiBloc.changeMainUser(user);
    }
  }
}

updateNewestSystemNotice(
    ApiBloc apiBloc, LoadingBloc loadingBloc, String idUser) async {
  final response = await client.get(url + 'get-notice/$idUser/0/1/1');
  if (response.statusCode == 200) {
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
    List<SystemNotice> tempListNotice = List<SystemNotice>();
    tempListNotice = parsed
        .map<SystemNotice>((json) => SystemNotice.fromJson(json))
        .toList();
    if (tempListNotice.isNotEmpty) {
      User user = apiBloc.currentState.mainUser;
      if (!loadingBloc.currentState.loadingSysNoti) {
        for (int i = 0; i < tempListNotice.length; i++) {
          if (tempListNotice[i].idOrderBuy != null) {
            Order order = await getOrderById(tempListNotice[i].idOrderBuy);
            tempListNotice[i].order = order;
          } else if (tempListNotice[i].idOrderSell != null) {
            Order order = await getOrderById(tempListNotice[i].idOrderSell);
            tempListNotice[i].order = order;
          }
        }
        user.listSystemNotice.insert(0, tempListNotice[0]);
      }
      user.amountSystemNotice++;
      apiBloc.changeMainUser(user);
    }
  }
}

fetchFollowNotificaion(ApiBloc apiBloc, LoadingBloc loadingBloc, String idUser,
    String begin, String end) async {
  final response = await client
      .get(url + 'get-user-notice/' + idUser + "/" + begin + '/' + end);

  if (response.statusCode == 200) {
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
    List<FollowNotice> tempListNotice = List<FollowNotice>();
    tempListNotice = parsed
        .map<FollowNotice>((json) => FollowNotice.fromJson(json))
        .toList();
    if (tempListNotice.isNotEmpty) {
      if (apiBloc.currentState.mainUser.listFollowNotice != null) {
        List<FollowNotice> listNotice =
            List.from(apiBloc.currentState.mainUser.listFollowNotice)
              ..addAll(tempListNotice);
        User user = apiBloc.currentState.mainUser;
        user.listFollowNotice = listNotice;
        apiBloc.changeMainUser(user);
      } else {
        User user = apiBloc.currentState.mainUser;
        user.listFollowNotice = tempListNotice;
        apiBloc.changeMainUser(user);
      }
    }
    loadingBloc.changeLoadingFollowNoti(false);
  }
}

fetchSystemNotificaion(ApiBloc apiBloc, LoadingBloc loadingBloc, String idUser,
    String begin, String end) async {
  final response = await client
      .get(url + 'get-notice/' + idUser + "/0/" + begin + '/' + end);

  if (response.statusCode == 200) {
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
    List<SystemNotice> tempListNotice = List<SystemNotice>();
    tempListNotice = parsed
        .map<SystemNotice>((json) => SystemNotice.fromJson(json))
        .toList();
    if (tempListNotice.isNotEmpty) {
      for (int i = 0; i < tempListNotice.length; i++) {
        if (tempListNotice[i].idOrderBuy != null) {
          Order order = await getOrderById(tempListNotice[i].idOrderBuy);
          tempListNotice[i].order = order;
        } else if (tempListNotice[i].idOrderSell != null) {
          Order order = await getOrderById(tempListNotice[i].idOrderSell);
          tempListNotice[i].order = order;
        }
      }
      if (apiBloc.currentState.mainUser.listSystemNotice != null) {
        List<SystemNotice> listNotice =
            List.from(apiBloc.currentState.mainUser.listSystemNotice)
              ..addAll(tempListNotice);
        User user = apiBloc.currentState.mainUser;
        user.listSystemNotice = listNotice;
        apiBloc.changeMainUser(user);
      } else {
        User user = apiBloc.currentState.mainUser;
        user.listSystemNotice = tempListNotice;
        apiBloc.changeMainUser(user);
      }
    }
    loadingBloc.changeLoadingSysNoti(false);
  }
}

//***************************FEEDBACK**********************

Future<int> addFeedback(String idUser, String title, String feedback) async {
  final response = await client.post(url + 'feedback/add',
      body: {"iduser": idUser, "title": title, "feedback": feedback});
  if (response.statusCode == 200) {
    Code code = Code.fromJson(json.decode(response.body));
    return code.code;
  } else {
    return -1;
  }
}

fetchListRepFeedback(
    ApiBloc apiBloc, String idUser, String begin, String end) async {
  final response =
      await client.get(url + 'feedback/get-list-rep/$idUser/$begin/$end');
  if (response.statusCode == 200) {
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
    List<Feedbacks> tempList = new List<Feedbacks>();
    tempList =
        parsed.map<Feedbacks>((json) => Feedbacks.fromJson(json)).toList();
    if (tempList.isNotEmpty) {
      if (apiBloc.currentState.mainUser.listRepFeedback != null) {
        List<Feedbacks> listFeedback =
            List.from(apiBloc.currentState.mainUser.listRepFeedback)
              ..addAll(tempList);
        User user = apiBloc.currentState.mainUser;
        user.listRepFeedback = listFeedback;
        apiBloc.changeMainUser(user);
      } else {
        User user = apiBloc.currentState.mainUser;
        user.listRepFeedback = tempList;
        apiBloc.changeMainUser(user);
      }
    }
  }
}

fetchListUnRepFeedback(
    ApiBloc apiBloc, String idUser, String begin, String end) async {
  final response =
      await client.get(url + 'feedback/get-list-unrep/$idUser/$begin/$end');
  if (response.statusCode == 200) {
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
    List<Feedbacks> tempList = new List<Feedbacks>();
    tempList =
        parsed.map<Feedbacks>((json) => Feedbacks.fromJson(json)).toList();
    if (tempList.isNotEmpty) {
      if (apiBloc.currentState.mainUser.listUnrepFeedback != null) {
        List<Feedbacks> listFeedback =
            List.from(apiBloc.currentState.mainUser.listUnrepFeedback)
              ..addAll(tempList);
        User user = apiBloc.currentState.mainUser;
        user.listUnrepFeedback = listFeedback;
        apiBloc.changeMainUser(user);
      } else {
        User user = apiBloc.currentState.mainUser;
        user.listUnrepFeedback = tempList;
        apiBloc.changeMainUser(user);
      }
    }
  }
}

//********AUTHEN***

Future<int> registerUser(String username, String name, String password,
    String phone, String address) async {
  final response = await client.post(url + 'user/register', body: {
    "username": username,
    "name": name,
    "password": password,
    "phone": phone,
    "address": address,
  });
  if (response.statusCode == 200) {
    Code code = Code.fromJson(json.decode(response.body));
    return code.code;
  } else {
    return 0;
  }
}

Future<int> updateToken(String idUser, String token) async {
  final response = await client.post(url + 'user/updatetoken', body: {
    "id": idUser,
    "token": token,
  });
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    return -1;
  }
}

Future<String> getTokenById(String idUser) async {
  final response = await client.get(url + 'user/gettoken/$idUser');

  if (response.statusCode == 200) {
    if (json.decode(response.body) != 0) {
      return json.decode(response.body)["firebasetoken"];
    } else {
      return null;
    }
  } else {
    return null;
  }
}

//changePasswordForgot
Future<int> changePasswordForgot(String phone, String password) async {
  final response = await client.post(url + 'user/change-password-by-phone',
      body: {'phone': phone, 'password': password});

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    return 0;
  }
}

//***************************************************ADMIN*********************************************

fetchListUnprovedProducts(AdminBloc adminBloc, String begin, String end) async {
  final response =
      await client.get(url + 'product/get-list-unproved/$begin/$end');

  if (response.statusCode == 200) {
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
    List<Product> temp =
        parsed.map<Product>((json) => Product.fromJson(json)).toList();
    if (temp.isNotEmpty) {
      for (int i = 0; i < temp.length; i++) {
        final responseUser =
            await client.get(url + 'user/get/' + temp[i].idUser);
        User user = new User();
        if (responseUser.statusCode == 200) {
          user = User.fromJson(json.decode(responseUser.body));
        }
        temp[i].user = user;
      }
    }
    if (adminBloc.currentState.listUnprovedProducts != null) {
      List<Product> listProducts =
          List.from(adminBloc.currentState.listUnprovedProducts)..addAll(temp);
      adminBloc.changeUnprovedList(listProducts);
    } else {
      adminBloc.changeUnprovedList(temp);
    }
  }
}

Future<int> approvedPost(
    AdminBloc adminBloc, String idProduct, int index) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final response = await client.get(
      url + 'admin/prove-product/$idProduct',
    headers: {
      HttpHeaders.authorizationHeader: prefs.getString('token'),
    },
  );
  if (response.statusCode == 200) {
    print(response.body);
    Code code = Code.fromJson(json.decode(response.body));
    if (code.code == 1) {
      List<Product> listProducts = new List<Product>();
      listProducts = adminBloc.currentState.listUnprovedProducts;
      listProducts.removeAt(index);
      adminBloc.changeUnprovedList(listProducts);
      int amountPost = adminBloc.currentState.amountUnprovedPost;
      amountPost--;
      adminBloc.changeAmountPost(amountPost);
      return code.code;
    } else {
      return code.code;
    }
  }
  return -1;
}

Future<int> deletePostByAdmin(AdminBloc adminBloc, String idProduct, int index) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final response = await client.post(
      url + 'product/update/status',
      headers: {
        HttpHeaders.authorizationHeader: prefs.getString('token'),
      },
      body: {
    "id": idProduct,
    "status": "false",
  });
  if (response.statusCode == 200) {
    Code code = Code.fromJson(json.decode(response.body));
    if (code.code == 1) {
      print(index);
      List<Product> listProducts = new List<Product>();
      listProducts = adminBloc.currentState.listUnprovedProducts;
      listProducts.removeAt(index);
      adminBloc.changeUnprovedList(listProducts);
      int amountPost = adminBloc.currentState.amountUnprovedPost;
      amountPost--;
      adminBloc.changeAmountPost(amountPost);
      return code.code;
    } else {
      return code.code;
    }
  }
  return -1;
}

Future<int> deleteReportByAdmin(AdminBloc adminBloc, String idProduct, String idReport, int index) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final response = await client.post(
      url + 'product/update/status',
      headers: {
        HttpHeaders.authorizationHeader: prefs.getString('token'),
      },
      body: {
        "id": idProduct,
        "status": "false",
      });
  if (response.statusCode == 200) {
    Code code = Code.fromJson(json.decode(response.body));
    if (code.code == 1) {
      final responseSolve = await client.get(url + 'report/solve/$idReport');
      if (responseSolve.statusCode == 200) {
        List<Report> listReports = adminBloc.currentState.listReports;
        listReports.removeAt(index);
        adminBloc.changeReportList(listReports);
        int amountReport = adminBloc.currentState.amountReports;
        amountReport--;
        adminBloc.changeAmountReport(amountReport);
      }

      return code.code;
    } else {
      return code.code;
    }
  }
  return -1;
}

Future<int> deletePostByUser(String idProduct) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  final response = await client.post(
      url + 'product/update/status',
      headers: {
        HttpHeaders.authorizationHeader: prefs.getString('token'),
      },
      body: {
    "id": idProduct,
    "status": "false",
  });
  if (response.statusCode == 200) {
    print(response.body);
    Code code = Code.fromJson(json.decode(response.body));
    if (code.code == 1) {
      return code.code;
    } else {
      return code.code;
    }
  }
  return -1;
}

fetchAmountUnprovedPost(AdminBloc adminBloc) async {
  final response = await client.get(url + 'product/count-unproved');

  if (response.statusCode == 200) {
    adminBloc.changeAmountPost(json.decode(response.body));
  }
}

fetchAmountReport(AdminBloc adminBloc) async {
  final response = await client.get(url + 'report/count-unsolve');
  if (response.statusCode == 200) {
    adminBloc.changeAmountReport(json.decode(response.body));
  }
}

fetchAmountUnrepFeedbacks(AdminBloc adminBloc) async {
  final response = await client.get(url + 'feedback/count-unrep');

  if (response.statusCode == 200) {
    adminBloc.changeAmountFeedback(json.decode(response.body));
  }
}

fetchListUnrepAdminFeedback(
    AdminBloc adminBloc, String begin, String end) async {
  final response =
      await client.get(url + 'feedback/get-list-unrep/$begin/$end');
  if (response.statusCode == 200) {
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
    List<Feedbacks> tempList = new List<Feedbacks>();
    tempList =
        parsed.map<Feedbacks>((json) => Feedbacks.fromJson(json)).toList();
    if (tempList.isNotEmpty) {
      for (int i = 0; i < tempList.length; i++) {
        final responseUser =
            await client.get(url + 'user/get/' + tempList[i].userFb);
        User user = new User();
        if (responseUser.statusCode == 200) {
          user = User.fromJson(json.decode(responseUser.body));
        }
        tempList[i].user = user;
      }
    }
    if (adminBloc.currentState.listFeedbacks != null) {
      List<Feedbacks> listFeedback =
          List.from(adminBloc.currentState.listFeedbacks)..addAll(tempList);
      adminBloc.changeFeedbackList(listFeedback);
    } else {
      adminBloc.changeFeedbackList(tempList);
    }
  }
}

Future<int> replyFeedback(
    AdminBloc adminBloc, String idFeedback, String reply, int index) async {
  final response = await client.post(url + 'feedback/reply', body: {
    "idfeedback": idFeedback,
    "reply": reply,
  });

  if (response.statusCode == 200) {
    Code code = Code.fromJson(json.decode(response.body));
    if (code.code == 1) {
      List<Feedbacks> listFeedbacks = adminBloc.currentState.listFeedbacks;
      listFeedbacks.removeAt(index);
      adminBloc.changeFeedbackList(listFeedbacks);
      int amountFeedbacks = adminBloc.currentState.amountFeedbacks;
      amountFeedbacks--;
      adminBloc.changeAmountFeedback(amountFeedbacks);
      return code.code;
    } else {
      return code.code;
    }
  }
  return -1;
}

Future<int> removeFeedback(
    AdminBloc adminBloc, String idFeedback, int index) async {
  final response = await client.get(
    url + 'feedback/update-status/$idFeedback',
  );
  if (response.statusCode == 200) {
    if (json.decode(response.body) == 1) {
      List<Feedbacks> listFeedbacks = adminBloc.currentState.listFeedbacks;
      listFeedbacks.removeAt(index);
      adminBloc.changeFeedbackList(listFeedbacks);
      int amountFeedbacks = adminBloc.currentState.amountFeedbacks;
      amountFeedbacks--;
      adminBloc.changeAmountFeedback(amountFeedbacks);
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }
  return -1;
}

fetchReport(AdminBloc adminBloc, String begin, String end) async {
  final response = await client.get(
    url + 'report/get-list-unsolve/$begin/$end',
  );
  if (response.statusCode == 200) {
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
    List<Report> tempList = new List<Report>();
    tempList = parsed.map<Report>((json) => Report.fromJson(json)).toList();
    if (tempList.isNotEmpty) {
      for (int i = 0; i < tempList.length; i++) {
        final responseUser =
            await client.get(url + 'user/get/' + tempList[i].idUser);
        User userReport = new User();
        if (responseUser.statusCode == 200) {
          userReport = User.fromJson(json.decode(responseUser.body));
        }
        tempList[i].userReport = userReport;
        final responseUserReportted =
            await client.get(url + 'user/get/' + tempList[i].product.idUser);
        User userReportted = new User();
        if (responseUserReportted.statusCode == 200) {
          userReportted =
              User.fromJson(json.decode(responseUserReportted.body));
        }
        tempList[i].product.user = userReportted;
      }
    }
    if (adminBloc.currentState.listReports != null) {
      List<Report> listReports = List.from(adminBloc.currentState.listReports)
        ..addAll(tempList);
      adminBloc.changeReportList(listReports);
    } else {
      adminBloc.changeReportList(tempList);
    }
  }
}

Future<int> solveReport(AdminBloc adminBloc, String id, int index) async {
  final response = await client.get(url + 'report/solve/$id');
  if (response.statusCode == 200) {
    if (json.decode(response.body) == 1) {
      List<Report> listReports = adminBloc.currentState.listReports;
      listReports.removeAt(index);
      adminBloc.changeReportList(listReports);
      int amountReport = adminBloc.currentState.amountReports;
      amountReport--;
      adminBloc.changeAmountReport(amountReport);
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  } else {
    return -1;
  }
}

Future<Login> loginAdmin(String username, String password) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final response = await client.post(url + 'admin/login', body: {
    'username': username,
    'password': password,
  });
  if (response.statusCode == 200) {
    Login login = Login.fromJson(json.decode(response.body));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', login.token);
    return login;
  } else {
    return null;
  }
}
