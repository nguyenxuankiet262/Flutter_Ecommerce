
import 'package:flutter_food_app/api/model/order.dart';

abstract class ListSearchOrderEvent{}

class ChangeListSearchOrder extends ListSearchOrderEvent{
  final List<Order> listOrder;
  ChangeListSearchOrder(this.listOrder);
}