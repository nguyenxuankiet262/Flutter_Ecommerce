import 'package:bloc/bloc.dart';
import 'package:flutter_food_app/common/event/user_event.dart';
import 'package:flutter_food_app/common/state/user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  void login() {
    dispatch(Login());
  }

  void logout(){
    dispatch(Logout());
  }

  void loginAdmin() {
    dispatch(LoginAdmin());
  }

  @override
  // TODO: implement initialState
  UserState get initialState => UserState.initial();

  @override
  Stream<UserState> mapEventToState(UserState currentState,
      UserEvent event) async* {
    // TODO: implement mapEventToState
    if (event is Login) {
      yield UserState(isLogin: true, isAdmin: false);
    }
    if (event is Logout){
      yield UserState(isLogin: false, isAdmin:  false);
    }
    if (event is LoginAdmin){
      yield UserState(isLogin: false, isAdmin:  true);
    }
  }
}
