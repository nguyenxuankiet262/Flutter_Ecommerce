import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/common/bloc/api_bloc.dart';
import 'package:flutter_food_app/common/bloc/bottom_bar_bloc.dart';
import 'package:flutter_food_app/common/bloc/info_bloc.dart';
import 'package:flutter_food_app/common/bloc/user_bloc.dart';
import 'package:flutter_food_app/common/state/api_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'main/order_manage/order_manage.dart';
import 'main/post_manage/post_manage.dart';
import 'main/favorite_manage/favorite_manage.dart';
import 'main/private_manage/private_manage.dart';
import 'main/feedback_manage/feedback_manage.dart';

List<String> settingPost = ["Quản lý bài viết", "Bài viết yêu thích"];

List<String> settingPrivacy = [
  "Chỉnh sửa trang cá nhân",
  "Đơn hàng mua",
  "Đơn hàng bán",
];

List<String> settingSupport = ["Phản hồi"];

class SettingsMain extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SettingsMainState();
}

class SettingsMainState extends State<SettingsMain> {
  ApiBloc apiBloc;
  InfoBloc infoBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiBloc = BlocProvider.of<ApiBloc>(context);
    infoBloc = BlocProvider.of<InfoBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder(
      bloc: apiBloc,
      builder: (context, ApiState state) {
        return Container(
            color: Colors.white,
            child: ListView(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(
                      right: 16.0, left: 16.0, bottom: 24, top: 16),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Colors.grey, width: 0.2))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(right: 8.0),
                            child: Icon(
                              Icons.edit,
                              size: 20,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 3.0),
                            child: Text(
                              'BÀI VIẾT',
                              style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                            ),
                          )
                        ],
                      ),
                      Container(
                        child: ListView.builder(
                          itemCount: settingPost.length,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) =>
                              GestureDetector(
                                child: Container(
                                  color: Colors.white,
                                  margin: EdgeInsets.only(
                                      top: index == 0 ? 16 : 24.0),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        settingPost[index],
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  if (state.mainUser != null &&
                                      state.listMenu != null) {
                                    Navigator.pop(context);
                                    switch (index) {
                                      case 0:
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    PostManage()));
                                        break;
                                      case 1:
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    FavoriteManage()));
                                        break;
                                    }
                                  } else {
                                    Toast.show(
                                        "Không thể tải dữ liệu người dùng!",
                                        context,
                                        gravity: Toast.CENTER);
                                  }
                                },
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                      right: 16.0, left: 16.0, bottom: 24, top: 24),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Colors.grey, width: 0.2))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(right: 8.0),
                            child: Icon(
                              Icons.person,
                              size: 20,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 3.0),
                            child: Text(
                              'RIÊNG TƯ',
                              style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                            ),
                          )
                        ],
                      ),
                      Container(
                        child: ListView.builder(
                          itemCount: settingPrivacy.length,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder:
                              (BuildContext context, int index) =>
                                  GestureDetector(
                                    child: Container(
                                      color: Colors.white,
                                      margin: EdgeInsets.only(
                                          top: index == 0 ? 16 : 24.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            settingPrivacy[index],
                                            style: TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                          Row(
                                            children: <Widget>[
                                              state.mainUser != null
                                                  ? index == 1
                                                      ? state.mainUser.badge ==
                                                              null
                                                          ? Container()
                                                          : state.mainUser.badge
                                                                      .buy ==
                                                                  0
                                                              ? Container()
                                                              : Container(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              1),
                                                                  decoration:
                                                                      new BoxDecoration(
                                                                    color: Colors
                                                                        .red,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            12),
                                                                  ),
                                                                  constraints:
                                                                      BoxConstraints(
                                                                    minWidth:
                                                                        18,
                                                                    minHeight:
                                                                        18,
                                                                  ),
                                                                  child: Center(
                                                                    child:
                                                                        new Text(
                                                                      state.mainUser.badge.buy >
                                                                              20
                                                                          ? " 20+ "
                                                                          : state
                                                                              .mainUser
                                                                              .badge
                                                                              .buy
                                                                              .toString(),
                                                                      style: new TextStyle(
                                                                          color: Colors
                                                                              .white,
                                                                          fontSize:
                                                                              9,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                    ),
                                                                  ))
                                                      : index == 2
                                                          ? state.mainUser
                                                                      .badge ==
                                                                  null
                                                              ? Container()
                                                              : state.mainUser.badge
                                                                          .buy ==
                                                                      0
                                                                  ? Container()
                                                                  : Container(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              1),
                                                                      decoration:
                                                                          new BoxDecoration(
                                                                        color: Colors
                                                                            .red,
                                                                        borderRadius:
                                                                            BorderRadius.circular(12),
                                                                      ),
                                                                      constraints:
                                                                          BoxConstraints(
                                                                        minWidth:
                                                                            18,
                                                                        minHeight:
                                                                            18,
                                                                      ),
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            new Text(
                                                                          state.mainUser.badge.sell > 20
                                                                              ? " 20+ "
                                                                              : state.mainUser.badge.sell.toString(),
                                                                          style: new TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: 9,
                                                                              fontWeight: FontWeight.bold),
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                        ),
                                                                      ))
                                                          : Container()
                                                  : Container()
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      if (state.mainUser != null) {
                                        Navigator.pop(context);
                                        switch (index) {
                                          case 0:
                                            infoBloc.changeInfo(
                                                apiBloc.currentState.mainUser.username,
                                                apiBloc.currentState.mainUser.phone,
                                                apiBloc.currentState.mainUser.address,
                                                apiBloc.currentState.mainUser.name,
                                                apiBloc.currentState.mainUser.intro,
                                                apiBloc.currentState.mainUser.link);
                                            infoBloc.changeAvatar(apiBloc.currentState.mainUser.avatar);
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        PrivateManage()));
                                            break;
                                          case 1:
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        OrderManage(false)));
                                            break;
                                          case 2:
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        OrderManage(true)));
                                            break;
                                        }
                                      } else {
                                        Toast.show(
                                            "Không thể tải dữ liệu người dùng!",
                                            context,
                                            gravity: Toast.CENTER);
                                      }
                                    },
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                      right: 16.0, left: 16.0, bottom: 24, top: 24),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Colors.grey, width: 0.2))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(right: 8.0),
                            child: Icon(
                              Icons.help,
                              size: 20,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 3.0),
                            child: Text(
                              'HỖ TRỢ',
                              style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                            ),
                          )
                        ],
                      ),
                      Container(
                        child: ListView.builder(
                          itemCount: settingSupport.length,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) =>
                              GestureDetector(
                                child: Container(
                                  color: Colors.white,
                                  margin: EdgeInsets.only(top: 16.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        settingSupport[index],
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  if (state.mainUser != null) {
                                    Navigator.pop(context);
                                    switch (index) {
                                      case 0:
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    FeedBackManage()));
                                        break;
                                    }
                                  } else {
                                    Toast.show(
                                        "Không thể tải dữ liệu người dùng!",
                                        context,
                                        gravity: Toast.CENTER);
                                  }
                                },
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    if (state.mainUser != null) {
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      prefs.remove('token');
                      BlocProvider.of<UserBloc>(context).logout();
                      BlocProvider.of<BottomBarBloc>(context)
                          .changeVisible(true);
                      //await updateToken(state.mainUser.id, "");
                      BlocProvider.of<ApiBloc>(context).changeMainUser(null);
                      BlocProvider.of<ApiBloc>(context).changeCart(null);
                      Navigator.pop(context);
                    } else {
                      Toast.show("Không thể tải dữ liệu người dùng!", context,
                          gravity: Toast.CENTER);
                    }
                  },
                  child: Container(
                      color: Colors.white,
                      padding: EdgeInsets.only(
                          right: 16.0, left: 16.0, bottom: 24, top: 24),
                      child: Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(right: 8.0),
                            child: Icon(
                              Icons.power_settings_new,
                              size: 20,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 3.0),
                            child: Text(
                              'ĐĂNG XUẤT',
                              style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                            ),
                          )
                        ],
                      )),
                ),
              ],
            ));
      },
    );
  }
}
