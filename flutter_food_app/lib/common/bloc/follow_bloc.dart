import 'package:bloc/bloc.dart';
import 'package:flutter_food_app/api/model/user.dart';
import 'package:flutter_food_app/common/event/follow_event.dart';
import 'package:flutter_food_app/common/state/follow_state.dart';

class FollowBloc extends Bloc<FollowEvent, FollowState> {
  void changeFollow(List<User> listFollow) {
    dispatch(ChangeFollow(listFollow));
  }
  @override
  // TODO: implement initialState
  FollowState get initialState => FollowState.initial();

  @override
  Stream<FollowState> mapEventToState(FollowState currentState, FollowEvent event) async* {
    if (event is ChangeFollow) {
      yield FollowState(
        listFollow: event.listFollow,
      );
    }
  }

}