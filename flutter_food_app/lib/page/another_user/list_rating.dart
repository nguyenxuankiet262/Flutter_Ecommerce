import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/api/api.dart';
import 'package:flutter_food_app/api/model/user.dart';
import 'package:flutter_food_app/common/bloc/another_user_bloc.dart';
import 'package:flutter_food_app/common/bloc/api_bloc.dart';
import 'package:flutter_food_app/common/bloc/function_bloc.dart';
import 'package:flutter_food_app/common/bloc/user_bloc.dart';
import 'package:flutter_food_app/common/helper/helper.dart';
import 'package:flutter_food_app/common/state/another_user_state.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:toast/toast.dart';

class ListRating extends StatefulWidget {
  final Function editRating;
  ListRating(this.editRating);
  @override
  State<StatefulWidget> createState() => ListRatingState();
}

class ListRatingState extends State<ListRating> {
  AnotherUserBloc anotherUserBloc;
  UserBloc userBloc;
  ApiBloc apiBloc;

  void _showLoading() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return SpinKitFadingCircle(
            color: Colors.white,
            size: 50.0,
          );
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userBloc = BlocProvider.of(context);
    anotherUserBloc = BlocProvider.of<AnotherUserBloc>(context);
    apiBloc = BlocProvider.of(context);
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
                                                  child: Stack(
                                                    children: <Widget>[
                                                      Column(
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
                                                            Helper().formatDay(Helper().plus7hourDateTime(state
                                                                .user
                                                                .listRatings[index]
                                                                .day)),
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
                                                      Positioned(
                                                          right: 0,
                                                          top: -14,
                                                          child: userBloc.currentState.isAdmin ||
                                                              !userBloc.currentState
                                                                  .isLogin
                                                              ? Container()
                                                              : (state.user.listRatings[
                                                          index]
                                                              .iduserrating ==
                                                              apiBloc
                                                                  .currentState
                                                                  .mainUser
                                                                  .id)
                                                              ? PopupMenuButton<
                                                              int>(
                                                            onSelected:
                                                                (int
                                                            result) async {
                                                              if (result ==
                                                                  1) {
                                                                widget.editRating();
                                                              } else {
                                                                _showLoading();
                                                                int check = await removeRatingUser(anotherUserBloc, state.user.id, index);
                                                                if(check == 1){
                                                                  Toast.show("Xóa đánh giá thành công!", context);
                                                                  Navigator.pop(context);
                                                                }
                                                                else{
                                                                  Toast.show("Xóa đánh giá thất bại!", context);
                                                                  Navigator.pop(context);
                                                                }
                                                              }
                                                            },
                                                            itemBuilder:
                                                                (BuildContext context) =>
                                                            <PopupMenuEntry<int>>[
                                                              const PopupMenuItem<int>(
                                                                value: 1,
                                                                child: Text('Chỉnh sửa đánh giá'),
                                                              ),
                                                              const PopupMenuItem<int>(
                                                                value: 2,
                                                                child: Text('Xóa đánh giá'),
                                                              ),
                                                            ],
                                                            tooltip:
                                                            "Chức năng",
                                                          )
                                                              : Container()
                                                      ),
                                                    ],
                                                  )
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
