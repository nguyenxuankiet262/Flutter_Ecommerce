import 'package:bloc/bloc.dart';
import 'package:flutter_food_app/api/model/order.dart';
import 'package:flutter_food_app/common/event/list_search_order_event.dart';
import 'package:flutter_food_app/common/state/list_search_order_state.dart';

class ListSearchOrderBloc extends Bloc<ListSearchOrderEvent, ListSearchOrderState> {
  void changeListSearchOrder(List<Order> listOrder) {
    dispatch(ChangeListSearchOrder(listOrder));
  }
  @override
  // TODO: implement initialState
  ListSearchOrderState get initialState => ListSearchOrderState.initial();

  @override
  Stream<ListSearchOrderState> mapEventToState(ListSearchOrderState currentState, ListSearchOrderEvent event) async* {
    if (event is ChangeListSearchOrder) {
      yield ListSearchOrderState(
        listOrder: event.listOrder,
      );
    }
  }
}