import 'package:bloc/bloc.dart';
import 'package:flutter_food_app/api/model/cart.dart';
import 'package:flutter_food_app/api/model/child_menu.dart';
import 'package:flutter_food_app/api/model/menu.dart';
import 'package:flutter_food_app/api/model/product.dart';
import 'package:flutter_food_app/api/model/user.dart';
import 'package:flutter_food_app/common/event/api_event.dart';
import 'package:flutter_food_app/common/state/api_state.dart';

class ApiBloc extends Bloc<ApiEvent, ApiState> {
  void changeMenu(List<Menu> listMenu) {
    dispatch(ChangeListMenu(listMenu));
  }

  void changeListProduct(List<Product> listProduct) {
    dispatch(ChangeListProduct(listProduct));
  }

  void changeProduct(Product product) {
    dispatch(ChangeProduct(product));
  }

  void changeMainUser(User user) {
    dispatch(ChangeMainUser(user));
  }

  void changeCart(Cart cart) {
    dispatch(ChangeCart(cart));
  }

  @override
  // TODO: implement initialState
  ApiState get initialState => ApiState.initial();

  @override
  Stream<ApiState> mapEventToState(
      ApiState currentState, ApiEvent event) async* {
    // TODO: implement mapEventToState
    if (event is ChangeListMenu) {
      yield ApiState(
        listMenu: event.listMenu,
        listProduct: currentState.listProduct,
        cart: currentState.cart,
        product: currentState.product,
        mainUser: currentState.mainUser,
      );
    }
    if (event is ChangeListProduct) {
      yield ApiState(
        listMenu: currentState.listMenu,
        listProduct: event.listProduct,
        cart: currentState.cart,
        product: currentState.product,
        mainUser: currentState.mainUser,
      );
    }
    if (event is ChangeProduct) {
      yield ApiState(
        listMenu: currentState.listMenu,
        listProduct: currentState.listProduct,
        cart: currentState.cart,
        product: event.product,
        mainUser: currentState.mainUser,
      );
    }
    if (event is ChangeMainUser) {
      yield ApiState(
        listMenu: currentState.listMenu,
        listProduct: currentState.listProduct,
        cart: currentState.cart,
        product: currentState.product,
        mainUser: event.mainUser,
      );
    }
    if (event is ChangeCart) {
      yield ApiState(
        listMenu: currentState.listMenu,
        listProduct: currentState.listProduct,
        cart: event.cart,
        product: currentState.product,
        mainUser: currentState.mainUser,
      );
    }
  }
}
