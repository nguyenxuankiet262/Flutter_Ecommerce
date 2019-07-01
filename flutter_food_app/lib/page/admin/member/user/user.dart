import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyrefresh/delivery_header.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_food_app/api/api.dart';
import 'package:flutter_food_app/common/bloc/admin_bloc.dart';
import 'package:flutter_food_app/common/bloc/loading_bloc.dart';
import 'package:flutter_food_app/common/bloc/text_search_bloc.dart';
import 'package:flutter_food_app/common/helper/helper.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter_food_app/page/admin/member/user/list_user.dart';
import 'package:flutter_food_app/page/admin/member/user/search/search.dart';
import 'package:flutter_food_app/page/shimmer/shimmer_user.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:toast/toast.dart';

class UserPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => UserPageState();
}

class UserPageState extends State<UserPage> with AutomaticKeepAliveClientMixin{
  bool isSearch = false;
  final myController = TextEditingController();
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
        await fetchListUser(adminBloc, "1", "10");
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
    myController.dispose();
    adminBloc.changeUserList(null);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: PreferredSize(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(bottom: BorderSide(color: colorInactive, width: 0.5))
          ),
          height: AppBar().preferredSize.height + 16,
          child: isSearch
              ? Container(
                  height: 55.0,
                  color: Colors.white,
                  padding: EdgeInsets.only(
                      top: 16.0, right: 16.0, left: 16.0, bottom: 14.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                            margin: EdgeInsets.only(right: 16.0),
                            padding: EdgeInsets.symmetric(vertical: 2.0),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                                color: colorInactive.withOpacity(0.2)),
                            child: Container(
                                margin: EdgeInsets.only(left: 15.0),
                                child: TextField(
                                  autofocus: true,
                                  controller: myController,
                                  textInputAction: TextInputAction.search,
                                  onSubmitted: (newValue) {
                                    adminBloc.changeListSearchUser(null);
                                    BlocProvider.of<SearchInputBloc>(
                                        context)
                                        .searchInput(1, newValue);
                                    loadingBloc.changeLoadingSearch(true);
                                    fetchSearchUserList(adminBloc, loadingBloc, newValue, "1", "10");
                                  },
                                  style: TextStyle(
                                      fontFamily: "Ralway",
                                      fontSize: 12,
                                      color: Colors.black),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Nhập tên bài viết, người đăng',
                                    hintStyle: TextStyle(
                                        color: colorInactive,
                                        fontFamily: "Ralway",
                                        fontSize: 12),
                                    icon: Icon(
                                      Icons.search,
                                      color: colorInactive,
                                      size: 20,
                                    ),
                                    suffixIcon: myController.text.isEmpty
                                        ? null
                                        : GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                myController.clear();
                                              });
                                            },
                                            child: Icon(
                                              FontAwesomeIcons.solidTimesCircle,
                                              color: colorInactive,
                                              size: 15,
                                            ),
                                          ),
                                  ),
                                ))),
                        flex: 9,
                      ),
                      Expanded(
                          flex: 1,
                          child: GestureDetector(
                            child: Container(
                                color: Colors.white,
                                child: Center(
                                  child: Text(
                                    "Hủy",
                                    style: TextStyle(
                                        color: colorInactive,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "Ralway"),
                                  ),
                                )),
                            onTap: () {
                              setState(() {
                                isSearch = false;
                              });
                              adminBloc.changeListSearchUser(null);
                              BlocProvider.of<SearchInputBloc>(context).searchInput(1, "");
                              myController.clear();
                            },
                          ))
                    ],
                  ))
              : GestureDetector(
                  onTap: () {
                    setState(() {
                      isSearch = true;
                    });
                  },
                  child: Container(
                    height: 55.0,
                    color: Colors.white,
                    padding: EdgeInsets.only(
                        top: 16.0, right: 16.0, left: 16.0, bottom: 14.0),
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            color: colorInactive.withOpacity(0.2)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.search,
                              color: colorInactive,
                              size: 18,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 5.0),
                              child: Text(
                                "Tìm kiếm bài viết, người đăng",
                                style: TextStyle(
                                    fontFamily: "Raleway",
                                    color: colorInactive,
                                    fontSize: 12),
                              ),
                            ),
                          ],
                        )),
                  ),
                ),
        ),
        preferredSize: Size.fromHeight(AppBar().preferredSize.height + 16),
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          EasyRefresh(
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
                          : ListUser()
                    ])),
                isLoading
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
                : () async {
              if (await Helper().check()) {
                if (adminBloc.currentState.listUser.length ==
                    end) {
                  setState(() {
                    begin += 10;
                    end += 10;
                  });
                  await fetchListUser(adminBloc, begin.toString(), end.toString());
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
                      adminBloc.changeUserList(null);
                      await fetchListUser(adminBloc, "1", "10");
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
          ),
          Visibility(
            visible: isSearch ? true: false,
            child: SearchPage(),
          )
        ],
      )
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
