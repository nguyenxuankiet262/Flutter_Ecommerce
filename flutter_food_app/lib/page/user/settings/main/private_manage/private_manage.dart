import 'package:flutter/material.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'info.dart';
import 'private_info.dart';

class PrivateManage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PrivateManageState();
}

class PrivateManageState extends State<PrivateManage> {
  double heightContainer = 200;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          brightness: Brightness.light,
          title: new Text(
            'Chỉnh sửa trang cá nhân',
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
                    'XONG',
                    textScaleFactor: 1.5,
                    style: TextStyle(
                        color: colorActive,
                        fontWeight: FontWeight.bold,
                        fontSize: 10),
                  ),
                  onTap: () {},
                ),
              ),
            ),
          ],
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Container(
              color: Colors.white,
              child: Stack(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: heightContainer,
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/images/cat.jpg'),
                      ),
                    ),
                  ),
                  ListView(
                    children: <Widget>[
                      Container(
                        child: Stack(
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: heightContainer,
                              color: Colors.transparent.withOpacity(0.7),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  height: heightContainer,
                                  width: MediaQuery.of(context).size.width,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: () {},
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.white,
                                                  width: 2.0),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(100.0))),
                                          child: ClipOval(
                                            child: Image.asset(
                                              'assets/images/cat.jpg',
                                              fit: BoxFit.cover,
                                              width: 100.0,
                                              height: 100.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 10.0),
                                        child: GestureDetector(
                                          onTap: () {},
                                          child: Text(
                                            "Thay đổi ảnh đại diện",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 40,
                        color: Colors.white,
                        child: Container(
                            height: 40,
                            margin: EdgeInsets.symmetric(vertical: 15.0),
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            color: Colors.white,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "THÔNG TIN RIÊNG TƯ",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                      ),
                      Container(
                        color: Colors.white,
                        child: PrivateInfo(),
                      ),
                      Container(
                        height: 40,
                        color: Colors.white,
                        child: Container(
                            height: 40,
                            margin: EdgeInsets.symmetric(vertical: 15.0),
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            color: Colors.white,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "THÔNG TIN CHUNG",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                      ),
                      Container(
                        color: Colors.white,
                        child: Info(),
                      ),
                    ],
                  ),
                ],
              )),
        ));
  }
}
