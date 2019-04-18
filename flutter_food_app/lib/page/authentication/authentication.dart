import 'package:flutter/material.dart';

import 'login/login.dart';

class AuthenticationPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => AuthenticationPageState();
}

class AuthenticationPageState extends State<AuthenticationPage>{
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return LoginPage();
  }
}