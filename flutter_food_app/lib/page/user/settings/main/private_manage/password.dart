import 'package:flutter/material.dart';
import 'package:flutter_food_app/const/color_const.dart';

class ChangePassword extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => ChangePasswordState();
}

class ChangePasswordState extends State<ChangePassword>{
  bool showOldPass = true;
  bool showNewPass = true;
  bool showNewPass2 = true;
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
              padding: EdgeInsets.only(right: 10),
              child: GestureDetector(
                child: Text(
                  'LƯU',
                  textScaleFactor: 1.5,
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 10),
                ),
                onTap: () {},
              ),
            ),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        color: Colors.white,
        child: Column(
          children: <Widget>[
            new TextField(
              obscureText: showOldPass,
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
                  onPressed: (){
                    setState(() {
                      showOldPass = !showOldPass;
                    });
                  },
                )
              ),
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.black
              ),
              autofocus: false,
            ),
            new TextField(
              obscureText: showNewPass,
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
                    onPressed: (){
                      setState(() {
                        showNewPass = !showNewPass;
                      });
                    },
                  )
              ),
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.black
              ),
              autofocus: false,
            ),
            new TextField(
              obscureText: showNewPass2,
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
                    onPressed: (){
                      setState(() {
                        showNewPass2 = !showNewPass2;
                      });
                    },
                  )
              ),
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.black
              ),
              autofocus: false,
            ),
          ],
        ),
      ),
    );
  }

}