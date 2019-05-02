import 'package:bloc/bloc.dart';
import 'package:flutter_food_app/api/model/menu.dart';
import 'package:flutter_food_app/common/event/api_event.dart';
import 'package:flutter_food_app/common/state/api_state.dart';

class ApiBloc extends Bloc<ApiEvent, ApiState>{
  void changeMenu(List<Menu> listMenu){
    dispatch(ChangeListMenu(listMenu));
  }
  @override
  // TODO: implement initialState
  ApiState get initialState => ApiState.initial();

  @override
  Stream<ApiState> mapEventToState(ApiState currentState, ApiEvent event) async*{
    // TODO: implement mapEventToState
    if(event is ChangeListMenu){
      yield ApiState(listMenu: event.listMenu);
    }
  }
}