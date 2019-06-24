import 'package:flutter_food_app/api/model/product.dart';

class ListSearchProductState{
  final List<Product> listProduct;
  const ListSearchProductState({this.listProduct});
  factory ListSearchProductState.initial() => ListSearchProductState(
    listProduct: new List<Product>(),
  );
}