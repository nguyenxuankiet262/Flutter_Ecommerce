import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/common/bloc/user_bloc.dart';
import 'package:flutter_food_app/common/state/user_state.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter_food_app/page/authentication/login/signin.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'noti_admin_item.dart';

class NotiAdmin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NotiAdminState();
}

class NotiAdminState extends State<NotiAdmin>
    with AutomaticKeepAliveClientMixin {
  int _count = 1;
  UserBloc userBloc;
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(milliseconds: 2000), () {
      setState(() {
        isLoading = false;
      });
    });
    userBloc = BlocProvider.of<UserBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return isLoading
        ? SpinKitRotatingCircle(
            color: colorActive,
            size: 50.0,
          )
        : BlocBuilder(
            bloc: userBloc,
            builder: (context, UserState state) {
              return !state.isLogin
                  ? SigninContent()
                  : _count == 0
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage(
                                      "assets/images/icon_notification.png"),
                                ),
                              ),
                              height: 200,
                              width: 200,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {});
                              },
                              child: Text('Nothing to show!'),
                            ),
                          ],
                        )
                      : Container(
                          color: Colors.white,
                          child: ListNotiAdmin(),
                        );
            },
          );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
