import "package:flutter/material.dart";
import 'package:flutter_food_app/const/color_const.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:toast/toast.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_food_app/page/post/post.dart';

class ListBookMark extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ListBookMarkState();
}

class _ListBookMarkState extends State<ListBookMark> {
  int itemCount = 10;

  void load() {
    if(this.mounted) {
      setState(() {
        itemCount += 5;
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      child: RefreshIndicator(
        child: ListView.builder(
          physics: ScrollPhysics(),
          shrinkWrap: true,
          itemCount: itemCount,
          itemBuilder: (BuildContext context, int index) => new Container(
              decoration: new BoxDecoration(
                color: Colors.white,
                border: new Border.all(color: colorInactive),
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
              margin: new EdgeInsets.all(5.0),
              child: new Slidable(
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Post()),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: ClipRRect(
                          child: Image.asset(
                            index % 2 == 0
                                ? 'assets/images/carrot.jpg'
                                : 'assets/images/tomato.jpg',
                            fit: BoxFit.fill,
                          ),
                          borderRadius: new BorderRadius.only(
                              topLeft: Radius.circular(5.0),
                              bottomLeft: Radius.circular(5.0)),
                        ),
                        width: 130,
                        height: 100,
                      ),
                      Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding:
                              EdgeInsets.only(right: 10.0, top: 10.0, left: 10.0),
                              child: Text(
                                index % 2 == 0
                                    ? 'Cà rốt tươi ngon đây! Mại zô!'
                                    : 'Vua Cà Chua mang đên những quả cà chua tuyệt vời!',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  right: 10.0, bottom: 5.0, left: 10.0, top: 5.0),
                              child: Text(
                                index % 2 == 0
                                    ? '123A Đường Lên Đỉnh Olympia, F15, Q.TB, TP.HCM'
                                    : '12/2 Con Đường Tơ Lụa, F15, Q.TB, TP.HCM',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(color: colorText),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                right: 10.0,
                                left: 10.0,
                              ),
                              child: Row(
                                children: <Widget>[
                                  ClipOval(
                                    child: Image.asset(
                                      index % 2 == 0
                                          ? 'assets/images/cat.jpg'
                                          : 'assets/images/dog.jpg',
                                      fit: BoxFit.cover,
                                      width: 40.0,
                                      height: 40.0,
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(left: 5.0),
                                        child: Text(
                                          index % 2 == 0
                                              ? 'Trần Văn Mèo'
                                              : 'Lò Thị Chó',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: colorActive,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 5.0),
                                        child: SmoothStarRating(
                                          starCount: 5,
                                          size: 15.0,
                                          rating: index % 2 == 0 ? 5 : 3,
                                          color: Colors.yellow,
                                          borderColor: Colors.yellow,
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
                ),
                delegate: new SlidableDrawerDelegate(),
                actionExtentRatio: 0.25,
                secondaryActions: <Widget>[
                  new IconSlideAction(
                    caption: 'Share',
                    color: Colors.blue,
                    icon: Icons.more_horiz,
                    onTap: () => Toast.show('Share', context),
                  ),
                  ClipRRect(
                    child: new IconSlideAction(
                        caption: 'Delete',
                        color: Colors.red,
                        icon: Icons.delete,
                        onTap: () {
                          setState(() {
                            Toast.show('Delete', context);
                            itemCount--;
                          });
                        }
                    ),
                    borderRadius: new BorderRadius.only(
                        topRight: Radius.circular(5.0),
                        bottomRight: Radius.circular(5.0)),
                  ),
                ],
              )),
        ),
        onRefresh: _refresh,
      ),
    );
  }

  Future<bool> _loadMore() async {
    await Future.delayed(Duration(seconds: 0, milliseconds: 1000));
    load();
    return true;
  }

  Future<void> _refresh() async {
    await Future.delayed(Duration(seconds: 0, milliseconds: 1000));
    setState(() {
      itemCount = 5;
    });
  }
}
