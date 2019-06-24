import 'package:flutter_food_app/api/model/product.dart';

abstract class ListSearchProductEvent{}

class ChangeListSearchProduct extends ListSearchProductEvent{
  final List<Product> listProduct;
  ChangeListSearchProduct(this.listProduct);
}