import 'package:flutter_food_app/api/model/product.dart';

abstract class ProductEvent{}

class ChangeProduct extends ProductEvent{
  final Product product;
  ChangeProduct(this.product);
}