import 'package:flutter_food_app/api/model/user.dart';

class AnotherUserState{
  final User user;

  const AnotherUserState({this.user});

  factory AnotherUserState.initial() => AnotherUserState(user: null);
}