import 'package:bloc/bloc.dart';
import 'package:flutter_food_app/common/event/list_product_event.dart';
import 'package:flutter_food_app/common/state/list_product_state.dart';
import 'package:flutter_food_app/api/model/product.dart';

class ListProductBloc extends Bloc<ListProductEvent, ListProductState> {
  void changeListProduct(List<Product> listProduct) {
    dispatch(ChangeListProduct(listProduct));
  }
  @override
  // TODO: implement initialState
  ListProductState get initialState => ListProductState.initial();

  @override
  Stream<ListProductState> mapEventToState(ListProductState currentState, ListProductEvent event) async* {
    if (event is ChangeListProduct) {
      yield ListProductState(
        listProduct: event.listProduct,
      );
    }
  }

}