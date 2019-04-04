import 'package:flutter/material.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:flutter_food_app/page/user/info.dart';

class ListRating extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ListRatingState();
}

class ListRatingState extends State<ListRating> {
  int itemCount = 30;

  void navigateToUserPage(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => InfoPage(true)));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final widthRating = size.width - 90;
    final height = size.height - 60;
    return Container(
      height: height,
      color: Colors.white,
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
            )
          ),
          Container(
            margin: EdgeInsets.only(top: 10.0, bottom: 16.0, left: 16.0),
            child: Text(
              'ĐÁNH GIÁ',
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            height: height - 60,
            child: Scrollbar(
              child: ListView.builder(
                itemCount: itemCount,
                physics: ScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) => Container(
                    margin: EdgeInsets.only(bottom: 16.0, left: 16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            GestureDetector(
                              child: ClipOval(
                                child: Image.asset(
                                  index % 2 == 0
                                      ? 'assets/images/cat.jpg'
                                      : 'assets/images/dog.jpg',
                                  fit: BoxFit.cover,
                                  width: 40.0,
                                  height: 40.0,
                                ),
                              ),
                              onTap: () {
                                navigateToUserPage();
                              },
                            ),
                            Container(
                              width: widthRating,
                              margin: EdgeInsets.only(left: 16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .spaceBetween,
                                    children: <Widget>[
                                      GestureDetector(
                                        child: Text(
                                          index % 2 == 0
                                              ? 'Trần Văn Mèo'
                                              : 'Nguyễn Thị Cún',
                                          style: TextStyle(
                                              color: colorActive,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12
                                          ),
                                        ),
                                        onTap: (){
                                          navigateToUserPage();
                                        },
                                      ),
                                      GestureDetector(
                                        onTap: () {},
                                        child: Icon(
                                          Icons.more_vert,
                                          color: colorInactive,
                                          size: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 4.0),
                                    child: SmoothStarRating(
                                      starCount: index % 2 == 0 ? 5 : 4,
                                      size: 16.0,
                                      rating: 5,
                                      color: Colors.yellow,
                                      borderColor: Colors.yellow,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: Text(
                                      index % 2 == 0
                                          ? 'Ngon bổ rẻ'
                                          : "Likeeeeeeeeeee!!!!!!!!!!!!!!!!!!! Ủng hộ shop !! Yêu shop !!!!!!!!!!",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12),
                                    ),
                                  ),
                                  Text(
                                    '22:22 PM - 22/2/2022',
                                    style: TextStyle(
                                        color: colorInactive,
                                        fontStyle: FontStyle.italic,
                                        fontSize: 10),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        index != itemCount - 1
                            ? Container(
                                margin: EdgeInsets.only(top: 16.0, right: 16.0),
                                height: 0.5,
                                width: double.infinity,
                                color: colorInactive,
                              )
                            : Container(),
                      ],
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
