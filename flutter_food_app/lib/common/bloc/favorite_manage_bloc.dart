import 'package:bloc/bloc.dart';
import 'package:flutter_food_app/common/event/favorite_manage_event.dart';
import 'package:flutter_food_app/common/state/favorite_manage_state.dart';

class FavoriteManageBloc extends Bloc<FavoriteManageEvent, FavoriteManageState> {
  void changeCategory(int indexCategory, int indexChildCategory) {
    dispatch(ChangeCategory(indexCategory, indexChildCategory));
  }

  void changeFilter(int filter) {
    dispatch(ChangeFilter(filter));
  }

  void changeTempCategory(int tempCategory, int tempChildCategory) {
    dispatch(ChangeTempCategory(tempCategory, tempChildCategory));
  }

  void changeTempFilter(int filter) {
    dispatch(ChangeFilter(filter));
  }

  @override
  // TODO: implement initialState
  FavoriteManageState get initialState => FavoriteManageState.initial();

  @override
  Stream<FavoriteManageState> mapEventToState(
      FavoriteManageState currentState, FavoriteManageEvent event) async* {
    // TODO: implement mapEventToState
    if (event is ChangeCategory) {
      yield FavoriteManageState(
          indexCategory: event.indexCategory,
          indexChildCategory: event.indexChildCategory,
          filter: currentState.filter,
          tempCategory: currentState.tempCategory,
          tempChildCategory: currentState.tempChildCategory,
          tempFilter: currentState.tempFilter);
    }
    if (event is ChangeFilter) {
      yield FavoriteManageState(
          indexCategory: currentState.indexCategory,
          indexChildCategory: currentState.indexChildCategory,
          filter: event.filter,
          tempCategory: currentState.tempCategory,
          tempChildCategory: currentState.tempChildCategory,
          tempFilter: currentState.tempFilter);
    }
    if (event is ChangeTempCategory) {
      yield FavoriteManageState(
          indexCategory: currentState.indexCategory,
          indexChildCategory: currentState.indexChildCategory,
          filter: currentState.filter,
          tempCategory: event.tempCategory,
          tempChildCategory: event.tempChildCategory,
          tempFilter: currentState.tempFilter);
    }
    if (event is ChangeTempFilter) {
      yield FavoriteManageState(
          indexCategory: currentState.indexCategory,
          indexChildCategory: currentState.indexChildCategory,
          filter: currentState.filter,
          tempCategory: currentState.tempCategory,
          tempChildCategory: currentState.tempChildCategory,
          tempFilter: event.tempFilter);
    }
  }
}
