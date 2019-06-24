import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyrefresh/delivery_header.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_food_app/api/api.dart';
import 'package:flutter_food_app/api/model/user.dart';
import 'package:flutter_food_app/common/bloc/api_bloc.dart';
import 'package:flutter_food_app/common/helper/helper.dart';
import 'package:flutter_food_app/common/state/api_state.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter_food_app/page/shimmer/shimmer_feedback.dart';
import 'package:flutter_food_app/page/user/settings/main/feedback_manage/detail/detail.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:toast/toast.dart';

class ListFeedback extends StatefulWidget {
  final int index;

  ListFeedback(this.index);

  @override
  State<StatefulWidget> createState() => ListFeedbackState();
}

class ListFeedbackState extends State<ListFeedback>
    with AutomaticKeepAliveClientMixin {
  int begin = 1;
  int end = 10;
  bool isLoading = true;
  ApiBloc apiBloc;
  GlobalKey<EasyRefreshState> _easyRefreshKey =
      new GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshHeaderState> _headerKey =
      new GlobalKey<RefreshHeaderState>();
  GlobalKey<RefreshHeaderState> _connectorHeaderKey =
      new GlobalKey<RefreshHeaderState>();
  GlobalKey<RefreshFooterState> _footerKeyGrid =
      new GlobalKey<RefreshFooterState>();
  GlobalKey<RefreshFooterState> _connectorFooterKeyGrid =
      new GlobalKey<RefreshFooterState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiBloc = BlocProvider.of<ApiBloc>(context);
    (() async {
      if (await Helper().check()) {
        if (widget.index == 0) {
          await fetchListRepFeedback(
              apiBloc, apiBloc.currentState.mainUser.id, "1", "10");
          setState(() {
            isLoading = false;
          });
        } else {
          await fetchListUnRepFeedback(
              apiBloc, apiBloc.currentState.mainUser.id, "1", "10");
          setState(() {
            isLoading = false;
          });
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
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    User user = apiBloc.currentState.mainUser;
    user.listRepFeedback = null;
    user.listUnrepFeedback = null;
    apiBloc.changeMainUser(user);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // TODO: implement build
    return BlocBuilder(
      bloc: apiBloc,
      builder: (context, ApiState state) {
        return Container(
            color: colorBackground,
            child: new EasyRefresh(
              key: _easyRefreshKey,
              refreshHeader: ConnectorHeader(
                  key: _connectorHeaderKey,
                  header: DeliveryHeader(
                    key: _headerKey,
                    backgroundColor: colorBackground,
                  )),
              refreshFooter: ConnectorFooter(
                  key: _connectorFooterKeyGrid,
                  footer: ClassicsFooter(
                    key: _footerKeyGrid,
                  )),
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverList(
                    delegate: SliverChildListDelegate(<Widget>[
                      DeliveryHeader(
                          key: _headerKey, backgroundColor: colorBackground)
                    ]),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(<Widget>[
                      isLoading
                          ? ShimmerFeedback()
                          : (widget.index == 0 &&
                                      state.mainUser.listRepFeedback == null) ||
                                  (widget.index == 1 &&
                                      state.mainUser.listUnrepFeedback == null)
                              ? Container(
                                  width: double.infinity,
                                  height:
                                      MediaQuery.of(context).size.height - 200,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(
                                        const IconData(0xe900,
                                            fontFamily: 'box'),
                                        size: 150,
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 16.0),
                                        child: Text(
                                          "Không có phản hồi nào",
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
                                  padding: EdgeInsets.only(top: 0),
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: widget.index == 0
                                      ? state.mainUser.listRepFeedback.length
                                      : state.mainUser.listUnrepFeedback.length,
                                  itemBuilder:
                                      (BuildContext context, int index) =>
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: index == 0 ? 8.0 : 5.0,
                                                bottom: widget.index == 0
                                                    ? index ==
                                                            state
                                                                    .mainUser
                                                                    .listRepFeedback
                                                                    .length -
                                                                1
                                                        ? 8
                                                        : 0
                                                    : index ==
                                                            state
                                                                    .mainUser
                                                                    .listUnrepFeedback
                                                                    .length -
                                                                1
                                                        ? 8
                                                        : 0),
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            DetailFeedback(
                                                                index,
                                                                widget.index ==
                                                                        0
                                                                    ? true
                                                                    : false)));
                                              },
                                              child: Card(
                                                  child: Container(
                                                      padding:
                                                          EdgeInsets.all(16.0),
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
                                                              Container(
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          right:
                                                                              16.0),
                                                                  child: Row(
                                                                    children: <
                                                                        Widget>[
                                                                      Padding(
                                                                        padding:
                                                                            EdgeInsets.only(right: 8),
                                                                        child: Icon(
                                                                            widget.index == 0 ? FontAwesomeIcons.envelopeOpen : FontAwesomeIcons.envelope,
                                                                          size: 22,
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                          width: MediaQuery.of(context).size.width -
                                                                              150,
                                                                          child:
                                                                              Text(
                                                                            widget.index == 0
                                                                                ? state.mainUser.listRepFeedback[index].title
                                                                                : state.mainUser.listUnrepFeedback[index].title,
                                                                            style: TextStyle(
                                                                                color: Colors.black,
                                                                                fontSize: 15.0,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontFamily: "Ralway"),
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                            maxLines:
                                                                                1,
                                                                          ))
                                                                    ],
                                                                  )),
                                                              Container(
                                                                width: 50,
                                                                child: Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .centerRight,
                                                                  child: Text(
                                                                    Helper().timeAgo(widget.index ==
                                                                            0
                                                                        ? state
                                                                            .mainUser
                                                                            .listRepFeedback[
                                                                                index]
                                                                            .day
                                                                        : state
                                                                            .mainUser
                                                                            .listUnrepFeedback[index]
                                                                            .day),
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            "Ralway",
                                                                        color:
                                                                            colorInactive,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        fontSize:
                                                                            14),
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 32,
                                                                    bottom: 16),
                                                            child: Text(
                                                              widget.index == 0
                                                                  ? state
                                                                      .mainUser
                                                                      .listRepFeedback[
                                                                          index]
                                                                      .feedBack
                                                                  : state
                                                                      .mainUser
                                                                      .listUnrepFeedback[
                                                                          index]
                                                                      .feedBack,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      "Ralway",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 14),
                                                            ),
                                                          )
                                                        ],
                                                      ))),
                                            ),
                                          ))
                    ]),
                  ),
                  (widget.index == 0 &&
                              state.mainUser.listRepFeedback == null) ||
                          (widget.index == 1 &&
                              state.mainUser.listUnrepFeedback == null)
                      ? SliverList(
                          delegate: SliverChildListDelegate(<Widget>[]),
                        )
                      : SliverList(
                          delegate: SliverChildListDelegate(<Widget>[
                            ClassicsFooter(
                              key: _footerKeyGrid,
                              loadHeight: 50.0,
                            )
                          ]),
                        )
                ],
              ),
              onRefresh: () async {
                if (await Helper().check()) {
                  setState(() {
                    isLoading = true;
                    begin = 1;
                    end = 10;
                  });
                  User user = apiBloc.currentState.mainUser;
                  if (widget.index == 0) {
                    user.listRepFeedback = null;
                  } else {
                    user.listUnrepFeedback = null;
                  }
                  apiBloc.changeMainUser(user);
                  if (widget.index == 0) {
                    await fetchListRepFeedback(
                        apiBloc, apiBloc.currentState.mainUser.id, "1", "10");
                    setState(() {
                      isLoading = false;
                    });
                  } else {
                    await fetchListUnRepFeedback(
                        apiBloc, apiBloc.currentState.mainUser.id, "1", "10");
                    setState(() {
                      isLoading = false;
                    });
                  }
                } else {
                  new Future.delayed(const Duration(seconds: 1), () {
                    Toast.show("Vui lòng kiểm tra mạng!", context,
                        gravity: Toast.CENTER, backgroundColor: Colors.black87);
                  });
                }
              },
              loadMore: (widget.index == 0 &&
                          state.mainUser.listRepFeedback == null) ||
                      (widget.index == 1 &&
                          state.mainUser.listUnrepFeedback == null)
                  ? null
                  : () async {
                      if (await Helper().check()) {
                        if (widget.index == 0
                            ? state.mainUser.listRepFeedback.length == end
                            : state.mainUser.listUnrepFeedback.length == end) {
                          setState(() {
                            begin += 10;
                            end += 10;
                          });
                          if (widget.index == 0) {
                            await fetchListRepFeedback(
                                apiBloc,
                                apiBloc.currentState.mainUser.id,
                                begin.toString(),
                                end.toString());
                          } else {
                            await fetchListUnRepFeedback(
                                apiBloc,
                                apiBloc.currentState.mainUser.id,
                                begin.toString(),
                                end.toString());
                          }
                          _footerKeyGrid.currentState.onLoadEnd();
                        } else {
                          await new Future.delayed(
                              const Duration(seconds: 1), () {});
                          _footerKeyGrid.currentState.onNoMore();
                          _footerKeyGrid.currentState.onLoadClose();
                        }
                      } else {
                        new Future.delayed(const Duration(seconds: 1), () {
                          Toast.show("Vui lòng kiểm tra mạng!", context,
                              gravity: Toast.CENTER,
                              backgroundColor: Colors.black87);
                        });
                      }
                    },
            ));
      },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
