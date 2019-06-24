import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/api/api.dart';
import 'package:flutter_food_app/common/bloc/location_bloc.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter_food_app/page/authentication/register/location_city.dart';
import 'package:flutter_food_app/page/authentication/register/location_province.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:toast/toast.dart';
import 'dart:convert' show ascii;


class RegisterPage extends StatefulWidget {
  final String phone;

  RegisterPage(this.phone);

  @override
  State<StatefulWidget> createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  String usernameInput = "";
  String verifyPasswordInput = "";
  String passwordInput = "";
  String name = "";
  String address = "";
  LocationBloc locationBloc;
  int indexCity = 4;
  int indexProvice = 0;
  final myControllerAddress = new TextEditingController();
  final myControllerUserName = new TextEditingController();
  final myControllerPassword = new TextEditingController();
  final myControllerVerifyPassword = new TextEditingController();
  final myControllerName = new TextEditingController();
  final myControllerCity = new TextEditingController();
  final myControllerProvince = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    locationBloc = BlocProvider.of<LocationBloc>(context);
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    myControllerUserName.addListener(_changeUsernameInput);
    myControllerPassword.addListener(_changePasswordInput);
    myControllerVerifyPassword.addListener(_changeVerifyPasswordInput);
    myControllerName.addListener(_changeName);
    myControllerAddress.addListener(_changeAddress);
  }

  _onChangeCity(int _indexCity) {
    if (_indexCity != indexCity) {
      myControllerProvince.clear();
    }
    myControllerCity.text = locationBloc.currentState.nameCities[_indexCity];
    setState(() {
      indexCity = _indexCity - 1;
    });
  }

  _onChangeProvince(int _indexProvince) {
    myControllerProvince.text =
    locationBloc.currentState.nameProvinces[indexCity + 1][_indexProvince];
    setState(() {
      indexProvice = _indexProvince - 1;
    });
  }

  _changeAddress() {
    setState(() {
      address = myControllerAddress.text;
    });
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

  _changeVerifyPasswordInput() {
    setState(() {
      verifyPasswordInput = myControllerVerifyPassword.text;
    });
  }

  _changeName() {
    setState(() {
      name = myControllerName.text;
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

  bool _checkValidUsername(String username) {
    try {
      List<int> lst = ascii.encode(username);
    } catch (err) {
      return true;
//print(err.toString());
    }
    return false;
  }

  _checkRegister() async {
    if (name.length > 5 && usernameInput.length > 5 &&
        passwordInput.length > 5 && verifyPasswordInput.length > 5 &&
        address.length > 0) {
      if (myControllerCity.text.isNotEmpty) {
        if (myControllerProvince.text.isNotEmpty) {
          if (passwordInput == verifyPasswordInput) {
            if (!_checkValidUsername(usernameInput)) {
              _showLoading();
              String tempAddress = address + ", " + myControllerProvince.text +
                  ", " + myControllerCity.text;
              int check = await registerUser(
                  usernameInput, name, passwordInput, widget.phone,
                  tempAddress);
              if (check == 1) {
                Navigator.pop(context);
                Toast.show(
                    "Đăng kí thành công!", context, gravity: Toast.CENTER);
                Navigator.pop(context);
              }
              else {
                Navigator.pop(context);
                Toast.show(
                    "Đăng kí thất bại!", context, gravity: Toast.CENTER);
              }
            }
            else {
              Toast.show("Username không thể chứa kí tự đặc biệt!", context,
                  gravity: Toast.CENTER);
            }
          }
          else {
            Toast.show("Mật khẩu không khớp!", context, gravity: Toast.CENTER);
          }
        }
        else {
          Toast.show(
              "Vui lòng chọn quận/huyện!", context, gravity: Toast.CENTER);
        }
      }
      else {
        Toast.show(
            "Vui lòng chọn tỉnh/thành phố!", context, gravity: Toast.CENTER);
      }
    }
    else {
      Toast.show(
          "Vui lòng nhập đầy đủ thông tin!", context, gravity: Toast.CENTER);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    myControllerName.dispose();
    myControllerPassword.dispose();
    myControllerUserName.dispose();
    myControllerVerifyPassword.dispose();
    myControllerAddress.dispose();
    myControllerCity.dispose();
    myControllerProvince.dispose();
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        brightness: Brightness.light,
        title: Text(
          "Thông tin cá nhân",
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black),
        ),
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        elevation: 0.5,
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            Card(
              margin: EdgeInsets.only(
                  left: 16, right: 16, top: 20),
              elevation: 5,
              child: TextField(
                inputFormatters: [
                  LengthLimitingTextInputFormatter(15)
                ],
                controller: myControllerName,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      FontAwesomeIcons.solidUser,
                      size: 20,
                      color: Colors.black26,
                    ),
                    suffixIcon: Icon(
                      Icons.check_circle,
                      color: name.length > 5
                          ? Colors.blue
                          : Colors.black26,
                    ),
                    hintText: "Họ và tên",
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
                  left: 16, right: 16, top: 20),
              elevation: 5,
              child: TextField(
                inputFormatters: [
                  LengthLimitingTextInputFormatter(15)
                ],
                controller: myControllerUserName,
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      FontAwesomeIcons.solidAddressBook,
                      color: Colors.black26,
                    ),
                    suffixIcon: Icon(
                      Icons.check_circle,
                      color: usernameInput.length > 5
                          ? Colors.blue
                          : Colors.black26,
                    ),
                    hintText: "Username",
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
                  left: 16, right: 16, top: 20),
              elevation: 5,
              child: TextField(
                controller: myControllerPassword,
                obscureText: true,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(15)
                ],
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Colors.black26,
                    ),
                    suffixIcon: Icon(
                      Icons.check_circle,
                      color: passwordInput.length > 5
                          ? Colors.blue
                          : Colors.black26,
                    ),
                    hintText: "Mật khẩu",
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
                  left: 16, right: 16, top: 20),
              elevation: 5,
              child: TextField(
                controller: myControllerVerifyPassword,
                obscureText: true,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(15)
                ],
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.verified_user,
                      color: Colors.black26,
                    ),
                    suffixIcon: Icon(
                      Icons.check_circle,
                      color: verifyPasswordInput.length > 5
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
            Card(
              margin: EdgeInsets.only(
                  left: 16, right: 16, top: 20),
              elevation: 5,
              child: TextField(
                controller: myControllerAddress,
                textCapitalization: TextCapitalization.words,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(50)
                ],
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      FontAwesomeIcons.locationArrow,
                      size: 20,
                      color: Colors.black26,
                    ),
                    suffixIcon: Icon(
                      Icons.check_circle,
                      color: address.length > 1
                          ? Colors.blue
                          : Colors.black26,
                    ),
                    hintText: "Địa chỉ",
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
            Row(
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  RegisterCityPage(_onChangeCity, indexCity)));
                    },
                    child: Card(
                      margin: EdgeInsets.only(
                          left: 16, right: 16, top: 20),
                      elevation: 5,
                      child: TextField(
                        enabled: false,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontFamily: 'Montserrat',
                            fontSize: 12
                        ),
                        controller: myControllerCity,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(100)
                        ],
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              FontAwesomeIcons.solidBuilding,
                              size: 22,
                              color: Colors.black26,
                            ),
                            suffixIcon: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black26,
                            ),
                            hintText: "Tỉnh/Thành phố",
                            hintStyle: TextStyle(
                                color: Colors.black26,
                                fontSize: 12
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(40.0)),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 16.0)),
                      ),
                    ),
                  ),
                  flex: 1,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      if (myControllerCity.text.isNotEmpty) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    RegisterProvincePage(
                                        _onChangeProvince, indexCity,
                                        indexProvice)));
                      }
                      else {
                        Toast.show("Vui lòng chọn thành phố!", context,
                            gravity: Toast.CENTER);
                      }
                    },
                    child: Card(
                      margin: EdgeInsets.only(right: 16, top: 20),
                      elevation: 5,
                      child: TextField(
                        enabled: false,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontFamily: 'Montserrat',
                            fontSize: 12
                        ),
                        controller: myControllerProvince,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(100)
                        ],
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.location_on,
                              color: Colors.black26,
                            ),
                            suffixIcon: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black26,
                            ),
                            hintText: "Quận/Huyện",
                            hintStyle: TextStyle(
                                color: Colors.black26,
                                fontSize: 12
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(40.0)),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 16.0)),
                      ),
                    ),
                  ),
                  flex: 1,
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
              child: Container(
                  height: 50,
                  child: RaisedButton(
                    color: colorActive,
                    elevation: 4.0,
                    splashColor: Colors.green,
                    onPressed: _checkRegister,
                    child: Text(
                      "Đăng kí",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  )
              ),
            )
          ],
        ),
      ),
    );
  }

}