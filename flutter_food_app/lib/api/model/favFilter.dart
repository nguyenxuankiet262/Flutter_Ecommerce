import 'package:flutter_food_app/api/model/product.dart';

class FavFilter {
  Product product;
  int like;

  FavFilter({
    this.product,
    this.like,
  });

  factory FavFilter.fromJson(Map<String, dynamic> json) => new FavFilter(
    product: Product.fromJson(json["product"]),
    like: json["like"],
  );
}