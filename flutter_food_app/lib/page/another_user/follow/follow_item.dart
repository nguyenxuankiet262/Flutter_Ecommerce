import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/api/api.dart';
import 'package:flutter_food_app/api/model/user.dart';
import 'package:flutter_food_app/common/bloc/api_bloc.dart';
import 'package:flutter_food_app/common/bloc/follow_bloc.dart';
import 'package:flutter_food_app/common/helper/helper.dart';
import 'package:flutter_food_app/common/state/api_state.dart';
import 'package:flutter_food_app/common/state/follow_state.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter_food_app/page/another_user/info.dart';
import 'package:toast/toast.dart';

class FollowItem extends StatefulWidget {
  final int index;

  FollowItem(this.index,);

  @override
  State<StatefulWidget> createState() => FollowItemState();
}

class FollowItemState extends State<FollowItem> {
  bool onTapFollow = false;
  ApiBloc apiBloc;
  FollowBloc followBloc;
  bool isFollow = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiBloc = BlocProvider.of<ApiBloc>(context);
    followBloc = BlocProvider.of<FollowBloc>(context);
    (() async {
      if (await Helper().check()) {
        if(apiBloc.currentState.mainUser != null){
          if (await checkIsFollowing(
              apiBloc.currentState.mainUser.id,
              followBloc.currentState.listFollow[widget.index].id) ==
              1) {
            setState(() {
              isFollow = true;
            });
          }
        }
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

  bool isMainUser(String id) {
    if(apiBloc.currentState.mainUser != null){
      if (id == apiBloc.currentState.mainUser.id) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder(
      bloc: apiBloc,
      builder: (context, ApiState state) {
        return BlocBuilder(
          bloc: followBloc,
          builder: (context, FollowState followState){
            return Container(
              height: 70,
              margin: EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      GestureDetector(
                          onTap: () {
                            if(!isMainUser(followState.listFollow[widget.index].id)){
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => InfoAnotherPage(
                                        followState.listFollow[widget.index].id)),
                              );
                            }
                          },
                          child: Container(
                            child: ClipOval(
                              child: Image.network(
                                followState.listFollow[widget.index].avatar,
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
                          )),
                      Container(
                        margin: EdgeInsets.only(left: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                if(!isMainUser(followState.listFollow[widget.index].id)){
                                  Navigator.pop(context);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => InfoAnotherPage(
                                            followState.listFollow[widget.index].id)),
                                  );
                                }
                              },
                              child: Text(
                                followState.listFollow[widget.index].username,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Ralway"),
                              ),
                            ),
                            Text(
                              followState.listFollow[widget.index].name,
                              style: TextStyle(fontSize: 14, color: colorText),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      margin: EdgeInsets.only(bottom: 4.0),
                      child: state.mainUser != null
                          ? isMainUser(
                        followState.listFollow[widget.index].id,
                      )
                          ? Container(
                        height: 0,
                        width: 0,
                      )
                          : RaisedButton(
                        onPressed: () async {
                          if (isFollow) {
                            setState(() {
                              onTapFollow = true;
                            });
                            await isFollowUser(
                                apiBloc,
                                state.mainUser.id,
                                followState.listFollow[widget.index],
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
                                followState.listFollow[widget.index],
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
                            borderRadius:
                            new BorderRadius.circular(10.0)),
                        color: isFollow
                            ? Colors.white
                            : colorActive,
                        textColor: isFollow
                            ? Colors.black
                            : Colors.white,
                        child: Text(isFollow
                            ? "Đang theo dõi"
                            : "Theo dõi"),
                      )
                          : Container(
                        height: 0,
                        width: 0,
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
