import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyrefresh/delivery_header.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_food_app/api/api.dart';
import 'package:flutter_food_app/api/model/user.dart';
import 'package:flutter_food_app/common/bloc/api_bloc.dart';
import 'package:flutter_food_app/common/bloc/bottom_bar_bloc.dart';
import 'package:flutter_food_app/common/bloc/function_bloc.dart';
import 'package:flutter_food_app/common/bloc/loading_bloc.dart';
import 'package:flutter_food_app/common/bloc/location_bloc.dart';
import 'package:flutter_food_app/common/bloc/user_bloc.dart';
import 'package:flutter_food_app/common/helper/helper.dart';
import 'package:flutter_food_app/common/state/api_state.dart';
import 'package:flutter_food_app/common/state/user_state.dart';
import 'package:flutter_food_app/page/authentication/login/signin.dart';
import 'package:flutter_food_app/page/user/info_item.dart';
import 'package:flutter_food_app/page/user/list_post.dart';
import 'package:flutter_food_app/page/user/list_rating.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:toast/toast.dart';
import 'header.dart';
import 'package:flutter_food_app/const/color_const.dart';

class InfoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => InfoPageState();
}

class InfoPageState extends State<InfoPage>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  bool isFollow = false;
  ScrollController _hideButtonController;
  UserBloc userBloc;
  ApiBloc apiBloc;
  LoadingBloc loadingBloc;
  LocationBloc locationBloc;
  int beginPost = 1;
  int endPost = 10;
  int beginRating = 1;
  int endRating = 10;
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
  int index = 0;
  TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    locationBloc = BlocProvider.of(context);
    _tabController = new TabController(vsync: this, length: 3);
    _tabController.addListener(() {
      if (_tabController.index == 0) {
        setState(() {
          index = 0;
        });
      } else if (_tabController.index == 1) {
        setState(() {
          index = 1;
        });
      } else {
        setState(() {
          index = 2;
        });
      }
    });
    apiBloc = BlocProvider.of<ApiBloc>(context);
    userBloc = BlocProvider.of<UserBloc>(context);
    loadingBloc = BlocProvider.of<LoadingBloc>(context);
    _hideButtonController = new ScrollController();
    _hideButtonController.addListener(() {
      if (_hideButtonController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        BlocProvider.of<BottomBarBloc>(context).changeVisible(false);
      }
      if (_hideButtonController.position.userScrollDirection ==
          ScrollDirection.forward) {
        BlocProvider.of<BottomBarBloc>(context).changeVisible(true);
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _hideButtonController.dispose();
  }

  List<Widget> _fragments = [
    Container(
      padding: EdgeInsets.all(2.0),
      child: ListPost(),
    ),
    Container(
      color: Colors.white,
      child: ListRating(),
    ),
    Container(
      color: Colors.white,
      child: InfoItem(),
    )
  ];

  loadMorePost(ApiState apiState) async {
    if (await Helper().check()) {
      if (apiState.mainUser.listProductShow.length == endPost) {
        setState(() {
          beginPost += 10;
          endPost += 10;
        });
        await fetchListPostUser(apiBloc, loadingBloc,
            apiBloc.currentState.mainUser.id, beginPost, endPost);
        _footerKeyGrid.currentState.onLoadEnd();
      } else {
        await new Future.delayed(const Duration(seconds: 1), () {});
        _footerKeyGrid.currentState.onNoMore();
        _footerKeyGrid.currentState.onLoadClose();
      }
    } else {
      new Future.delayed(const Duration(seconds: 1), () {
        Toast.show("Vui lòng kiểm tra mạng!", context,
            gravity: Toast.CENTER, backgroundColor: Colors.black87);
      });
    }
  }

  loadMoreRating(ApiState apiState) async {
    if (await Helper().check()) {
      if (apiState.mainUser.listRatings.length == endRating) {
        setState(() {
          beginRating += 10;
          endRating += 10;
        });
        await fetchRatingByUser(apiBloc, apiBloc.currentState.mainUser.id,
            beginRating.toString(), endRating.toString());
        _footerKeyGrid.currentState.onLoadEnd();
      } else {
        await new Future.delayed(const Duration(seconds: 1), () {});
        _footerKeyGrid.currentState.onNoMore();
        _footerKeyGrid.currentState.onLoadClose();
      }
    } else {
      new Future.delayed(const Duration(seconds: 1), () {
        Toast.show("Vui lòng kiểm tra mạng!", context,
            gravity: Toast.CENTER, backgroundColor: Colors.black87);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // TODO: implement build
    return BlocBuilder(
      bloc: userBloc,
      builder: (context, UserState state) {
        return !state.isLogin
            ? Scaffold(
                appBar: AppBar(
                  elevation: 0.5,
                  brightness: Brightness.light,
                  iconTheme: IconThemeData(
                    color: Colors.black, //change your color here
                  ),
                  title: Text(
                    "Thông tin cá nhân",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  backgroundColor: Colors.white,
                  centerTitle: true,
                ),
                body: SigninContent(),
              )
            : BlocBuilder(
                bloc: apiBloc,
                builder: (context, ApiState apiState) {
                  return Scaffold(
                    appBar: AppBar(
                        elevation: 0.5,
                        brightness: Brightness.light,
                        iconTheme: IconThemeData(
                          color: Colors.black, //change your color here
                        ),
                        title: Text(
                          apiState.mainUser == null
                              ? ""
                              : apiState.mainUser.username,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        backgroundColor: Colors.white,
                        centerTitle: true,
                        actions: <Widget>[
                          apiState.mainUser == null
                              ? Container()
                              : Stack(
                                  children: <Widget>[
                                    GestureDetector(
                                      child: Container(
                                        color: Colors.white,
                                        height: 55,
                                        width: 50,
                                        child: Icon(
                                          Icons.menu,
                                          color: Colors.black,
                                        ),
                                      ),
                                      onTap:
                                          BlocProvider.of<FunctionBloc>(context)
                                              .currentState
                                              .openDrawer,
                                    ),
                                    apiState.mainUser != null
                                        ? apiState.mainUser.badge == null
                                            ? Container()
                                            : (apiState.mainUser.badge.sell +
                                                        apiState.mainUser.badge
                                                            .buy) ==
                                                    0
                                                ? Container()
                                                : Positioned(
                                                    top: 10,
                                                    right: 5,
                                                    child: Container(
                                                        padding:
                                                            EdgeInsets.all(1),
                                                        decoration:
                                                            new BoxDecoration(
                                                          color: Colors.red,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(12),
                                                        ),
                                                        constraints:
                                                            BoxConstraints(
                                                          minWidth: 18,
                                                          minHeight: 18,
                                                        ),
                                                        child: Center(
                                                          child: new Text(
                                                            (apiState.mainUser.badge
                                                                            .buy +
                                                                        apiState
                                                                            .mainUser
                                                                            .badge
                                                                            .sell) >
                                                                    20
                                                                ? " 20+ "
                                                                : (apiState
                                                                            .mainUser
                                                                            .badge
                                                                            .buy +
                                                                        apiState
                                                                            .mainUser
                                                                            .badge
                                                                            .sell)
                                                                    .toString(),
                                                            style:
                                                                new TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 9,
                                                            ),
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        )))
                                        : Container()
                                  ],
                                )
                        ]),
                    body: Stack(
                      children: <Widget>[
                        apiState.mainUser == null
                            ? Container(
                                width: MediaQuery.of(context).size.width,
                                height: 400,
                                color: Colors.white,
                              )
                            : Container(
                                width: MediaQuery.of(context).size.width,
                                height: 400,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        apiState.mainUser.coverphoto),
                                  ),
                                ),
                              ),
                        Positioned(
                            top: 400,
                            child: apiState.mainUser == null
                                ? Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height,
                                    color: Colors.white,
                                  )
                                : Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height,
                                    padding: EdgeInsets.only(
                                        top:
                                            MediaQuery.of(context).size.height *
                                                1 /
                                                15),
                                    child: Align(
                                        alignment: Alignment.topCenter,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Padding(
                                              child: Shimmer.fromColors(
                                                child: Icon(
                                                  FontAwesomeIcons.handPointUp,
                                                  size: 20,
                                                  color: Colors.black,
                                                ),
                                                baseColor: colorActive,
                                                highlightColor: Colors.orange,
                                              ),
                                              padding: EdgeInsets.only(
                                                  right: 16.0, bottom: 5.0),
                                            ),
                                            Shimmer.fromColors(
                                              child: Text(
                                                "Thả tay để làm mới trang",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                    fontSize: 17),
                                              ),
                                              baseColor: colorActive,
                                              highlightColor: Colors.orange,
                                            )
                                          ],
                                        )))),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          color: Colors.transparent.withOpacity(0.7),
                        ),
                        EasyRefresh(
                          key: _easyRefreshKey,
                          refreshHeader: ConnectorHeader(
                              key: _connectorHeaderKey,
                              header: DeliveryHeader(
                                key: _headerKey,
                                backgroundColor: Colors.black,
                              )),
                          refreshFooter: ConnectorFooter(
                              key: _connectorFooterKeyGrid,
                              footer: ClassicsFooter(
                                key: _footerKeyGrid,
                              )),
                          child: CustomScrollView(
                            controller: _hideButtonController,
                            shrinkWrap: true,
                            slivers: <Widget>[
                              SliverList(
                                delegate: SliverChildListDelegate(
                                    <Widget>[DeliveryHeader(key: _headerKey)]),
                              ),
                              SliverList(
                                  delegate: SliverChildListDelegate(<Widget>[
                                Header(),
                                ListView(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  children: <Widget>[
                                    Container(
                                      height: 54,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border(
                                            bottom: BorderSide(
                                                color: colorInactive,
                                                width: 0.5)),
                                      ),
                                      child: TabBar(
                                        controller: _tabController,
                                        indicatorColor: Colors.black,
                                        unselectedLabelColor: Colors.grey,
                                        labelColor: Colors.black,
                                        tabs: [
                                          Tab(
                                            child: Text(
                                              "Bài viết",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                          Tab(
                                            child: Text(
                                              "Đánh giá",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                          Tab(
                                            child: Text(
                                              "Thông tin",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      color: index == 2
                                          ? Colors.white
                                          : colorBackground,
                                      child: _fragments[index],
                                    ),
                                  ],
                                )
                              ])),
                              apiState.mainUser != null
                                  ? (index == 0 &&
                                              apiState.mainUser
                                                      .listProductShow !=
                                                  null) ||
                                          (index == 1 &&
                                              apiState.mainUser.listRatings !=
                                                  null)
                                      ? (index == 0 &&
                                                  apiState
                                                      .mainUser
                                                      .listProductShow
                                                      .isNotEmpty) ||
                                              (index == 1 &&
                                                  apiState.mainUser.listRatings
                                                      .isNotEmpty)
                                          ? SliverList(
                                              delegate:
                                                  SliverChildListDelegate(<
                                                      Widget>[
                                                ClassicsFooter(
                                                  bgColor: colorBackground,
                                                  key: _footerKeyGrid,
                                                  loadHeight: 50.0,
                                                )
                                              ]),
                                            )
                                          : SliverList(
                                              delegate: SliverChildListDelegate(
                                                  <Widget>[]),
                                            )
                                      : SliverList(
                                          delegate: SliverChildListDelegate(
                                              <Widget>[]),
                                        )
                                  : SliverList(
                                      delegate:
                                          SliverChildListDelegate(<Widget>[]),
                                    )
                            ],
                          ),
                          loadMore: apiState.mainUser != null
                              ? index == 0 &&
                                      apiState.mainUser.listProductShow != null
                                  ? index == 0 &&
                                          apiState.mainUser.listProductShow
                                              .isNotEmpty
                                      ? () {
                                          loadMorePost(apiState);
                                        }
                                      : index == 1 &&
                                              apiState.mainUser
                                                      .listProductShow !=
                                                  null
                                          ? index == 1 &&
                                                  apiState.mainUser.listRatings
                                                      .isNotEmpty
                                              ? () {
                                                  loadMoreRating(apiState);
                                                }
                                              : null
                                          : null
                                  : null
                              : null,
                          onRefresh: () async {
                            if (await Helper().check()) {
                              await new Future.delayed(
                                  const Duration(seconds: 1), () async {
                                setState(() {
                                  beginPost = 1;
                                  beginRating = 1;
                                  endPost = 10;
                                  endRating = 10;
                                });
                                User user = apiState.mainUser;
                                user.listProductShow = null;
                                user.listRatings = null;
                                user.amountPost = 0;
                                user.amountFollowed = 0;
                                user.amountFollowing = 0;
                                apiBloc.changeMainUser(user);
                                await fetchUserById(
                                    apiBloc, apiBloc.currentState.mainUser.id);
                                fetchListPostUser(apiBloc, loadingBloc,
                                    apiBloc.currentState.mainUser.id, 1, 10);
                                fetchRatingByUser(
                                    apiBloc,
                                    apiBloc.currentState.mainUser.id,
                                    "1",
                                    "10");
                                fetchCountNewOrder(
                                    apiBloc, apiBloc.currentState.mainUser.id);
                                if (apiState.cart == null) {
                                  fetchCartByUserId(apiBloc, loadingBloc,
                                      apiBloc.currentState.mainUser.id);
                                }
                                if (apiState.mainUser.listSystemNotice ==
                                    null) {
                                  fetchSystemNotificaion(
                                      apiBloc,
                                      loadingBloc,
                                      apiBloc.currentState.mainUser.id,
                                      "1",
                                      "10");
                                  fetchAmountNewSystemNoti(apiBloc,
                                      apiBloc.currentState.mainUser.id);
                                }
                                if (apiState.mainUser.listFollowNotice ==
                                    null) {
                                  fetchFollowNotificaion(
                                      apiBloc,
                                      loadingBloc,
                                      apiBloc.currentState.mainUser.id,
                                      "1",
                                      "10");
                                  fetchAmountNewFollowNoti(apiBloc,
                                      apiBloc.currentState.mainUser.id);
                                }
                                if (apiState.listMenu.isEmpty) {
                                  fetchBanner(apiBloc);
                                  String address = " ";
                                  if (locationBloc.currentState.indexCity !=
                                      0) {
                                    if (locationBloc
                                            .currentState.indexProvince !=
                                        0) {
                                      address = locationBloc
                                                  .currentState.nameProvinces[
                                              locationBloc.currentState
                                                  .indexCity][locationBloc
                                              .currentState.indexProvince] +
                                          ", " +
                                          locationBloc.currentState.nameCities[
                                              locationBloc
                                                  .currentState.indexCity];
                                    } else {
                                      address = locationBloc
                                              .currentState.nameCities[
                                          locationBloc.currentState.indexCity];
                                    }
                                  }
                                  apiBloc.changeTopNewest(null);
                                  apiBloc.changeTopFav(null);
                                  fetchTopTenNewestProduct(apiBloc, address);
                                  fetchTopTenFavProduct(apiBloc, address);
                                  fetchMenus(apiBloc);
                                }
                                BlocProvider.of<BottomBarBloc>(context)
                                    .changeVisible(true);
                              });
                            } else {
                              new Future.delayed(const Duration(seconds: 1),
                                  () {
                                Toast.show("Vui lòng kiểm tra mạng!", context,
                                    gravity: Toast.CENTER,
                                    backgroundColor: Colors.black87);
                              });
                            }
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
      },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
