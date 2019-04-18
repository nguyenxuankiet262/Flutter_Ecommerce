import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/common/bloc/function_bloc.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:toast/toast.dart';

class ListRating extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ListRatingState();
}

class ListRatingState extends State<ListRating> {
  int itemCount = 10;

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Cảnh Báo!"),
          content: new Text("Bạn có chắc muốn ẩn đánh giá này không?"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Không"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text(
                "Có",
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Toast.show('Đã xóa', context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final widthRating = size.width - 96;
    return ListView.builder(
      itemCount: itemCount,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) => Card(
        child: Container(
            padding: EdgeInsets.all(16.0),
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
                        BlocProvider.of<FunctionBloc>(context).currentState.navigateToUser();
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
                              Text(
                                index % 2 == 0
                                    ? 'Trần Văn Mèo'
                                    : 'Nguyễn Thị Cún',
                                style: TextStyle(
                                  color: colorActive,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  _showDialog();
                                },
                                child: Container(
                                  width: 50,
                                  color: Colors.white,
                                  child: Icon(
                                    FontAwesomeIcons
                                        .solidEyeSlash,
                                    size: 12,
                                    color: colorInactive,
                                  ),
                                )
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
              ],
            )
        ),
      )
    );
  }
}
