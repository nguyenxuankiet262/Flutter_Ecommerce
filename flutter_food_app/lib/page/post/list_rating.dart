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
    final widthRating = size.width - 100;
    final height = size.height - 60;
    return Container(
      height: height,
      color: Colors.white,
      padding: EdgeInsets.only(left: 10.0, right: 10.0),
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
            margin: EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
              'ĐÁNH GIÁ',
              style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            color: colorInactive,
            height: 1,
          ),
          Container(
            height: height - 70,
            child: Scrollbar(
              child: ListView.builder(
                itemCount: itemCount,
                physics: ScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) => Container(
                    margin: EdgeInsets.symmetric(vertical: 5.0),
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
                              margin: EdgeInsets.only(left: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                      Text(
                                        '22:22 PM - 22/2/2022',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontStyle: FontStyle.italic,
                                          fontSize: 12
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                  SmoothStarRating(
                                    starCount: index % 2 == 0 ? 5 : 4,
                                    size: 18.0,
                                    rating: 5,
                                    color: Colors.yellow,
                                    borderColor: Colors.yellow,
                                  ),
                                  Text(
                                    'Ngon bổ rẻ',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        index != itemCount - 1
                            ? Container(
                                margin: EdgeInsets.symmetric(vertical: 10.0),
                                height: 1.0,
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
