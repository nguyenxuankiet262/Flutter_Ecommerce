import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/api/api.dart';
import 'package:flutter_food_app/common/bloc/api_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:toast/toast.dart';

class ChangePassword extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ChangePasswordState();
}

class ChangePasswordState extends State<ChangePassword> {
  bool showOldPass = true;
  bool showNewPass = true;
  bool showNewPass2 = true;

  final myControllerOldPass = new TextEditingController();
  final myControllerNewPass = new TextEditingController();
  final myControllerNewPass2 = new TextEditingController();

  ApiBloc apiBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiBloc = BlocProvider.of<ApiBloc>(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    myControllerOldPass.dispose();
    myControllerNewPass.dispose();
    myControllerNewPass2.dispose();
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

  _checkPassword() async {
    _showLoading();
    if(myControllerOldPass.text.length > 5 && myControllerNewPass.text.length > 5 && myControllerNewPass2.text.length > 5){
      if(myControllerNewPass.text == myControllerNewPass2.text){
        int check = await changePassword(apiBloc.currentState.mainUser.id, myControllerOldPass.text, myControllerNewPass.text);
        if(check == 1){
          Navigator.pop(context);
          Toast.show("Đổi mật khẩu thành công!", context, gravity: Toast.CENTER);
          myControllerNewPass.clear();
          myControllerNewPass2.clear();
          myControllerOldPass.clear();
        }
        else if(check == 2){
          Navigator.pop(context);
          Toast.show("Mật khẩu cũ sai!", context, gravity: Toast.CENTER);
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
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        brightness: Brightness.light,
        title: new Text(
          'Thay đổi mật khẩu',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: <Widget>[
          new Center(
            child: Padding(
              padding: EdgeInsets.only(right: 16),
              child: GestureDetector(
                child: Text(
                  'LƯU',
                  textScaleFactor: 1.5,
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 10),
                ),
                onTap: _checkPassword
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(10.0),
        color: Colors.white,
        child: Column(
          children: <Widget>[
            new TextField(
              controller: myControllerOldPass,
              obscureText: showOldPass,
              inputFormatters: [
                LengthLimitingTextInputFormatter(16),
              ],
              decoration: new InputDecoration(
                  hintText: 'Mật khẩu hiện tại',
                  hintStyle: TextStyle(
                    fontFamily: "Ralway",
                    fontSize: 12,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.remove_red_eye,
                      size: 20,
                    ),
                    onPressed: () {
                      setState(() {
                        showOldPass = !showOldPass;
                      });
                    },
                  )),
              style: TextStyle(fontSize: 14, color: Colors.black),
              autofocus: false,
            ),
            new TextField(
              controller: myControllerNewPass,
              obscureText: showNewPass,
              inputFormatters: [
                LengthLimitingTextInputFormatter(16),
              ],
              decoration: new InputDecoration(
                  hintText: 'Mật khẩu mới',
                  hintStyle: TextStyle(
                    fontFamily: "Ralway",
                    fontSize: 12,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.remove_red_eye,
                      size: 20,
                    ),
                    onPressed: () {
                      setState(() {
                        showNewPass = !showNewPass;
                      });
                    },
                  )),
              style: TextStyle(fontSize: 14, color: Colors.black),
              autofocus: false,
            ),
            new TextField(
              controller: myControllerNewPass2,
              obscureText: showNewPass2,
              inputFormatters: [
                LengthLimitingTextInputFormatter(16),
              ],
              decoration: new InputDecoration(
                  hintText: 'Nhập lại mật khẩu mới',
                  hintStyle: TextStyle(
                    fontFamily: "Ralway",
                    fontSize: 12,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.remove_red_eye,
                      size: 20,
                    ),
                    onPressed: () {
                      setState(() {
                        showNewPass2 = !showNewPass2;
                      });
                    },
                  )),
              style: TextStyle(fontSize: 14, color: Colors.black),
              autofocus: false,
            ),
          ],
        ),
      ),
    );
  }
}
