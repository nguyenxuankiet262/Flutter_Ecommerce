import "package:flutter/material.dart";
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter_food_app/page/post/post.dart';
import 'package:flutter_food_app/page/user/info.dart';


class ListNotiUser extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ListNotiUserState();
}

class _ListNotiUserState extends State<ListNotiUser> {
  int itemCount = 5;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView.builder(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        itemCount: itemCount,
        itemBuilder: (BuildContext context, int index) => new Container(
            decoration: new BoxDecoration(
                color: index % 2 == 0 ? Colors.white : colorTransparent,
                border:
                Border(bottom: BorderSide(color: colorInactive))),
            child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Stack(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => InfoPage(true)),
                            );
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
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Post()),
                            );
                          },
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
        ),
      ),
    );
  }
}
