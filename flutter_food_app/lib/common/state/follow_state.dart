import 'package:flutter_food_app/api/model/user.dart';

class FollowState{
  final List<User> listFollow;
  const FollowState({this.listFollow});
  factory FollowState.initial() => FollowState(
    listFollow: null,
  );
}