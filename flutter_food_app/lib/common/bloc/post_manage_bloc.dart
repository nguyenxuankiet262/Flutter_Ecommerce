import 'package:bloc/bloc.dart';
import 'package:flutter_food_app/common/event/post_manage_event.dart';
import 'package:flutter_food_app/common/state/post_manage_state.dart';

class PostManageBloc extends Bloc<PostManageEvent, PostManageState> {
  void changeCategory(int indexCategory, int indexChildCategory) {
    dispatch(ChangeCategory(indexCategory, indexChildCategory));
  }

  void changeFilter(int filter) {
    dispatch(ChangeFilter(filter));
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
          filter: currentState.filter);
    }
    if (event is ChangeFilter) {
      yield PostManageState(
          indexCategory: currentState.indexCategory,
          indexChildCategory: currentState.indexChildCategory,
          filter: event.filter);
    }
  }
}
