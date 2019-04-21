import 'package:flutter/material.dart';

import 'login/login.dart';

class AuthenticationPage extends StatefulWidget{
  final int _index;
  AuthenticationPage(this._index);
  // _index = 0 means pop
  //  _index = 1 means navigating to Camera
  // _ index = 2 means open Rating
  // _index = 3 means open Report
  @override
  State<StatefulWidget> createState() => AuthenticationPageState();
}

class AuthenticationPageState extends State<AuthenticationPage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return LoginPage(widget._index);
  }
}