import 'package:flutter/material.dart';
import 'main/order_manage/order_manage.dart';
import 'main/post_manage/post_manage.dart';
import 'main/favorite_manage/favorite_manage.dart';
import 'main/private_manage/private_manage.dart';

List<String> settingPost = ["Quản lý bài viết", "Bài viết yêu thích"];

List<String> settingPrivacy = [
  "Chỉnh sửa trang cá nhân",
  "Quản lý đơn hàng",
  "Quản lý đánh giá"
];

List<String> settingSupport = ["Quản lý phản hồi"];

class SettingsMain extends StatelessWidget {
  Function sign_out;
  SettingsMain(this.sign_out);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        color: Colors.white,
        height: 460,
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(15.0),
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: Colors.grey, width: 0.2))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'BÀI VIẾT',
                    style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                  Container(
                    child: ListView.builder(
                      itemCount: settingPost.length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) =>
                          GestureDetector(
                            child: Container(
                              margin: EdgeInsets.only(top: 20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    settingPost[index],
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_right,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              Navigator.pop(context);
                              switch (index) {
                                case 0:
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => PostManage()));
                                  break;
                                case 1:
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => FavoriteManage()));
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
              padding: EdgeInsets.all(15.0),
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: Colors.grey, width: 0.2))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'RIÊNG TƯ',
                    style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                  Container(
                    child: ListView.builder(
                      itemCount: settingPrivacy.length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) =>
                          GestureDetector(
                            child: Container(
                              margin: EdgeInsets.only(top: 20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    settingPrivacy[index],
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                  Row(
                                    children: <Widget>[
                                      index == 1
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
                                                '2',
                                                style: new TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            )
                                          : Container(),
                                      Icon(
                                        Icons.keyboard_arrow_right,
                                        color: Colors.grey,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              Navigator.pop(context);
                              switch (index) {
                                case 0:
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => PrivateManage()));
                                  break;
                                case 1:
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => OrderManage()));
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
              padding: EdgeInsets.all(15.0),
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: Colors.grey, width: 0.2))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'HỖ TRỢ',
                    style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                  Container(
                    child: ListView.builder(
                      itemCount: settingSupport.length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) =>
                          GestureDetector(
                            child: Container(
                              margin: EdgeInsets.only(top: 20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    settingSupport[index],
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_right,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              switch (index) {
                                case 0:
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
              onTap: (){
                Navigator.pop(context);
                sign_out();
              },
              child: Container(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  'ĐĂNG XUẤT',
                  style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ));
  }
}
