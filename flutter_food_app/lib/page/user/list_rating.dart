import 'package:flutter/material.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:flutter_food_app/page/user/info.dart';

class ListRating extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ListRatingState();
}

class ListRatingState extends State<ListRating> {
  int itemCount = 10;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final widthRating = size.width - 80;
    return ListView.builder(
      itemCount: itemCount,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) => Card(
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            height: 75,
            color: Colors.white,
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => InfoPage(true)),
                        );
                      },
                    ),
                    Container(
                      width: widthRating,
                      margin: EdgeInsets.only(left: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                index % 2 == 0
                                    ? 'Trần Văn Mèo'
                                    : 'Nguyễn Thị Cún',
                                style: TextStyle(
                                    color: colorActive,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '22:22 PM - 22/2/2022',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontStyle: FontStyle.italic,
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
              ],
            )
        ),
      )
    );
  }
}
