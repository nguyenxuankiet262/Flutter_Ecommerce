import 'package:bloc/bloc.dart';
import 'package:flutter_food_app/common/event/another_user_event.dart';
import 'package:flutter_food_app/common/state/another_user_state.dart';
import 'package:flutter_food_app/api/model/user.dart';

class AnotherUserBloc extends Bloc<AnotherUserEvent, AnotherUserState> {
  void changeAnotherUser(User user) {
    dispatch(ChangeAnotherUser(user));
  }
  @override
  // TODO: implement initialState
  AnotherUserState get initialState => AnotherUserState.initial();

  @override
  Stream<AnotherUserState> mapEventToState(AnotherUserState currentState, AnotherUserEvent event) async* {
    if (event is ChangeAnotherUser) {
      yield AnotherUserState(
        user: event.user,
      );
    }
  }

}