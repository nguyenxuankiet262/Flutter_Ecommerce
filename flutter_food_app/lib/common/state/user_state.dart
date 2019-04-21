class UserState{
  final bool isLogin;

  const UserState({this.isLogin});

  factory UserState.initial() => UserState(isLogin: true);
}