import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/common/bloc/user_bloc.dart';
import 'package:flutter_food_app/common/state/user_state.dart';
import 'package:flutter_food_app/page/authentication/login/signin.dart';
import 'noti_user_item.dart';

class NotiUser extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NotiUserState();
}

class NotiUserState extends State<NotiUser> with AutomaticKeepAliveClientMixin {
  int _count = 1;
  UserBloc userBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userBloc = BlocProvider.of<UserBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder(
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
                      child: ListNotiUser(),
                      color: Colors.white,
                    );
        });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
