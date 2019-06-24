import 'package:flutter_food_app/api/model/product.dart';

class TopFav {
  Product product;
  int like;

  TopFav({
    this.product,
    this.like,
  });

  factory TopFav.fromJson(Map<String, dynamic> json) => new TopFav(
    product: Product.fromJson(json["product"]),
    like: json["like"],
  );
}