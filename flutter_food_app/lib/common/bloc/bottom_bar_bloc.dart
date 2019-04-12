import 'package:bloc/bloc.dart';
import 'package:flutter_food_app/common/event/bottom_bar_event.dart';
import 'package:flutter_food_app/common/state/bottom_bar_state.dart';

class BottomBarBloc extends Bloc<BottomBarEvent, BottomBarState>{
  void changeVisible(bool isVisible){
    dispatch(ChangeVisibleFlag(isVisible));
  }
  @override
  // TODO: implement initialState
  BottomBarState get initialState => BottomBarState.initial();

  @override
  Stream<BottomBarState> mapEventToState(BottomBarState currentState, BottomBarEvent event) async*{
    // TODO: implement mapEventToState
    if(event is ChangeVisibleFlag){
      yield BottomBarState(isVisible: event.isVisible);
    }
  }
}