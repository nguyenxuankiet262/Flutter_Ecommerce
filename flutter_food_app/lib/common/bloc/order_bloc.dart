import 'package:bloc/bloc.dart';
import 'package:flutter_food_app/api/model/order.dart';
import 'package:flutter_food_app/common/event/order_event.dart';
import 'package:flutter_food_app/common/state/order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrdersState> {
  void changeListOrder(List<Order> listOrders) {
    dispatch(ChangeListOrder(listOrders));
  }
  void changeLoading(bool isLoading){
    dispatch(ChangeLoadingOrder(isLoading));
  }
  @override
  // TODO: implement initialState
  OrdersState get initialState => OrdersState.initial();

  @override
  Stream<OrdersState> mapEventToState(OrdersState currentState, OrderEvent event) async* {
    if (event is ChangeListOrder) {
      yield OrdersState(
        listOrders: event.listOrders,
        isLoadingOrder: currentState.isLoadingOrder
      );
    }
    if (event is ChangeLoadingOrder) {
      yield OrdersState(
        listOrders: currentState.listOrders,
        isLoadingOrder: event.isLoading,
      );
    }
  }

}