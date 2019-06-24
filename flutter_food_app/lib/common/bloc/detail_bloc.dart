import 'package:bloc/bloc.dart';
import 'package:flutter_food_app/common/event/detail_page_event.dart';
import 'package:flutter_food_app/common/state/detail_page_state.dart';

class DetailPageBloc extends Bloc<DetailPageEvent, DetailPageState> {
  void changeCategory(int indexCategory, int indexChildCategory) {
    dispatch(ChangeCategory(indexCategory, indexChildCategory));
  }

  void changeFilter(int min, int max, int code) {
    dispatch(ChangeFilter(min, max, code));
  }

  void changeTempCategory(int tempCategory, int tempChildCategory) {
    dispatch(ChangeTempCategory(tempCategory, tempChildCategory));
  }

  void changeTempFilter(int tempMin, int tempMax, int tempCode) {
    dispatch(ChangeTempFilter(tempMin, tempMax, tempCode));
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
        min: currentState.min,
        max: currentState.max,
        code: currentState.code,
        tempCategory: currentState.tempCategory,
        tempChildCategory: currentState.tempChildCategory,
        tempMin: currentState.tempMin,
        tempMax: currentState.tempMax,
        tempCode: currentState.tempCode,
      );
    }
    if (event is ChangeFilter) {
      yield DetailPageState(
        indexCategory: currentState.indexCategory,
        indexChildCategory: currentState.indexChildCategory,
        min: event.min,
        max: event.max,
        code: event.code,
        tempCategory: currentState.tempCategory,
        tempChildCategory: currentState.tempChildCategory,
        tempMin: currentState.tempMin,
        tempMax: currentState.tempMax,
        tempCode: currentState.tempCode,
      );
    }
    if (event is ChangeTempCategory) {
      yield DetailPageState(
        indexCategory: currentState.indexCategory,
        indexChildCategory: currentState.indexChildCategory,
        min: currentState.min,
        max: currentState.max,
        code: currentState.code,
        tempCategory: event.tempCategory,
        tempChildCategory: event.tempChildCategory,
        tempMin: currentState.tempMin,
        tempMax: currentState.tempMax,
        tempCode: currentState.tempCode,
      );
    }
    if (event is ChangeTempFilter) {
      yield DetailPageState(
        indexCategory: currentState.indexCategory,
        indexChildCategory: currentState.indexChildCategory,
        min: currentState.min,
        max: currentState.max,
        code: currentState.code,
        tempCategory: currentState.tempCategory,
        tempChildCategory: currentState.tempChildCategory,
        tempMin: event.tempMin,
        tempMax: event.tempMax,
        tempCode: event.tempCode,
      );
    }
  }
}
