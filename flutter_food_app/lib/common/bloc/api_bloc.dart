import 'package:bloc/bloc.dart';
import 'package:flutter_food_app/api/model/banner.dart';
import 'package:flutter_food_app/api/model/cart.dart';
import 'package:flutter_food_app/api/model/menu.dart';
import 'package:flutter_food_app/api/model/product.dart';
import 'package:flutter_food_app/api/model/user.dart';
import 'package:flutter_food_app/common/event/api_event.dart';
import 'package:flutter_food_app/common/state/api_state.dart';

class ApiBloc extends Bloc<ApiEvent, ApiState> {
  void changeMenu(List<Menu> listMenu) {
    dispatch(ChangeListMenu(listMenu));
  }

  void changeMainUser(User user) {
    dispatch(ChangeMainUser(user));
  }

  void changeCart(Cart cart) {
    dispatch(ChangeCart(cart));
  }

  void changeListBanner(List<Banners> listBanner) {
    dispatch(ChangeListBanner(listBanner));
  }

  void changeTopNewest(List<Product> tenNewest) {
    dispatch(ChangeTopTenNewest(tenNewest));
  }

  void changeTopFav(List<Product> tenMostFav) {
    dispatch(ChangeTopTenFav(tenMostFav));
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
        cart: currentState.cart,
        mainUser: currentState.mainUser,
        listBanner: currentState.listBanner,
        tenNewest: currentState.tenNewest,
        tenMostFav: currentState.tenMostFav,
      );
    }
    if (event is ChangeListProduct) {
      yield ApiState(
        listMenu: currentState.listMenu,
        cart: currentState.cart,
        mainUser: currentState.mainUser,
        listBanner: currentState.listBanner,
        tenNewest: currentState.tenNewest,
        tenMostFav: currentState.tenMostFav,
      );
    }
    if (event is ChangeProduct) {
      yield ApiState(
        listMenu: currentState.listMenu,
        cart: currentState.cart,
        mainUser: currentState.mainUser,
        listBanner: currentState.listBanner,
        tenNewest: currentState.tenNewest,
        tenMostFav: currentState.tenMostFav,
      );
    }
    if (event is ChangeMainUser) {
      yield ApiState(
        listMenu: currentState.listMenu,
        cart: currentState.cart,
        mainUser: event.mainUser,
        listBanner: currentState.listBanner,
        tenNewest: currentState.tenNewest,
        tenMostFav: currentState.tenMostFav,
      );
    }
    if (event is ChangeCart) {
      yield ApiState(
        listMenu: currentState.listMenu,
        cart: event.cart,
        mainUser: currentState.mainUser,
        listBanner: currentState.listBanner,
        tenNewest: currentState.tenNewest,
        tenMostFav: currentState.tenMostFav,
      );
    }
    if (event is ChangeListBanner) {
      yield ApiState(
        listMenu: currentState.listMenu,
        cart: currentState.cart,
        mainUser: currentState.mainUser,
        listBanner: event.listBanner,
        tenNewest: currentState.tenNewest,
        tenMostFav: currentState.tenMostFav,
      );
    }
    if (event is ChangeTopTenNewest) {
      yield ApiState(
        listMenu: currentState.listMenu,
        cart: currentState.cart,
        mainUser: currentState.mainUser,
        listBanner: currentState.listBanner,
        tenNewest: event.tenNewest,
        tenMostFav: currentState.tenMostFav,
      );
    }
    if (event is ChangeTopTenFav) {
      yield ApiState(
        listMenu: currentState.listMenu,
        cart: currentState.cart,
        mainUser: currentState.mainUser,
        listBanner: currentState.listBanner,
        tenNewest: currentState.tenNewest,
        tenMostFav: event.tenMostFav,
      );
    }
  }
}
