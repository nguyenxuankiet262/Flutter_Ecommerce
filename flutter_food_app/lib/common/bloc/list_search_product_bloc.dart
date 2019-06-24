import 'package:bloc/bloc.dart';
import 'package:flutter_food_app/common/event/list_search_product_event.dart';
import 'package:flutter_food_app/common/state/list_search_product_state.dart';
import 'package:flutter_food_app/api/model/product.dart';

class ListSearchProductBloc extends Bloc<ListSearchProductEvent, ListSearchProductState> {
  void changeListSearchProduct(List<Product> listProduct) {
    dispatch(ChangeListSearchProduct(listProduct));
  }
  @override
  // TODO: implement initialState
  ListSearchProductState get initialState => ListSearchProductState.initial();

  @override
  Stream<ListSearchProductState> mapEventToState(ListSearchProductState currentState, ListSearchProductEvent event) async* {
    if (event is ChangeListSearchProduct) {
      yield ListSearchProductState(
        listProduct: event.listProduct,
      );
    }
  }

}