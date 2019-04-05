import 'package:bloc/bloc.dart';
import 'package:flutter_food_app/common/event/search_event.dart';
import 'package:flutter_food_app/common/state/search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  void changePage(){
    dispatch(ChangePage());
  }

  @override
  // TODO: implement initialState
  SearchState get initialState => SearchState.initial();

  @override
  Stream<SearchState> mapEventToState(SearchState currentState, SearchEvent event) async * {
    if(event is ChangePage){
      yield SearchState(isSearch: !currentState.isSearch);
    }
  }

}