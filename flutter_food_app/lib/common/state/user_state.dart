class UserState{
  final bool isLogin;
  final bool isAdmin;

  const UserState({this.isLogin, this.isAdmin});

  factory UserState.initial() => UserState(isLogin: false, isAdmin: false);
}