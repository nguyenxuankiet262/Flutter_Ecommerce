import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/common/bloc/bottom_bar_bloc.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'info.dart';
import 'private_info.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PrivateManage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PrivateManageState();
}

class PrivateManageState extends State<PrivateManage> {
  double heightContainer = 300;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<BottomBarBloc>(context)
        .changeVisible(true);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          elevation: 0.5,
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
            IconButton(
              onPressed: (){

              },
              icon: Icon(
                Icons.done,
                color: colorActive,
              ),
            )
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
                            Positioned(
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 60,
                                color: Colors.white,
                              ),
                              bottom: 0.0,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  height: heightContainer + 60,
                                  width: MediaQuery.of(context).size.width,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.end,
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
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border:
                                                      Border.all(width: 0.5),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              100.0))),
                                              child: ClipOval(
                                                child: Image.asset(
                                                  'assets/images/cat.jpg',
                                                  fit: BoxFit.cover,
                                                  width: 150.0,
                                                  height: 150.0,
                                                ),
                                              ),
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Positioned(
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    color: colorContainer,
                                    border: Border.all(
                                        color: Colors.white, width: 2.0),
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(100.0))),
                                child: Icon(
                                  FontAwesomeIcons.camera,
                                  size: 17,
                                ),
                              ),
                              bottom: 2.0,
                              left: MediaQuery.of(context).size.width / 1.7,
                            ),
                            Positioned(
                              child: Container(
                                height: 35,
                                width: 40,
                                decoration: BoxDecoration(
                                    color: colorContainer,
                                    border: Border.all(
                                        color: Colors.white, width: 1.0),
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(5.0))),
                                child: Icon(
                                  FontAwesomeIcons.camera,
                                  size: 20,
                                ),
                              ),
                              right: 16.0,
                              bottom: 76,
                            )
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
