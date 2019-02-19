import 'package:flutter/material.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_food_app/page/post/post.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class RelativePost extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RelativePostState();
}

class RelativePostState extends State<RelativePost> {
  int itemCount = 10;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        padding: EdgeInsets.all(15.0),
        margin: EdgeInsets.all(5.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: colorInactive,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 7.0),
              child: Text(
                'BÀI VIẾT TƯƠNG TỰ',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            StaggeredGridView.countBuilder(
              crossAxisCount: 2,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: itemCount,
              itemBuilder: (BuildContext context, int index) => new Container(
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      border: new Border.all(color: colorInactive),
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                    margin: new EdgeInsets.all(5.0),
                    child: Stack(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            GestureDetector(
                              child: ClipRRect(
                                child: Image.asset(index % 2 == 0
                                    ? 'assets/images/carrot.jpg'
                                    : 'assets/images/tomato.jpg'),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5.0),
                                    topRight: Radius.circular(5.0)),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Post()),
                                );
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
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  right: 10.0,
                                  bottom: 13.0,
                                  left: 10.0,
                                  top: 5.0),
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
                                  right: 10.0, left: 10.0, bottom: 10.0),
                              child: Container(
                                height: 1,
                                color: colorInactive,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  right: 10.0, left: 10.0, bottom: 10.0),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                        index % 2 == 0
                            ? Stack(
                                children: <Widget>[
                                  Icon(
                                    Icons.bookmark,
                                    size: 40.0,
                                    color: colorBookmark,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(12.0),
                                    child: Icon(
                                      Icons.star,
                                      size: 15.0,
                                      color: Colors.yellow,
                                    ),
                                  ),
                                ],
                              )
                            : Container(),
                      ],
                    ),
                  ),
              staggeredTileBuilder: (int index) => new StaggeredTile.fit(1),
            ),
          ],
        ));
  }
}
