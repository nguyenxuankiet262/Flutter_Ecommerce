import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_account_kit/flutter_account_kit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/api/api.dart';
import 'package:flutter_food_app/api/model/login.dart';
import 'package:flutter_food_app/common/bloc/api_bloc.dart';
import 'package:flutter_food_app/common/bloc/bottom_bar_bloc.dart';
import 'package:flutter_food_app/common/bloc/function_bloc.dart';
import 'package:flutter_food_app/common/bloc/loading_bloc.dart';
import 'package:flutter_food_app/common/bloc/user_bloc.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter_food_app/page/authentication/login/reset_password.dart';
import 'package:flutter_food_app/page/authentication/register/register.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:toast/toast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  UserBloc userBloc;
  FunctionBloc functionBloc;
  LoadingBloc loadingBloc;
  String usernameInput = "";
  String passwordInput = "";
  bool isShow = false;
  ApiBloc apiBloc;
  FlutterAccountKit akt = FlutterAccountKit();
  String token;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  bool isAdmin = false;

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

  Future<void> initAccountkit() async {
    try {
      final theme = AccountKitTheme(
          headerBackgroundColor: colorActive,
          buttonBackgroundColor: colorActive,
          buttonBorderColor: Colors.white,
          buttonTextColor: Colors.white);
      await akt.configure(Config()
        ..facebookNotificationsEnabled = true
        ..receiveSMS = true
        ..readPhoneStateEnabled = true
        ..theme = theme);
    } on PlatformException {
      print('Failed to initialize account kit');
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
    setState(() {});
  }

  Future<void> _resetPassword() async{
    initAccountkit();
    final result = await akt.logInWithPhone();
    if (result.status == LoginStatus.cancelledByUser) {
    } else if (result.status == LoginStatus.error) {
      Toast.show("Lỗi hệ thống!", context);
    } else {
      _showLoading();
      Future.delayed(const Duration(milliseconds: 500), () async {
        Account account = await akt.currentAccount;
        if (account != null) {
          PhoneNumber phoneNumber = account.phoneNumber;
          int check = await checkInfoUser(phoneNumber.toString());
          if (check == 0) {
            Navigator.pop(context);
            Toast.show("Lỗi hệ thống!", context);
          } else if (check == 1) {
            Navigator.pop(context);
            Toast.show("Số điện thoại không tồn tại!", context);
          } else {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ResetPasswordPage(phoneNumber.toString()),
              ),
            );
          }
        } else {
          Navigator.pop(context);
          print("not found");
        }
      });
    }
  }

  Future<void> _register() async {
    initAccountkit();
    final result = await akt.logInWithPhone();
    if (result.status == LoginStatus.cancelledByUser) {
    } else if (result.status == LoginStatus.error) {
      Toast.show("Lỗi hệ thống!", context);
    } else {
      _showLoading();
      Future.delayed(const Duration(milliseconds: 500), () async {
        Account account = await akt.currentAccount;
        if (account != null) {
          PhoneNumber phoneNumber = account.phoneNumber;
          int check = await checkInfoUser(phoneNumber.toString());
          print(phoneNumber.toString());
          if (check == 0) {
            Navigator.pop(context);
            Toast.show("Lỗi hệ thống!", context);
          } else if (check == 1) {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RegisterPage(phoneNumber.toString()),
              ),
            );
          } else {
            Navigator.pop(context);
            Toast.show("Số điện thoại đã có người sử dụng!", context);
          }
        } else {
          Navigator.pop(context);
          print("not found");
        }
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiBloc = BlocProvider.of<ApiBloc>(context);
    loadingBloc = BlocProvider.of<LoadingBloc>(context);
    userBloc = BlocProvider.of<UserBloc>(context);
    functionBloc = BlocProvider.of<FunctionBloc>(context);
    myControllerUserName.addListener(_changeUsernameInput);
    myControllerPassword.addListener(_changePasswordInput);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    functionBloc.onBeforeLogin((){});
    BlocProvider.of<BottomBarBloc>(context).changeVisible(true);
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
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

  _checkAdmin() async {
    _showLoading();
    if(usernameInput.isNotEmpty && passwordInput.isNotEmpty){
      Login login = await loginAdmin(usernameInput, passwordInput);
      if (login != null) {
        if (login.code != null) {
          await Future.delayed(const Duration(milliseconds: 1000), () {
            Toast.show("Tên đăng nhập hoặc mật khẩu chưa đúng!", context);
            Navigator.pop(context);
          });
        } else {
          await Future.delayed(const Duration(milliseconds: 1000), () {
            userBloc.loginAdmin();
            functionBloc.onBackPressed((){});
            Toast.show("Đăng nhập thành công!", context, duration: 2);
            Navigator.pop(context);
            Navigator.pop(context);
          });
        }
      } else {
        await Future.delayed(const Duration(milliseconds: 1000), () {
          Toast.show("Lỗi hệ thống!", context);
          Navigator.pop(context);
        });
      }
    }
    else{
      await Future.delayed(const Duration(milliseconds: 1000), () {
        Toast.show("Vui lòng nhập đầy đủ thông tin!", context);
        Navigator.pop(context);
      });

    }
  }

  _checkAuthen() async {
    _showLoading();
    if(usernameInput.isNotEmpty && passwordInput.isNotEmpty){
      Login login = await checkLogin(usernameInput, passwordInput);
      if (login != null) {
        if (login.code != null) {
          await Future.delayed(const Duration(milliseconds: 1000), () {
            Toast.show("Tên đăng nhập hoặc mật khẩu chưa đúng!", context);
            Navigator.pop(context);
          });
        } else {
          userBloc.login();
          loadingBloc.changeLoadingSysNoti(true);
          loadingBloc.changeLoadingCart(true);
          loadingBloc.changeLoadingSysNoti(true);
          loadingBloc.changeLoadingFollowNoti(true);
          await _firebaseMessaging.getToken().then((_token){
            setState(() {
              token = _token;
            });
          });
          _firebaseMessaging.onTokenRefresh.listen((newToken) {
            setState(() {
              token = newToken;
            });
          });
          await fetchUserById(apiBloc, login.user);
          updateToken(login.user, token);
          fetchCountNewOrder(apiBloc, login.user);
          fetchSystemNotificaion(apiBloc, loadingBloc, login.user, "1", "10");
          fetchFollowNotificaion(apiBloc, loadingBloc, login.user, "1", "10");
          fetchAmountNewSystemNoti(apiBloc, login.user);
          fetchAmountNewFollowNoti(apiBloc, login.user);
          fetchListPostUser(apiBloc, loadingBloc, login.user, 1, 10);
          fetchRatingByUser(apiBloc, login.user, "1", "10");
          fetchCartByUserId(apiBloc, loadingBloc, login.user);
          Navigator.pop(context);
          Future.delayed(const Duration(milliseconds: 500), () {
            Toast.show("Đăng nhập thành công!", context, duration: 2);
            Navigator.pop(context);
            functionBloc.currentState.onBeforeLogin();
          });
        }
      } else {
        await Future.delayed(const Duration(milliseconds: 1000), () {
          Toast.show("Lỗi hệ thống!", context);
          Navigator.pop(context);
        });
      }
    }
    else{
      await Future.delayed(const Duration(milliseconds: 1000), () {
        Toast.show("Vui lòng nhập đầy đủ thông tin!", context);
        Navigator.pop(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(
                                top: 50,
                                bottom: MediaQuery.of(context).size.height / 10),
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
                                      fontSize:
                                          MediaQuery.of(context).size.width /
                                              11.5,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                ),
                                Container(
                                    height: 2,
                                    margin: EdgeInsets.only(top: 5),
                                    width: MediaQuery.of(context).size.width *
                                        2 /
                                        2.9,
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Container(
                                        height: 2,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3,
                                        color: Colors.lightGreenAccent,
                                      ),
                                    )),
                                Container(
                                    margin: EdgeInsets.only(top: 5),
                                    width: MediaQuery.of(context).size.width *
                                        2 /
                                        2.9,
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        "We pursue a relaxed experience",
                                        textDirection: TextDirection.ltr,
                                        style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                30,
                                            color: colorGrey,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    )),
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
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(15)
                                    ],
                                    controller: myControllerUserName,
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.person,
                                          color: Colors.black26,
                                        ),
                                        suffixIcon: !isAdmin ? Icon(
                                          Icons.check_circle,
                                          color: usernameInput.length > 5
                                              ? Colors.blue
                                              : Colors.black26,
                                        ) : null,
                                        hintText: isAdmin ? "Nhập username" : "Nhập username/số điện thoại",
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
                                        suffixIcon: !isAdmin ? IconButton(
                                          onPressed: _resetPassword,
                                          icon: Icon(
                                            FontAwesomeIcons.solidQuestionCircle,
                                            color: colorInactive,
                                            size: 22,
                                          ),
                                          tooltip: "Quên mật khẩu?",
                                        ) : null,
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
                                  padding: EdgeInsets.only(right: 60, top: 20, left: 60),
                                  width: double.infinity,
                                  color: Colors.transparent,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(),
                                      GestureDetector(
                                        onTap: (){
                                          setState(() {
                                            isAdmin = !isAdmin;
                                          });
                                        },
                                        child: Row(
                                          children: <Widget>[
                                            Icon(
                                              isAdmin ? Icons.check_box : Icons.check_box_outline_blank,
                                              color: isAdmin ? Colors.white : Colors.white.withOpacity(0.5),
                                            ),
                                            Padding(
                                                padding: EdgeInsets.only(left: 8.0),
                                                child: Text(
                                                  "Quản trị viên",
                                                  style: TextStyle(
                                                      color: isAdmin ? Colors.white : Colors.white.withOpacity(0.5),
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 15
                                                  ),
                                                )
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                ),
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.only(right: 30.0, left: 30.0, bottom: 30, top: 20),
                                  child: RaisedButton(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 16.0),
                                    color: Colors.red,
                                    onPressed: isAdmin ? _checkAdmin : _checkAuthen ,
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
                                isAdmin
                                ? Container()
                                : Align(
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
                                                Toast.show(
                                                    "Hệ thống chưa hộ trợ!",
                                                    context);
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            width: 30.0,
                                          ),
                                        ],
                                      ),
                                      Container(
                                          margin: EdgeInsets.symmetric(
                                              vertical: 15),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text("Chưa có tài khoản?",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white)),
                                              FlatButton(
                                                  child: Text(
                                                    "Đăng kí",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  textColor:
                                                      Colors.orangeAccent,
                                                  onPressed: _register)
                                            ],
                                          ))
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
                ),
                Positioned(
                  left: 16,
                  top: 32,
                  child: IconButton(
                    icon: Icon(
                      FontAwesomeIcons.times,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                )
              ],
            )));
  }
}
