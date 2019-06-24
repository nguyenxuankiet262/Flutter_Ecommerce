import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/api/api.dart';
import 'package:flutter_food_app/api/model/user.dart';
import 'package:flutter_food_app/common/bloc/api_bloc.dart';
import 'package:flutter_food_app/common/helper/helper.dart';
import 'package:flutter_food_app/common/state/api_state.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter_food_app/page/another_user/info.dart';
import 'package:toast/toast.dart';

class FollowItem extends StatefulWidget {
  final int isFollower;
  final int index;

  FollowItem(this.isFollower, this.index);

  @override
  State<StatefulWidget> createState() => FollowItemState();
}

class FollowItemState extends State<FollowItem> {
  ApiBloc apiBloc;
  bool onTapFollow = false;
  bool isFollow = false;
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiBloc = BlocProvider.of<ApiBloc>(context);
    if (widget.isFollower == 1) {
      (() async {
        if (await Helper().check()) {
          if (await checkIsFollowing(
                  apiBloc.currentState.mainUser.id,
                  apiBloc
                      .currentState.mainUser.listFollowed[widget.index].id) ==
              1) {
            setState(() {
              isFollow = true;
            });
          }
          setState(() {
            isLoading = false;
          });
        }
        else{
          new Future.delayed(const Duration(seconds: 1),
                  () {
                Toast.show("Vui lòng kiểm tra mạng!", context,
                    gravity: Toast.CENTER,
                    backgroundColor: Colors.black87);
              });
        }
      })();
    } else {
      (() async {
        if (await Helper().check()) {
          if (await checkIsFollowing(
                  apiBloc.currentState.mainUser.id,
                  apiBloc
                      .currentState.mainUser.listFollowing[widget.index].id) ==
              1) {
            setState(() {
              isFollow = true;
            });
          }
          setState(() {
            isLoading = false;
          });
        }
        else{
          new Future.delayed(const Duration(seconds: 1),
                  () {
                Toast.show("Vui lòng kiểm tra mạng!", context,
                    gravity: Toast.CENTER,
                    backgroundColor: Colors.black87);
              });
        }
      })();
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder(
      bloc: apiBloc,
      builder: (context, ApiState state) {
        return Container(
          height: 70,
          margin: EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              GestureDetector(
                  onTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => InfoAnotherPage(
                                    widget.isFollower == 1
                                        ? state.mainUser
                                            .listFollowed[widget.index].id
                                        : state.mainUser
                                            .listFollowing[widget.index].id)),
                          );
                        },
                        child: Container(
                          child: ClipOval(
                            child: Image.network(
                              widget.isFollower == 1
                                  ? state.mainUser.listFollowed[widget.index]
                                      .avatar
                                  : state.mainUser.listFollowing[widget.index]
                                      .avatar,
                              fit: BoxFit.cover,
                              width: 70.0,
                              height: 70.0,
                            ),
                          ),
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: colorInactive, width: 0.5),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100))),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => InfoAnotherPage(
                                          widget.isFollower == 1
                                              ? state.mainUser
                                                  .listFollowed[widget.index].id
                                              : state
                                                  .mainUser
                                                  .listFollowing[widget.index]
                                                  .id)),
                                );
                              },
                              child: Text(
                                widget.isFollower == 1
                                    ? state.mainUser.listFollowed[widget.index]
                                        .username
                                    : state.mainUser.listFollowing[widget.index]
                                        .username,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Ralway"),
                              ),
                            ),
                            Text(
                              widget.isFollower == 1
                                  ? state
                                      .mainUser.listFollowed[widget.index].name
                                  : state.mainUser.listFollowing[widget.index]
                                      .name,
                              style: TextStyle(fontSize: 14, color: colorText),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  margin: EdgeInsets.only(bottom: 4),
                  child: isLoading
                      ? Container()
                      : RaisedButton(
                          onPressed: () async {
                            if (isFollow) {
                              setState(() {
                                onTapFollow = true;
                              });
                              await isFollowUser(
                                  apiBloc,
                                  state.mainUser.id,
                                  widget.isFollower == 1
                                      ? state
                                          .mainUser.listFollowed[widget.index]
                                      : state
                                          .mainUser.listFollowing[widget.index],
                                  false);
                              setState(() {
                                onTapFollow = false;
                                isFollow = false;
                              });
                              User user = apiBloc.currentState.mainUser;
                              user.amountFollowing--;
                              apiBloc.changeMainUser(user);
                            } else {
                              setState(() {
                                onTapFollow = true;
                              });
                              await isFollowUser(
                                  apiBloc,
                                  state.mainUser.id,
                                  widget.isFollower == 1
                                      ? state
                                          .mainUser.listFollowed[widget.index]
                                      : state
                                          .mainUser.listFollowing[widget.index],
                                  true);
                              setState(() {
                                onTapFollow = false;
                                isFollow = true;
                              });
                              User user = apiBloc.currentState.mainUser;
                              user.amountFollowing++;
                              apiBloc.changeMainUser(user);
                            }
                          },
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(10.0)),
                          color: isFollow ? Colors.white : colorActive,
                          textColor: isFollow ? Colors.black : Colors.white,
                          child: Text(isFollow ? "Đang theo dõi" : "Theo dõi"),
                        ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
