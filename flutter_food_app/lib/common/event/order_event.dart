import 'package:flutter_food_app/api/model/order.dart';

abstract class OrderEvent{}

class ChangeListOrder extends OrderEvent{
  final List<Order> listOrders;
  ChangeListOrder(this.listOrders);
}

class ChangeLoadingOrder extends OrderEvent{
  final bool isLoading;
  ChangeLoadingOrder(this.isLoading);
}