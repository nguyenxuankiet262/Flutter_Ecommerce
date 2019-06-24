
import 'package:flutter_food_app/api/model/order.dart';

class ListSearchOrderState{
  final List<Order> listOrder;
  const ListSearchOrderState({this.listOrder});
  factory ListSearchOrderState.initial() => ListSearchOrderState(
    listOrder: new List<Order>(),
  );
}