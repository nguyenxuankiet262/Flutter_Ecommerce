import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/common/bloc/another_user_bloc.dart';
import 'package:flutter_food_app/common/bloc/function_bloc.dart';
import 'package:flutter_food_app/common/helper/helper.dart';
import 'package:flutter_food_app/common/state/another_user_state.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:toast/toast.dart';

class ListRating extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ListRatingState();
}

class ListRatingState extends State<ListRating> {
  AnotherUserBloc anotherUserBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    anotherUserBloc = BlocProvider.of<AnotherUserBloc>(context);
  }

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
    return BlocBuilder(
      bloc: anotherUserBloc,
      builder: (context, AnotherUserState state) {
        return state.user == null
            ? Shimmer.fromColors(
                child: Container(
                  height: 400,
                  color: Colors.white,
                ),
                baseColor: Colors.grey[300],
                highlightColor: Colors.grey[100],
              )
            : state.user.listRatings == null
                ? Shimmer.fromColors(
                    child: Container(
                      height: 400,
                      color: Colors.white,
                    ),
                    baseColor: Colors.grey[300],
                    highlightColor: Colors.grey[100],
                  )
                : state.user.listRatings.isEmpty
                    ? Container(
                        width: double.infinity,
                        color: colorBackground,
                        height: MediaQuery.of(context).size.height - 210,
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
                                "Không có đánh giá nào",
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
                    : ListView(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: <Widget>[
                          ListView.builder(
                              itemCount: state.user.listRatings.length,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) =>
                                  Card(
                                    child: Container(
                                        padding: EdgeInsets.all(16.0),
                                        color: Colors.white,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                GestureDetector(
                                                  child: ClipOval(
                                                    child: Image.network(
                                                      state
                                                          .user
                                                          .listRatings[index]
                                                          .user
                                                          .avatar,
                                                      fit: BoxFit.cover,
                                                      width: 40.0,
                                                      height: 40.0,
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    BlocProvider.of<
                                                                FunctionBloc>(
                                                            context)
                                                        .currentState
                                                        .navigateToUser(state
                                                            .user
                                                            .listRatings[index]
                                                            .user
                                                            .id);
                                                  },
                                                ),
                                                Container(
                                                  width: widthRating,
                                                  margin: EdgeInsets.only(
                                                      left: 16.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: <Widget>[
                                                          Text(
                                                            state
                                                                .user
                                                                .listRatings[
                                                                    index]
                                                                .user
                                                                .name,
                                                            style: TextStyle(
                                                              color:
                                                                  colorActive,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                          GestureDetector(
                                                              onTap: () {
                                                                _showDialog();
                                                              },
                                                              child: Container(
                                                                width: 50,
                                                                color: Colors
                                                                    .white,
                                                                child: Icon(
                                                                  FontAwesomeIcons
                                                                      .solidEyeSlash,
                                                                  size: 12,
                                                                  color:
                                                                      colorInactive,
                                                                ),
                                                              )),
                                                        ],
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            top: 4.0),
                                                        child: SmoothStarRating(
                                                          starCount: 5,
                                                          size: 16.0,
                                                          rating: state
                                                              .user
                                                              .listRatings[
                                                          index]
                                                              .rating.toDouble(),
                                                          color: Colors.yellow,
                                                          borderColor:
                                                              Colors.yellow,
                                                          allowHalfRating: false,
                                                        ),
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                                vertical: 8.0),
                                                        child: Text(
                                                          state
                                                              .user
                                                              .listRatings[
                                                                  index]
                                                              .comment,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 12),
                                                        ),
                                                      ),
                                                      Text(
                                                        Helper().formatDay(state
                                                            .user
                                                            .listRatings[index]
                                                            .day),
                                                        style: TextStyle(
                                                            color:
                                                                colorInactive,
                                                            fontStyle: FontStyle
                                                                .italic,
                                                            fontSize: 10),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )),
                                  )),
                          state.user.listRatings.length >= 10
                              ? Container()
                              : Container(
                            height: 400,
                            color: colorBackground,
                          )
                        ],
                      );
      },
    );
  }
}
