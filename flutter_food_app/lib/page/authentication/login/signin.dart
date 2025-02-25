import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/common/bloc/function_bloc.dart';
import 'package:flutter_food_app/const/color_const.dart';

class SigninContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: colorBackground,
      child: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height / 7),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Image.asset("assets/images/logo.png"),
                ),
                Container(
                  width: 150,
                  height: 40,
                  child: RaisedButton(
                    onPressed: () {
                      BlocProvider.of<FunctionBloc>(context).currentState.navigateToAuthen();
                    },
                    child: Text(
                      "ĐĂNG NHẬP",
                      style: TextStyle(
                          fontFamily: "Ralway",
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                    color: colorActive,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(6.0))),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 16.0),
                  child: Text(
                    "Chúng tôi sẽ không sử dụng thông tin của bạn",
                    style: TextStyle(
                      color: colorInactive,
                      fontSize: 12,
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    "với mục đích nào khác",
                    style: TextStyle(
                      color: colorInactive,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      )
    );
  }
}
