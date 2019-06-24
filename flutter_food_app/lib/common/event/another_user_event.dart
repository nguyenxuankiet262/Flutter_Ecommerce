import 'package:flutter_food_app/api/model/user.dart';

abstract class AnotherUserEvent{}

class ChangeAnotherUser extends AnotherUserEvent{
  final User user;
  ChangeAnotherUser(this.user);
}