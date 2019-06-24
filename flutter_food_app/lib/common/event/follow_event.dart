import 'package:flutter_food_app/api/model/user.dart';

abstract class FollowEvent{}

class ChangeFollow extends FollowEvent{
  final List<User> listFollow;
  ChangeFollow(this.listFollow);
}