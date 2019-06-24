import 'package:flutter_food_app/api/model/product.dart';

class ListProductState{
  final List<Product> listProduct;
  const ListProductState({this.listProduct});
  factory ListProductState.initial() => ListProductState(
    listProduct: new List<Product>(),
  );
}