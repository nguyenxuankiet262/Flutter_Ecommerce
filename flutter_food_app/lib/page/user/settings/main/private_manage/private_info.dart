import 'package:flutter/material.dart';
import 'password.dart';

class PrivateInfo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PrivateInfoState();
}

class PrivateInfoState extends State<PrivateInfo> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePassword()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Text(
          "Thay đổi mật khẩu",
          style: TextStyle(
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}
