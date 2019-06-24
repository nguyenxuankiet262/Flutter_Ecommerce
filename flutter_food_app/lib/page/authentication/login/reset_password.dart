import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_food_app/api/api.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:toast/toast.dart';

class ResetPasswordPage extends StatefulWidget{
  final phone;
  ResetPasswordPage(this.phone);
  @override
  State<StatefulWidget> createState() => ResetPasswordPageState();
}

class ResetPasswordPageState extends State<ResetPasswordPage>{
  String passwordInput = "";
  String verifyPasswordInput = "";
  final myControllerPassword = new TextEditingController();
  final myControllerVerifyPassword = new TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    myControllerPassword.addListener(_changePasswordInput);
    myControllerVerifyPassword.addListener(_changeVerifyPasswordInput);
  }

  _changePasswordInput(){
    setState(() {
      passwordInput = myControllerPassword.text;
    });
  }

  _changeVerifyPasswordInput(){
    setState(() {
      verifyPasswordInput = myControllerVerifyPassword.text;
    });
  }

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

  _resetPassword() async {
    _showLoading();
    if(myControllerPassword.text.length > 5 && myControllerVerifyPassword.text.length > 5){
      if(myControllerPassword.text == myControllerVerifyPassword.text){
        int check = await changePasswordForgot(widget.phone, myControllerPassword.text,);
        print(widget.phone);
        if(check == 1){
          Navigator.pop(context);
          Navigator.pop(context);
          Toast.show("Đổi mật khẩu thành công!", context, gravity: Toast.CENTER);
        }
        else{
          Navigator.pop(context);
          Toast.show("Lỗi hệ thống!", context, gravity: Toast.CENTER);
        }
      }
      else{
        Navigator.pop(context);
        Toast.show("Mật khẩu mới không trùng khớp!", context, gravity: Toast.CENTER);
      }
    }
    else{
      Navigator.pop(context);
      Toast.show("Mật khẩu phải từ 8 kí tự trở lên!", context, gravity: Toast.CENTER);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    myControllerPassword.dispose();
    myControllerVerifyPassword.dispose();
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Colors.white,
      child: Scaffold(
        appBar: new AppBar(
          elevation: 0.0,
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          brightness: Brightness.light,
          backgroundColor: Colors.white,
        ),
        body: Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  AvatarGlow(
                    startDelay: Duration(milliseconds: 1000),
                    glowColor: Colors.blue,
                    endRadius: 90.0,
                    duration: Duration(milliseconds: 2000),
                    repeat: true,
                    showTwoGlows: true,
                    repeatPauseDuration: Duration(milliseconds: 100),
                    child: Material(
                      elevation: 8.0,
                      shape: CircleBorder(),
                      child: CircleAvatar(
                        backgroundColor:colorActive,
                        child: Icon(
                          FontAwesomeIcons.key,
                          size: 70,
                          color: Colors.white,
                        ),
                        radius: 40.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: Text(
                      "Đặt Lại Mật Khẩu",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: Text(
                      "Vui lòng nhập mật khẩu mới bên dưới",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: colorInactive
                      ),
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.only(
                        left: 30, right: 30, top: 50),
                    elevation: 11,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(40))),
                    child: TextField(
                      obscureText: true,
                      controller: myControllerPassword,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.black26,
                          ),
                          suffixIcon: Icon(
                            Icons.check_circle,
                            color: myControllerPassword.text.length > 5
                                ? Colors.blue
                                : Colors.black26,
                          ),
                          hintText: "Nhập mật khẩu mới",
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
                        left: 30, right: 30, top: 30),
                    elevation: 11,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(40))),
                    child: TextField(
                      obscureText: true,
                      controller: myControllerVerifyPassword,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.vpn_key,
                            color: Colors.black26,
                          ),
                          suffixIcon: Icon(
                            Icons.check_circle,
                            color: myControllerVerifyPassword.text.length > 5
                                ? Colors.blue
                                : Colors.black26,
                          ),
                          hintText: "Xác nhận mật khẩu",
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
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(30),
                    child: RaisedButton(
                      padding: EdgeInsets.symmetric(
                          vertical: 16.0),
                      child: Text(
                        "HOÀN TẤT",
                        style: TextStyle(
                            fontWeight:
                            FontWeight.w500),
                      ),
                      textColor: Colors.white,
                      color: colorActive,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(8)),
                      ),
                      onPressed: _resetPassword,
                    ),
                  )
                ],
              ),
            ],
          )
        ),
      )
    );
  }
}