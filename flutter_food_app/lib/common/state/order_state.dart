import 'package:flutter_food_app/api/model/order.dart';

class OrdersState{
  final List<Order> listOrders;
  final bool isLoadingOrder;
  const OrdersState({this.listOrders, this.isLoadingOrder});
  factory OrdersState.initial() => OrdersState(
    listOrders: new List<Order>(),
    isLoadingOrder: true,
  );
}