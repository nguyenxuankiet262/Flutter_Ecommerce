import 'package:bloc/bloc.dart';
import 'package:flutter_food_app/common/event/function_event.dart';
import 'package:flutter_food_app/common/state/function_state.dart';

class FunctionBloc extends Bloc<FunctionEvent, FunctionState>{
  void openDrawer(Function _openDrawer){
    dispatch(OpenDrawer(_openDrawer));
  }

  void navigateToPost(Function _navigateToPost){
    dispatch(NavigateToPost(_navigateToPost));
  }

  void navigateToFilter(Function _navigateToFilter){
    dispatch(NavigateToFilter(_navigateToFilter));
  }

  void navigateToUser(Function _navigateToUser){
    dispatch(NavigateToUser(_navigateToUser));
  }

  @override
  // TODO: implement initialState
  FunctionState get initialState => FunctionState.initial();

  @override
  Stream<FunctionState> mapEventToState(FunctionState currentState, FunctionEvent event) async*{
    // TODO: implement mapEventToState
    if(event is OpenDrawer){
      yield FunctionState(
        openDrawer: event.openDrawer,
        navigateToPost: currentState.navigateToPost,
        navigateToFilter: currentState.navigateToFilter,
        navigateToUser: currentState.navigateToUser,
      );
    }
    if(event is NavigateToPost){
      yield FunctionState(
        openDrawer: currentState.openDrawer,
        navigateToPost: event.navigateToPost,
        navigateToFilter: currentState.navigateToFilter,
        navigateToUser: currentState.navigateToUser,
      );
    }
    if(event is NavigateToFilter){
      yield FunctionState(
        openDrawer: currentState.openDrawer,
        navigateToPost: currentState.navigateToPost,
        navigateToFilter: event.navigateToFilter,
        navigateToUser: currentState.navigateToUser,
      );
    }

    if(event is NavigateToUser){
      yield FunctionState(
        openDrawer: currentState.openDrawer,
        navigateToPost: currentState.navigateToPost,
        navigateToFilter: currentState.navigateToFilter,
        navigateToUser: event.navigateToUser,
      );
    }
  }
}