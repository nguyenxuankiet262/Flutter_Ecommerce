import 'package:bloc/bloc.dart';
import 'package:flutter_food_app/common/event/product_event.dart';
import 'package:flutter_food_app/common/state/product_state.dart';
import 'package:flutter_food_app/api/model/product.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  void changeProduct(Product product) {
    dispatch(ChangeProduct(product));
  }
  @override
  // TODO: implement initialState
  ProductState get initialState => ProductState.initial();

  @override
  Stream<ProductState> mapEventToState(ProductState currentState, ProductEvent event) async* {
    if (event is ChangeProduct) {
      yield ProductState(
        product: event.product,
      );
    }
  }

}