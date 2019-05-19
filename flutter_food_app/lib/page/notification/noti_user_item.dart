import "package:flutter/material.dart";
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/common/bloc/function_bloc.dart';
import 'package:flutter_food_app/const/color_const.dart';

class ListNotiUser extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ListNotiUserState();
}

class _ListNotiUserState extends State<ListNotiUser> {
  int itemCount = 3;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: itemCount == 0
          ? Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height - 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    const IconData(0xe900, fontFamily: 'box'),
                    size: 150,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 16.0),
                    child: Text(
                      "Không có thông báo nào",
                      style: TextStyle(
                        color: colorInactive,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      "Chúc bạn một ngày vui vẻ!",
                      style: TextStyle(
                        color: colorInactive,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: itemCount,
              itemBuilder: (BuildContext context, int index) => new Container(
                    decoration: new BoxDecoration(
                        color: index % 2 == 0
                            ? Colors.white
                            : colorActive.withOpacity(0.1),
                        border: Border(
                            bottom:
                                BorderSide(color: colorInactive, width: 0.5))),
                    child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Stack(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    BlocProvider.of<FunctionBloc>(context)
                                        .currentState
                                        .navigateToUser();
                                  },
                                  child: ClipOval(
                                    child: Image.asset(
                                      index % 2 == 0
                                          ? 'assets/images/cat.jpg'
                                          : 'assets/images/dog.jpg',
                                      fit: BoxFit.cover,
                                      width: 50.0,
                                      height: 50.0,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: Padding(
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
                                      text: index % 2 == 0
                                          ? 'Trần Văn Mèo'
                                          : 'Lò Thị Chó',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                        fontSize: 13,
                                      ), // default t// ext style
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: ' đã đăng trong nhóm ',
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 12.0)),
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
                  ),
            ),
    );
  }
}
