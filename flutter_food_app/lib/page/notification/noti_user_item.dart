import "package:flutter/material.dart";
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/api/api.dart';
import 'package:flutter_food_app/common/bloc/api_bloc.dart';
import 'package:flutter_food_app/common/bloc/function_bloc.dart';
import 'package:flutter_food_app/common/bloc/loading_bloc.dart';
import 'package:flutter_food_app/common/helper/helper.dart';
import 'package:flutter_food_app/common/state/api_state.dart';
import 'package:flutter_food_app/common/state/loading_state.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter_food_app/page/shimmer/shimmer_notification.dart';

class ListNotiUser extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ListNotiUserState();
}

class _ListNotiUserState extends State<ListNotiUser> {
  ApiBloc apiBloc;
  LoadingBloc loadingBloc;
  FunctionBloc functionBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiBloc = BlocProvider.of<ApiBloc>(context);
    loadingBloc = BlocProvider.of<LoadingBloc>(context);
    functionBloc = BlocProvider.of<FunctionBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder(
      bloc: apiBloc,
      builder: (context, ApiState state) {
        return BlocBuilder(
          bloc: loadingBloc,
          builder: (context, LoadingState loadingState) {
            return MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: loadingState.loadingFollowNoti
                  ? ShimmerNotification()
                  : state.mainUser == null
                      ? ShimmerNotification()
                      : state.mainUser.listFollowNotice == null
                          ? Container(
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height - 150,
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
                                      "Không có thông báo nào",
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
                          : ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: state.mainUser.listFollowNotice.length,
                              itemBuilder: (BuildContext context, int index) =>
                                  GestureDetector(
                                    onTap: () async {
                                      if (!state.mainUser
                                          .listFollowNotice[index].seen) {
                                        updateSeenFollowNoti(
                                            apiBloc,
                                            state.mainUser.id,
                                            state
                                                .mainUser
                                                .listFollowNotice[index]
                                                .idProduct,
                                            index);
                                      }
                                      functionBloc.currentState
                                          .navigateToPost(state
                                          .mainUser
                                          .listFollowNotice[index]
                                          .idProduct);
                                    },
                                    child: new Container(
                                      decoration: new BoxDecoration(
                                          color: state.mainUser
                                                  .listFollowNotice[index].seen
                                              ? Colors.white
                                              : colorActive.withOpacity(0.1),
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: colorInactive,
                                                  width: 0.5))),
                                      child: Padding(
                                          padding: EdgeInsets.all(16.0),
                                          child: Stack(
                                            children: <Widget>[
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Container(
                                                    width: 50.0,
                                                    height: 50.0,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    100)),
                                                        border: Border.all(
                                                            color:
                                                                colorInactive,
                                                            width: 1),
                                                        image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: NetworkImage(
                                                            state
                                                                .mainUser
                                                                .listFollowNotice[
                                                                    index]
                                                                .avatar,
                                                          ),
                                                        )),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 5.0),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: NetworkImage(state
                                                              .mainUser
                                                              .listFollowNotice[
                                                                  index]
                                                              .img[0]),
                                                        ),
                                                      ),
                                                      height: 50,
                                                      width: 70,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  left: 60.0,
                                                  right: 75,
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text.rich(
                                                      TextSpan(
                                                          text: state
                                                              .mainUser
                                                              .listFollowNotice[
                                                                  index]
                                                              .name,
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.black87,
                                                            fontSize: 13,
                                                          ), // default t// ext style
                                                          children: <TextSpan>[
                                                            TextSpan(
                                                                text:
                                                                    ' đã đăng một bài viết mới',
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .black54,
                                                                )),
                                                          ]),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 2,
                                                    ),
                                                    Row(
                                                      children: <Widget>[
                                                        Text(
                                                          Helper().timeAgo(state
                                                              .mainUser
                                                              .listFollowNotice[
                                                                  index]
                                                              .day),
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color:
                                                                  colorInactive),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )),
                                    ),
                                  )),
            );
          },
        );
      },
    );
  }
}
