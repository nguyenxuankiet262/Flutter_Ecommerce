import 'package:bloc/bloc.dart';
import 'package:flutter_food_app/common/event/grid_event.dart';
import 'package:flutter_food_app/common/state/grid_state.dart';

class GridBloc extends Bloc<GridEvent, GridState>{
  void changGridView(){
    dispatch(ChangeGrid());
  }

  void changeListView(){
    dispatch(ChangeList());
  }

  @override
  // TODO: implement initialState
  GridState get initialState => GridState.initial();

  @override
  Stream<GridState> mapEventToState(GridState currentState, GridEvent event) async *{
    // TODO: implement mapEventToState
    if(event is ChangeGrid){
      yield GridState(count: 2);
    }
    else if (event is ChangeList){
      yield GridState(count: 1);
    }
  }

}
