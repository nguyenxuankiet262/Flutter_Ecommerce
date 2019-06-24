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
import 'package:flutter_food_app/page/another_user/follow/follow.dart';
import 'package:flutter_food_app/page/authentication/authentication.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:toast/toast.dart';

class HeaderAnother extends StatefulWidget {
  final String idUser;

  HeaderAnother(this.idUser);

  @override
  State<StatefulWidget> createState() => HeaderAnotherState();
}

class HeaderAnotherState extends State<HeaderAnother> {
  FunctionBloc functionBloc;
  AnotherUserBloc anotherUserBloc;
  ApiBloc apiBloc;
  UserBloc userBloc;
  bool onTapFollow = false;
  bool isFollow = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    functionBloc = BlocProvider.of<FunctionBloc>(context);
    anotherUserBloc = BlocProvider.of<AnotherUserBloc>(context);
    userBloc = BlocProvider.of<UserBloc>(context);
    apiBloc = BlocProvider.of<ApiBloc>(context);
    (() async {
      if (await Helper().check()) {
        if (apiBloc.currentState.mainUser != null) {
          if (await checkIsFollowing(
                  apiBloc.currentState.mainUser.id, widget.idUser) ==
              1) {
            setState(() {
              isFollow = true;
            });
          }
        }
      } else {
        new Future.delayed(const Duration(seconds: 1), () {
          Toast.show("Vui lòng kiểm tra mạng!", context,
              gravity: Toast.CENTER, backgroundColor: Colors.black87);
        });
      }
    })();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final widthColumn = (size.width - 70) / 3;
    return BlocBuilder(
      bloc: anotherUserBloc,
      builder: (context, AnotherUserState state) {
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
                              child: state.user == null
                                  ? Container(
                                      height: 100,
                                      width: 100,
                                    )
                                  : Image.network(
                                      state.user.avatar,
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
                                state.user == null ? "" : state.user.name,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.w600),
                              ),
                              SmoothStarRating(
                                starCount: 5,
                                size: 20.0,
                                rating:
                                    state.user == null ? 0 : state.user.rate,
                                color: Colors.yellow,
                                borderColor: Colors.yellow,
                                allowHalfRating: false,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  state.user != null
                      ? userBloc.currentState.isAdmin
                          ? Container()
                          : Positioned(
                              top: 16,
                              right: 16,
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    color: state.user != null
                                        ? isFollow ? Colors.cyan : colorOval
                                        : colorOval,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(100))),
                                child: Center(
                                  child: IconButton(
                                    icon: Icon(
                                      state.user != null
                                          ? isFollow
                                              ? FontAwesomeIcons.userCheck
                                              : FontAwesomeIcons.userPlus
                                          : FontAwesomeIcons.userPlus,
                                      size: 20,
                                      color: state.user != null
                                          ? isFollow
                                              ? Colors.white
                                              : Colors.black
                                          : Colors.black,
                                    ),
                                    onPressed: () async {
                                      if (apiBloc.currentState.mainUser !=
                                          null) {
                                        if (isFollow) {
                                          setState(() {
                                            onTapFollow = true;
                                          });
                                          await isFollowUser(
                                              apiBloc,
                                              apiBloc.currentState.mainUser.id,
                                              state.user,
                                              false);
                                          setState(() {
                                            onTapFollow = false;
                                            isFollow = false;
                                          });
                                          Toast.show(
                                              "Đã bỏ theo dõi " +
                                                  state.user.name +
                                                  "!",
                                              context,
                                              gravity: Toast.CENTER);
                                          User user =
                                              apiBloc.currentState.mainUser;
                                          user.amountFollowing--;
                                          apiBloc.changeMainUser(user);
                                          User anotherUser = state.user;
                                          anotherUser.amountFollowed--;
                                          anotherUserBloc
                                              .changeAnotherUser(anotherUser);
                                        } else {
                                          setState(() {
                                            onTapFollow = true;
                                          });
                                          await isFollowUser(
                                              apiBloc,
                                              apiBloc.currentState.mainUser.id,
                                              state.user,
                                              true);
                                          setState(() {
                                            onTapFollow = false;
                                            isFollow = true;
                                          });
                                          Toast.show(
                                              "Đã theo dõi " +
                                                  state.user.name +
                                                  "!",
                                              context,
                                              gravity: Toast.CENTER);
                                          User user =
                                              apiBloc.currentState.mainUser;
                                          user.amountFollowing++;
                                          User anotherUser = state.user;
                                          anotherUser.amountFollowed++;
                                          anotherUserBloc
                                              .changeAnotherUser(anotherUser);
                                          apiBloc.changeMainUser(user);
                                        }
                                      } else {
                                        functionBloc.onBeforeLogin(() async {
                                          if (isFollow) {
                                            setState(() {
                                              onTapFollow = true;
                                            });
                                            await isFollowUser(
                                                apiBloc,
                                                apiBloc
                                                    .currentState.mainUser.id,
                                                state.user,
                                                false);
                                            setState(() {
                                              onTapFollow = false;
                                              isFollow = false;
                                            });
                                            Toast.show(
                                                "Đã bỏ theo dõi " +
                                                    state.user.name +
                                                    "!",
                                                context,
                                                gravity: Toast.CENTER);
                                            User user =
                                                apiBloc.currentState.mainUser;
                                            user.amountFollowing--;
                                            apiBloc.changeMainUser(user);
                                          } else {
                                            setState(() {
                                              onTapFollow = true;
                                            });
                                            await isFollowUser(
                                                apiBloc,
                                                apiBloc
                                                    .currentState.mainUser.id,
                                                state.user,
                                                true);
                                            setState(() {
                                              onTapFollow = false;
                                              isFollow = true;
                                            });
                                            Toast.show(
                                                "Đã theo dõi " +
                                                    state.user.name +
                                                    "!",
                                                context,
                                                gravity: Toast.CENTER);
                                            User user =
                                                apiBloc.currentState.mainUser;
                                            user.amountFollowing++;
                                            apiBloc.changeMainUser(user);
                                          }
                                        });
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AuthenticationPage()));
                                      }
                                    },
                                  ),
                                ),
                              ),
                            )
                      : Container(),
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
                                            state.user != null &&
                                                    state.user.amountPost !=
                                                        null
                                                ? state.user.amountPost
                                                    .toString()
                                                : "0",
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
                                        if (state.user != null) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  FollowPage(1, state.user.id),
                                            ),
                                          );
                                        } else {
                                          Toast.show(
                                              "Đang tải dữ liệu!", context);
                                        }
                                      },
                                      child: Container(
                                        color: Colors.transparent,
                                        width: widthColumn,
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                              state.user != null &&
                                                      state.user
                                                              .amountFollowed !=
                                                          null
                                                  ? state.user.amountFollowed
                                                      .toString()
                                                  : "0",
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
                                                  color: colorText,
                                                  fontSize: 12),
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
                                        if (state.user != null) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  FollowPage(2, state.user.id),
                                            ),
                                          );
                                        } else {
                                          Toast.show(
                                              "Đang tải dữ liệu!", context);
                                        }
                                      },
                                      child: Container(
                                        color: Colors.transparent,
                                        width: widthColumn,
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                              state.user != null &&
                                                      state.user
                                                              .amountFollowing !=
                                                          null
                                                  ? state.user.amountFollowing
                                                      .toString()
                                                  : "0",
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
                                                  color: colorText,
                                                  fontSize: 12),
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
