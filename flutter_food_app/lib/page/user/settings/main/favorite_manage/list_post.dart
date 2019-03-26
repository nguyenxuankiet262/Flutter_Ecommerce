import "package:flutter/material.dart";
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_food_app/page/post/post.dart';
import 'package:toast/toast.dart';

class ListPost extends StatefulWidget {
  int index;

  ListPost(this.index);

  @override
  State<StatefulWidget> createState() => _ListPostState();
}

class _ListPostState extends State<ListPost>
    with AutomaticKeepAliveClientMixin {
  int itemCount;
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        isLoading = false;
      });
    });
    if (widget.index == 0 || widget.index == 2 || widget.index == 3) {
      itemCount = 10;
    } else if (widget.index == 1) {
      itemCount = 2;
    } else {
      itemCount = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return isLoading
        ? Container(
        height: MediaQuery.of(context).size.height / 2,
        color: colorBackground,
        child: Center(
            child: CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(colorActive),
            )))
        : Container(
        color: colorBackground,
        child: itemCount == 0
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(
                      "assets/images/icon_heartbreak.png"),
                ),
              ),
              height: 200,
              width: 200,
            ),
            GestureDetector(
              onTap: () {
                setState(() {});
              },
              child: Text('Chưa có bài viết!'),
            ),
          ],
        )
            : StaggeredGridView.countBuilder(
            padding: EdgeInsets.only(top: 0),
            crossAxisCount: 2,
            physics: ScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: itemCount,
            itemBuilder: (BuildContext context, int index) => new Card(
                child: new Container(
                  child: Stack(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          GestureDetector(
                            child: Container(
                              height: 170,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(index % 2 == 0
                                        ? 'assets/images/carrot.jpg'
                                        : 'assets/images/tomato.jpg'),
                                  ),
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(5.0),
                                      topLeft: Radius.circular(5.0))),
                            ),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Post()));
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                right: 10.0, top: 10.0, left: 10.0),
                            child: Text(
                              index % 2 == 0
                                  ? 'Cà rốt tươi ngon đây! Mại zô!'
                                  : 'Vua Cà Chua mang đên những quả cà chua tuyệt vời!',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                right: 10.0,
                                bottom: 6.0,
                                left: 10.0,
                                top: 5.0),
                            child: Text(
                              index % 2 == 0
                                  ? '123A Đường Lên Đỉnh Olympia, F15, Q.TB, TP.HCM'
                                  : '12/2 Con Đường Tơ Lụa, F15, Q.TB, TP.HCM',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: colorText, fontSize: 12),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                right: 10.0, left: 10.0, bottom: 10.0),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  index % 2 == 0
                                      ? '40.000 VNĐ'
                                      : '150.000 VNĐ',
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      color: colorActive,
                                      fontWeight: FontWeight.w600),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 2.0),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        index % 2 == 0
                                            ? '50.000 VNĐ'
                                            : '300.000 VNĐ',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: colorInactive,
                                          fontWeight: FontWeight.w600,
                                          decoration: TextDecoration
                                              .lineThrough,
                                        ),
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.favorite,
                                            color: colorInactive,
                                            size: 15,
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                                left: 2.0),
                                            child: Text(
                                              '100',
                                              style: TextStyle(
                                                  color: colorInactive,
                                                  fontSize: 12),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              Toast.show("Đã xóa", context);
                            },
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.5),
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(5.0),
                                      topLeft: Radius.circular(5.0))),
                              child: Center(
                                  child: Icon(
                                    FontAwesomeIcons.times,
                                    size: 14,
                                    color: Colors.white,
                                  )),
                            ),
                          ),
                          Stack(
                            children: <Widget>[
                              Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      color: Colors.orangeAccent
                                          .withOpacity(0.95),
                                      borderRadius: BorderRadius.only(
                                          topRight:
                                          Radius.circular(5.0),
                                          topLeft:
                                          Radius.circular(5.0))),
                                  child: Center(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Text(
                                          index % 2 == 0
                                              ? '20%'
                                              : '50%',
                                          style: TextStyle(
                                              color: Colors.yellow,
                                              fontWeight:
                                              FontWeight.w600,
                                              fontSize: 14.0),
                                        ),
                                        Text(
                                          'GIẢM',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight:
                                              FontWeight.w800,
                                              fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  )),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                )),
            staggeredTileBuilder: (int index) =>
            new StaggeredTile.fit(1)));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
