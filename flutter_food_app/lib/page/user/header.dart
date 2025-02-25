import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/common/bloc/api_bloc.dart';
import 'package:flutter_food_app/common/bloc/function_bloc.dart';
import 'package:flutter_food_app/common/state/api_state.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:toast/toast.dart';

class Header extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HeaderState();
}

class HeaderState extends State<Header> {
  FunctionBloc functionBloc;
  ApiBloc apiBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    functionBloc = BlocProvider.of<FunctionBloc>(context);
    apiBloc = BlocProvider.of<ApiBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final widthColumn = (size.width - 70) / 3;
    return BlocBuilder(
      bloc: apiBloc,
      builder: (context, ApiState state) {
        return Container(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              child: Stack(
                children: <Widget>[
                  Container(
                    height: 400,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          child: Container(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.white, width: 2.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100.0))),
                            child: ClipOval(
                              child: state.mainUser == null
                                  ? Container(
                                      height: 100,
                                      width: 100,
                                    )
                                  : Image.network(
                                      state.mainUser.avatar,
                                      fit: BoxFit.cover,
                                      width: 100.0,
                                      height: 100.0,
                                    ),
                            ),
                          ),
                          onTap: () {},
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10.0, top: 10.0),
                          child: Column(
                            children: <Widget>[
                              Text(
                                state.mainUser == null
                                    ? ""
                                    : state.mainUser.name,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.w600),
                              ),
                              SmoothStarRating(
                                starCount: 5,
                                size: 20.0,
                                allowHalfRating: false,
                                rating: state.mainUser == null ? 0 : state.mainUser.rate,
                                color: Colors.yellow,
                                borderColor: Colors.yellow,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 400,
                    width: MediaQuery.of(context).size.width,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 60,
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          color: Colors.transparent,
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      color: Colors.transparent,
                                      width: widthColumn,
                                      child: Column(
                                        children: <Widget>[
                                          Text(
                                            state.mainUser != null && state.mainUser.amountPost != null ? state.mainUser.amountPost.toString() : "0",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            'bài viết',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: colorText, fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ),
                                    flex: 1,
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        if(state.mainUser != null) {
                                          functionBloc.currentState
                                              .navigateToFollow(1);
                                        }
                                        else{
                                          Toast.show("Đang tải dữ liệu!", context);
                                        }
                                      },
                                      child: Container(
                                        color: Colors.transparent,
                                        width: widthColumn,
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                              state.mainUser != null && state.mainUser.amountFollowed != null ? state.mainUser.amountFollowed.toString() : "0",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              'người theo dõi',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: colorText, fontSize: 12),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    flex: 1,
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        if(state.mainUser != null) {
                                          functionBloc.currentState
                                              .navigateToFollow(2);
                                        }
                                        else{
                                          Toast.show("Đang tải dữ liệu!", context);
                                        }
                                      },
                                      child: Container(
                                        color: Colors.transparent,
                                        width: widthColumn,
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                              state.mainUser != null && state.mainUser.amountFollowing != null ? state.mainUser.amountFollowing.toString() : "0",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              'đang theo dõi',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: colorText, fontSize: 12),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    flex: 1,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              width: double.infinity,
              padding: EdgeInsets.only(left: 15.0, right: 15.0),
              child: null,
            ),
          ],
        ));
      },
    );
  }
}
