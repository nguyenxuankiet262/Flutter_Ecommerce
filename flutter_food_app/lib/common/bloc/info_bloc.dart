import 'package:bloc/bloc.dart';
import 'package:flutter_food_app/common/event/info_event.dart';
import 'package:flutter_food_app/common/state/info_state.dart';

class InfoBloc extends Bloc<InfoEvent, InfoState> {
  void changeInfo(String username, String phone, String address, String name, String intro, String link){
    dispatch(ChangeInfo(username, phone, address, name, intro, link));
  }

  void changeAvatar(String avatar){
    dispatch(ChangeAvatar(avatar));
  }

  void changeCover(String cover){
    dispatch(ChangeCover(cover));
  }

  @override
  // TODO: implement initialState
  InfoState get initialState => InfoState.initial();

  @override
  Stream<InfoState> mapEventToState(InfoState currentState, InfoEvent event) async*{
    // TODO: implement mapEventToState
    if(event is ChangeInfo){
      yield InfoState(
        username: event.username,
        phone: event.phone,
        address: event.address,
        name: event.name,
        intro: event.intro,
        link: event.link,
        avatar: currentState.avatar,
        coverphoto: currentState.coverphoto
      );
    }

    if(event is ChangeAvatar){
      yield InfoState(
          username: currentState.username,
          phone: currentState.phone,
          address: currentState.address,
          name: currentState.name,
          intro: currentState.intro,
          link: currentState.link,
          avatar: event.avatar,
          coverphoto: currentState.coverphoto
      );
    }

    if(event is ChangeCover){
      yield InfoState(
          username: currentState.username,
          phone: currentState.phone,
          address: currentState.address,
          name: currentState.name,
          intro: currentState.intro,
          link: currentState.link,
          avatar: currentState.avatar,
          coverphoto: event.coverphoto
      );
    }
  }

}