import 'package:flutter_food_app/api/model/product.dart';

class ProductState{
  final Product product;
  const ProductState({this.product});
  factory ProductState.initial() => ProductState(
    product: null,
  );
}