import 'package:bloc/bloc.dart';
import 'package:flutter_food_app/common/event/detail_page_event.dart';
import 'package:flutter_food_app/common/state/detail_page_state.dart';

class DetailPageBloc extends Bloc<DetailPageEvent, DetailPageState> {
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
  DetailPageState get initialState => DetailPageState.initial();

  @override
  Stream<DetailPageState> mapEventToState(
      DetailPageState currentState, DetailPageEvent event) async* {
    // TODO: implement mapEventToState
    if (event is ChangeCategory) {
      yield DetailPageState(
          indexCategory: event.indexCategory,
          indexChildCategory: event.indexChildCategory,
          filter: currentState.filter,
          tempCategory: currentState.tempCategory,
          tempChildCategory: currentState.tempChildCategory,
          tempFilter: currentState.tempFilter);
    }
    if (event is ChangeFilter) {
      yield DetailPageState(
          indexCategory: currentState.indexCategory,
          indexChildCategory: currentState.indexChildCategory,
          filter: event.filter,
          tempCategory: currentState.tempCategory,
          tempChildCategory: currentState.tempChildCategory,
          tempFilter: currentState.tempFilter);
    }
    if (event is ChangeTempCategory) {
      yield DetailPageState(
          indexCategory: currentState.indexCategory,
          indexChildCategory: currentState.indexChildCategory,
          filter: currentState.filter,
          tempCategory: event.tempCategory,
          tempChildCategory: event.tempChildCategory,
          tempFilter: currentState.tempFilter);
    }
    if (event is ChangeTempFilter) {
      yield DetailPageState(
          indexCategory: currentState.indexCategory,
          indexChildCategory: currentState.indexChildCategory,
          filter: currentState.filter,
          tempCategory: currentState.tempCategory,
          tempChildCategory: currentState.tempChildCategory,
          tempFilter: event.tempFilter);
    }
  }
}
