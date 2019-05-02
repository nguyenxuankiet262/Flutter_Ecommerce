import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/common/bloc/function_bloc.dart';
import 'package:flutter_food_app/common/bloc/user_bloc.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:toast/toast.dart';

class LoginPage extends StatefulWidget {
  final int _index;

  LoginPage(this._index);

  @override
  State<StatefulWidget> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  UserBloc userBloc;
  FunctionBloc functionBloc;
  String usernameInput = "";
  String passwordInput = "";
  bool isType = false;

  final myControllerUserName = new TextEditingController();
  final myControllerPassword = new TextEditingController();

  void _showLoading() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return SpinKitFadingCircle(
            color: Colors.white,
            size: 50.0,
          );
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userBloc = BlocProvider.of<UserBloc>(context);
    functionBloc = BlocProvider.of<FunctionBloc>(context);

    myControllerUserName.addListener(_changeUsernameInput);
    myControllerPassword.addListener(_changePasswordInput);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    myControllerUserName.dispose();
    myControllerPassword.dispose();
  }

  _changeUsernameInput() {
    setState(() {
      usernameInput = myControllerUserName.text;
    });
  }

  _changePasswordInput() {
    setState(() {
      passwordInput = myControllerPassword.text;
    });
  }

  _checkAuthen() {
    _showLoading();
    if (usernameInput == "kiki123" && passwordInput == "123456") {
      Future.delayed(const Duration(seconds: 2), () async {
        Navigator.pop(context);
        userBloc.login();
        if (widget._index == 0) {
          Navigator.pop(context);
        } else if (widget._index == 1) {
          functionBloc.currentState.navigateToInfoPost();
        }
      });
    } else {
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pop(context);
        Toast.show("Sai tài khoản hoặc mật khẩu", context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
            decoration: new BoxDecoration(
              image: DateTime.now().hour <= 17
                  ? new DecorationImage(
                      image: new AssetImage("assets/images/morning.png"),
                      fit: BoxFit.cover,
                    )
                  : new DecorationImage(
                      image: new AssetImage("assets/images/night.png"),
                      fit: BoxFit.cover,
                    ),
            ),
            child: Stack(
              children: <Widget>[
                Container(
                  color: Colors.black12,
                ),
                ListView(
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height -
                          MediaQuery.of(context).padding.top,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 50),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  DateTime.now().hour > 21
                                      ? "Good Night"
                                      : DateTime.now().hour > 17
                                          ? "Good Evening"
                                          : DateTime.now().hour > 10
                                              ? "Good Afternoon"
                                              : "Good Morning",
                                  style: TextStyle(
                                      fontSize: 40,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                ),
                                Container(
                                  height: 2,
                                  margin: EdgeInsets.only(left: 120, top: 5),
                                  width: 200,
                                  color: Colors.lightGreenAccent,
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 100, top: 5),
                                  child: Text(
                                    "We pursue a relaxed experience",
                                    textDirection: TextDirection.ltr,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: colorGrey,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Card(
                                  margin: EdgeInsets.only(
                                      left: 30, right: 30, top: 20),
                                  elevation: 11,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(40))),
                                  child: TextField(
                                    onTap: () {
                                      setState(() {
                                        isType = true;
                                      });
                                    },
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(10)
                                    ],
                                    controller: myControllerUserName,
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.person,
                                          color: Colors.black26,
                                        ),
                                        suffixIcon: Icon(
                                          Icons.check_circle,
                                          color: usernameInput.length > 5
                                              ? Colors.blue
                                              : Colors.black26,
                                        ),
                                        hintText: "Nhập username/số điện thoại",
                                        hintStyle: TextStyle(
                                            color: Colors.black26,
                                            fontSize: 12),
                                        filled: true,
                                        fillColor: Colors.white,
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(40.0)),
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 20.0, vertical: 16.0)),
                                  ),
                                ),
                                Card(
                                  margin: EdgeInsets.only(
                                      left: 30, right: 30, top: 20),
                                  elevation: 11,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(40))),
                                  child: TextField(
                                    onTap: () {
                                      setState(() {
                                        isType = true;
                                      });
                                    },
                                    controller: myControllerPassword,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.lock,
                                          color: Colors.black26,
                                        ),
                                        hintText: "Nhập mật khẩu",
                                        hintStyle: TextStyle(
                                            color: Colors.black26,
                                            fontSize: 12),
                                        filled: true,
                                        fillColor: Colors.white,
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(40.0)),
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 20.0, vertical: 16.0)),
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(30.0),
                                  child: RaisedButton(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 16.0),
                                    color: Colors.red,
                                    onPressed: () {
                                      _checkAuthen();
                                    },
                                    elevation: 11,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(40.0))),
                                    child: Text("Đăng nhập",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500)),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Text(
                                        "hoặc",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white70),
                                      ),
                                      SizedBox(
                                        height: 30.0,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          SizedBox(
                                            width: 30.0,
                                          ),
                                          Expanded(
                                            child: RaisedButton(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 16.0),
                                              child: Text(
                                                "Facebook",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              textColor: Colors.white,
                                              color: colorFB,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(40)),
                                              ),
                                              onPressed: () {

                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            width: 30.0,
                                          ),
                                        ],
                                      ),
                                      Container(
                                        margin: EdgeInsets.symmetric(vertical: 15),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text("Chưa có tài khoản?",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white)),
                                            FlatButton(
                                              child: Text(
                                                "Đăng kí",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              textColor: Colors.orangeAccent,
                                              onPressed: () {},
                                            )
                                          ],
                                        )
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            )));
  }
}
