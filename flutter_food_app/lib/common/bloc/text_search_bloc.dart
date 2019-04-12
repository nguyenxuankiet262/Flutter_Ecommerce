import 'package:bloc/bloc.dart';
import 'package:flutter_food_app/common/event/text_search_event.dart';
import 'package:flutter_food_app/common/state/text_search_state.dart';

class SearchInputBloc extends Bloc<TextSearchEvent, TextSearchState> {
  void searchInput(int index, String textInput) {
    dispatch(SearchInput(index, textInput));
  }

  @override
  // TODO: implement initialState
  TextSearchState get initialState => TextSearchState.initial();

  @override
  Stream<TextSearchState> mapEventToState(
      TextSearchState currentState, TextSearchEvent event) async* {
    // TODO: implement mapEventToState
    if (event is SearchInput) {
      yield TextSearchState(index: event.index, searchInput: event.searchInput);
    }
  }
}
