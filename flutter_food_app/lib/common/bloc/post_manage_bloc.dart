import 'package:bloc/bloc.dart';
import 'package:flutter_food_app/common/event/post_manage_event.dart';
import 'package:flutter_food_app/common/state/post_manage_state.dart';

class PostManageBloc extends Bloc<PostManageEvent, PostManageState> {
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
  PostManageState get initialState => PostManageState.initial();

  @override
  Stream<PostManageState> mapEventToState(
      PostManageState currentState, PostManageEvent event) async* {
    // TODO: implement mapEventToState
    if (event is ChangeCategory) {
      yield PostManageState(
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
      yield PostManageState(
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
      yield PostManageState(
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
      yield PostManageState(
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
