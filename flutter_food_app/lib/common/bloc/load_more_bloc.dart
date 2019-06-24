import 'package:bloc/bloc.dart';
import 'package:flutter_food_app/common/event/load_more_event.dart';
import 'package:flutter_food_app/common/state/load_more_state.dart';

class LoadMoreBloc extends Bloc<LoadMoreEvent, LoadMoreState> {

  void changeLoadMore(int begin, int end) {
    dispatch(ChangeLoadMore(begin, end));
  }

  @override
  // TODO: implement initialState
  LoadMoreState get initialState => LoadMoreState.initial();

  @override
  Stream<LoadMoreState> mapEventToState(
      LoadMoreState currentState, LoadMoreEvent event) async* {
    // TODO: implement mapEventToState
    if (event is ChangeLoadMore) {
      yield LoadMoreState(
        begin: event.begin,
        end: event.end
      );
    }
  }
}
