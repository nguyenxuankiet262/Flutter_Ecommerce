import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/common/bloc/bottom_bar_bloc.dart';
import 'package:flutter_food_app/common/bloc/user_bloc.dart';
import 'main/order_manage/order_manage.dart';
import 'main/post_manage/post_manage.dart';
import 'main/favorite_manage/favorite_manage.dart';
import 'main/private_manage/private_manage.dart';
import 'main/rating_manage/rating_manage.dart';
import 'main/feedback_manage/feedback_manage.dart';

List<String> settingPost = ["Quản lý bài viết", "Bài viết yêu thích"];

List<String> settingPrivacy = [
  "Chỉnh sửa trang cá nhân",
  "Đơn hàng mua",
  "Đơn hàng bán",
  "Đánh giá"
];

List<String> settingSupport = ["Phản hồi"];

class SettingsMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(right: 16.0, left: 16.0, bottom: 24, top: 16),
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
                              margin: EdgeInsets.only(top: index == 0 ? 16 : 24.0),
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
                              Navigator.pop(context);
                              switch (index) {
                                case 0:
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => PostManage()));
                                  break;
                                case 1:
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              FavoriteManage()));
                                  break;
                              }
                            },
                          ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(right: 16.0, left: 16.0, bottom: 24, top: 24),
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
                      itemBuilder: (BuildContext context, int index) =>
                          GestureDetector(
                            child: Container(
                              color: Colors.white,
                              margin: EdgeInsets.only(top: index == 0 ? 16 : 24.0),
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
                                      index == 1 || index == 2
                                          ? Container(
                                              padding: EdgeInsets.all(1),
                                              decoration: new BoxDecoration(
                                                color: Colors.red,
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              constraints: BoxConstraints(
                                                minWidth: 18,
                                                minHeight: 18,
                                              ),
                                              child: new Text(
                                                index == 1 ? '2' : '10',
                                                style: new TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            )
                                          : Container(),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              Navigator.pop(context);
                              switch (index) {
                                case 0:
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
                                case 3:
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RatingManage()));
                                  break;
                              }
                            },
                          ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(right: 16.0, left: 16.0, bottom: 24, top: 24),
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
                            },
                          ),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                BlocProvider.of<UserBloc>(context).logout();
                BlocProvider.of<BottomBarBloc>(context)
                    .changeVisible(true);
                Navigator.pop(context);
              },
              child: Container(
                  padding: EdgeInsets.only(right: 16.0, left: 16.0, bottom: 24, top: 24),
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
  }
}
