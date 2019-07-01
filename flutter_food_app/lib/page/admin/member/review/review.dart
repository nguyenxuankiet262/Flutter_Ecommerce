import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyrefresh/delivery_header.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_food_app/api/api.dart';
import 'package:flutter_food_app/common/bloc/admin_bloc.dart';
import 'package:flutter_food_app/common/bloc/loading_bloc.dart';
import 'package:flutter_food_app/common/bloc/text_search_bloc.dart';
import 'package:flutter_food_app/common/helper/helper.dart';
import 'package:flutter_food_app/common/state/admin_state.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter_food_app/page/admin/member/review/list_review.dart';
import 'package:flutter_food_app/page/admin/member/user/list_user.dart';
import 'package:flutter_food_app/page/admin/member/user/search/search.dart';
import 'package:flutter_food_app/page/shimmer/shimmer_user.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:toast/toast.dart';

class ReviewPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ReviewPageState();
}

class ReviewPageState extends State<ReviewPage> with AutomaticKeepAliveClientMixin{
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
  bool isLoading = true;
  AdminBloc adminBloc;
  LoadingBloc loadingBloc;
  int begin = 1;
  int end = 10;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    adminBloc = BlocProvider.of(context);
    loadingBloc = BlocProvider.of(context);
    (() async {
      if(await Helper().check()){
        await fetchListReviewUser(adminBloc, "1", "10");
        setState(() {
          isLoading = false;
        });
      }else {
        new Future.delayed(
            const Duration(seconds: 1),
                () {
              Toast.show(
                  "Vui lòng kiểm tra mạng!",
                  context,
                  gravity: Toast.CENTER,
                  backgroundColor:
                  Colors.black87);
            });
      }
    })();
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    adminBloc.changeReviewUserList(null);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // TODO: implement build
    return BlocBuilder(
      bloc: adminBloc,
      builder: (context, AdminState state){
        return EasyRefresh(
          key: _easyRefreshKey,
          refreshHeader: ConnectorHeader(
              key: _connectorHeaderKey,
              header: DeliveryHeader(key: _headerKey, backgroundColor: colorBackground,)),
          refreshFooter: ConnectorFooter(
              key: _connectorFooterKeyGrid,
              footer: ClassicsFooter(
                bgColor: colorBackground,
                key: _footerKeyGrid,
              )),
          child: CustomScrollView(
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildListDelegate(
                    <Widget>[DeliveryHeader(key: _headerKey, backgroundColor: colorBackground)]),
              ),
              SliverList(
                  delegate: SliverChildListDelegate(<Widget>[
                    isLoading
                        ? ShimmerUser()
                        : state.listReviewUsers == null
                        ? Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height - 150,
                      child: Column(
                        mainAxisAlignment:
                        MainAxisAlignment.center,
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
                              "Không có người dùng nào",
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
                        : state.listReviewUsers.isEmpty
                        ? Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height - 150,
                      child: Column(
                        mainAxisAlignment:
                        MainAxisAlignment.center,
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
                              "Không có người dùng nào",
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
                        :  ListReviewUser()
                  ])),
              isLoading
                  ? SliverList(
                delegate: SliverChildListDelegate(<Widget>[
                ]),
              )
              : state.listReviewUsers == null
                  ? SliverList(
                delegate: SliverChildListDelegate(<Widget>[

                ]),
              )
                  : state.listReviewUsers.isEmpty
                  ? SliverList(
                delegate: SliverChildListDelegate(<Widget>[

                ]),
              )
                  : SliverList(
                delegate: SliverChildListDelegate(<Widget>[
                  ClassicsFooter(
                    key: _footerKeyGrid,
                    loadHeight: 50.0,
                    bgColor: colorBackground,
                  )
                ]),
              )
            ],
          ),
          loadMore: isLoading
              ? null
              : state.listReviewUsers == null
              ? null
              : state.listReviewUsers.isEmpty
              ? null: () async {
            if (await Helper().check()) {
              if (adminBloc.currentState.listReviewUsers.length ==
                  end) {
                setState(() {
                  begin += 10;
                  end += 10;
                });
                await fetchListReviewUser(adminBloc, begin.toString(), end.toString());
                _footerKeyGrid.currentState
                    .onLoadEnd();
              } else {
                await new Future.delayed(
                    const Duration(
                        seconds: 1),
                        () {});
                _footerKeyGrid.currentState
                    .onNoMore();
                _footerKeyGrid.currentState
                    .onLoadClose();
              }
            } else {
              new Future.delayed(
                  const Duration(seconds: 1),
                      () {
                    Toast.show(
                        "Vui lòng kiểm tra mạng!",
                        context,
                        gravity: Toast.CENTER,
                        backgroundColor:
                        Colors.black87);
                  });
            }
          },
          onRefresh: () async {
            if (await Helper().check()) {
              setState(() {
                isLoading = true;
              });
              await new Future.delayed(const Duration(seconds: 1),
                      () async {
                    setState(() {
                      begin = 1;
                      end = 10;
                    });
                    adminBloc.changeReviewUserList(null);
                    await fetchListReviewUser(adminBloc, "1", "10");
                    setState(() {
                      isLoading = false;
                    });
                  });
            } else {
              new Future.delayed(const Duration(seconds: 1), () {
                Toast.show("Vui lòng kiểm tra mạng!", context,
                    gravity: Toast.CENTER,
                    backgroundColor: Colors.black87);
              });
            }
          },
        );
      },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
