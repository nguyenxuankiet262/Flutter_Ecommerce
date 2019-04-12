import "package:flutter/material.dart";
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/common/bloc/bottom_bar_bloc.dart';
import 'package:flutter_food_app/const/color_const.dart';

class ListNotiAdmin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ListNotiAdminState();
}

class _ListNotiAdminState extends State<ListNotiAdmin> {
  int itemCount = 10;
  ScrollController _hideButtonController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _hideButtonController = new ScrollController();
    _hideButtonController.addListener(() {
      if (_hideButtonController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        BlocProvider.of<BottomBarBloc>(context)
            .changeVisible(false);
      }
      if (_hideButtonController.position.userScrollDirection ==
          ScrollDirection.forward) {
        BlocProvider.of<BottomBarBloc>(context)
            .changeVisible(true);
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _hideButtonController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView.builder(
        controller: _hideButtonController,
        itemCount: itemCount,
        itemBuilder: (BuildContext context, int index) => new Container(
          decoration: new BoxDecoration(
              color: index % 2 ==0 ? Colors.white : colorActive.withOpacity(0.1),
              border:
              Border(bottom: BorderSide(color: colorInactive, width: 0.5))),
          child: GestureDetector(
            child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Stack(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        ClipOval(
                          child: Image.asset(
                            "assets/images/logo.png",
                            fit: BoxFit.cover,
                            width: 50.0,
                            height: 50.0,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 5.0),
                          child: Container(
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage(
                                    "assets/images/carrot.jpg"),
                              ),
                            ),
                            height: 50,
                            width: 70,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 60.0,
                        right: 75,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text.rich(
                            TextSpan(
                              text: "Hệ thống",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                                fontSize: 13,
                              ), // default t// ext style
                              children: <TextSpan>[
                                TextSpan(
                                    text: index % 2 ==0
                                        ?' đã hủy bài viết của bạn trong nhóm '
                                        :' đã duyệt bài viết của bạn trong nhóm '
                                    ,
                                    style: TextStyle(
                                        color: Colors.black54)),
                                TextSpan(
                                    text: index % 2 == 0
                                        ? 'Rau Củ'
                                        : 'Thịt',
                                    style: TextStyle(
                                        color: colorActive,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          Row(
                            children: <Widget>[
                              Text('1 giờ'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
            onTap: (){
            },
          ),
        ),
      ),
    );
  }
}
