import 'package:flutter/material.dart';
import 'package:flutter_food_app/const/color_const.dart';

List<String> settingPost = ["Bài viết chờ duyệt", "Bài viết bị hủy"];

List<String> settingPrivacy = ["Danh sách chặn"];

List<String> settingSupport = ["Gửi phản hồi"];

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        color: Colors.white,
        height: 390,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(top: 10.0),
                child: Center(
                  child: Container(
                    width: 50,
                    height: 2,
                    color: colorInactive,
                  ),
                )),
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
                        fontSize: 16.0,
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
                                      fontSize: 18,
                                    ),
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_right,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                            ),
                            onTap: (){
                              switch(index){
                                case 0: {

                                }
                                break;
                                case 1: {

                                }
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
                        fontSize: 16.0,
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
                                      fontSize: 18,
                                    ),
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_right,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                            ),
                            onTap: (){
                              switch(index){
                                case 0: {

                                }
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
                        fontSize: 16.0,
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
                                      fontSize: 18,
                                    ),
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_right,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                            ),
                            onTap: (){
                              switch(index){
                                case 0: {

                                }
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
              child: Text(
                'ĐĂNG XUẤT',
                style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ));
  }
}
