import 'package:flutter_food_app/api/model/product.dart';

abstract class ListProductEvent{}

class ChangeListProduct extends ListProductEvent{
  final List<Product> listProduct;
  ChangeListProduct(this.listProduct);
}