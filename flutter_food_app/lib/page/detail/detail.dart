import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyrefresh/delivery_header.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_food_app/api/api.dart';
import 'package:flutter_food_app/common/bloc/api_bloc.dart';
import 'package:flutter_food_app/common/bloc/bottom_bar_bloc.dart';
import 'package:flutter_food_app/common/bloc/detail_bloc.dart';
import 'package:flutter_food_app/common/bloc/function_bloc.dart';
import 'package:flutter_food_app/common/bloc/text_search_bloc.dart';
import 'package:flutter_food_app/common/state/api_state.dart';
import 'package:flutter_food_app/common/state/detail_page_state.dart';
import 'package:flutter_food_app/page/filter/filter.dart';
import 'package:flutter_food_app/page/search/search.dart';
import 'package:flutter_food_app/page/shimmer/shimmer_child_menu.dart';
import 'package:flutter_food_app/page/shimmer/shimmer_post.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter_food_app/const/value_const.dart';
import 'package:flutter_food_app/page/detail/menu.dart';
import 'list_post.dart';
import 'filter/filter.dart';

class ListAllPost extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ListAllPostState();
}

class _ListAllPostState extends State<ListAllPost>
    with AutomaticKeepAliveClientMixin {
  String _text = "";
  bool complete = false;
  bool isSearch = false;
  final myController = TextEditingController();
  FunctionBloc functionBloc;
  ScrollController _hideButtonController;
  FocusNode focusNode;
  DetailPageBloc detailPageBloc;
  bool isLoading = true;
  ApiBloc apiBloc;
  GlobalKey<EasyRefreshState> _easyRefreshKey =
      new GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshHeaderState> _headerKey =
      new GlobalKey<RefreshHeaderState>();
  GlobalKey<RefreshHeaderState> _connectorHeaderKey =
      new GlobalKey<RefreshHeaderState>();

  void changeDetail() {
    setState(() {
      _text = "";
      isSearch = false;
      myController.clear();
    });
    BlocProvider.of<SearchInputBloc>(context).searchInput(1, "");
  }

  Function _callBack;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiBloc = BlocProvider.of<ApiBloc>(context);
    detailPageBloc = BlocProvider.of<DetailPageBloc>(context);
    fetchChildMenu(apiBloc, apiBloc.currentState.listMenu[detailPageBloc.currentState.indexCategory].id);
    //fetchProduct(apiBloc.currentState.listChildMenu[0].id);
    BlocProvider.of<FunctionBloc>(context).isLoading(_isLoading);
    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        isLoading = false;
      });
    });
    _hideButtonController = new ScrollController();
    focusNode = FocusNode();
    _hideButtonController.addListener(() {
      if (_hideButtonController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        BlocProvider.of<BottomBarBloc>(context).changeVisible(false);
      }
      if (_hideButtonController.position.userScrollDirection ==
          ScrollDirection.forward) {
        BlocProvider.of<BottomBarBloc>(context).changeVisible(true);
      }
      if (_hideButtonController.offset >=
              _hideButtonController.position.maxScrollExtent &&
          !_hideButtonController.position.outOfRange) {
        //print("reach bottom");
      }
    });
    BlocProvider.of<BottomBarBloc>(context).changeVisible(true);
    functionBloc = BlocProvider.of<FunctionBloc>(context);
    _callBack = functionBloc.currentState.onBackPressed;
    functionBloc.onBackPressed(_onBackPressed);
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myController.dispose();
    focusNode.dispose();
    _hideButtonController.dispose();
    super.dispose();
  }

  _isLoading() {
    _hideButtonController.animateTo(
      0.0,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 300),
    );
    setState(() {
      isLoading = true;
    });
    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        isLoading = false;
      });
    });
    BlocProvider.of<BottomBarBloc>(context).changeVisible(true);
  }

  AppBar buildAppBar(BuildContext context, DetailPageState state) {
    return new AppBar(
      elevation: 0.0,
      brightness: Brightness.light,
      title: new Text(
        state.indexChildCategory == 0
            ? listMenu[state.indexCategory].name
            : listMenu[state.indexCategory]
                .childMenu[state.indexChildCategory]
                .name,
        style: TextStyle(
            fontWeight: FontWeight.bold, color: Colors.black, fontSize: 17),
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(
        color: Colors.black, //change your color here
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
        onWillPop: _onBackPressed,
        child: BlocBuilder(
          bloc: detailPageBloc,
          builder: (context, DetailPageState detailstate) {
            return Stack(
              children: <Widget>[
                Scaffold(
                    resizeToAvoidBottomPadding: false,
                    appBar: PreferredSize(
                      preferredSize: Size.fromHeight(111.0),
                      // here the desired height
                      child: Column(
                        children: <Widget>[
                          buildAppBar(context, detailstate),
                          Container(
                              height: 55.0,
                              color: Colors.white,
                              padding: EdgeInsets.only(
                                  right: 16.0, left: 16.0, bottom: 14.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.only(right: 16.0),
                                      padding:
                                          EdgeInsets.symmetric(vertical: 2.0),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5.0)),
                                          color:
                                              colorInactive.withOpacity(0.2)),
                                      child: Container(
                                          margin: EdgeInsets.only(left: 15.0),
                                          child: TextField(
                                            focusNode: focusNode,
                                            controller: myController,
                                            textInputAction:
                                                TextInputAction.search,
                                            onChanged: (text) {
                                              setState(() {
                                                _text = text;
                                              });
                                            },
                                            onSubmitted: (newValue) {
                                              setState(() {
                                                BlocProvider.of<
                                                            SearchInputBloc>(
                                                        context)
                                                    .searchInput(1, newValue);
                                                isSearch = true;
                                              });
                                            },
                                            style: TextStyle(
                                                fontFamily: "Ralway",
                                                fontSize: 12,
                                                color: Colors.black),
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText:
                                                  'Nhập tên bài viết, người đăng',
                                              hintStyle: TextStyle(
                                                  color: colorInactive,
                                                  fontFamily: "Ralway",
                                                  fontSize: 12),
                                              icon: Icon(
                                                Icons.search,
                                                color: colorInactive,
                                                size: 20,
                                              ),
                                              suffixIcon: _text.isEmpty
                                                  ? null
                                                  : GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          _text = "";
                                                          myController.clear();
                                                        });
                                                      },
                                                      child: Icon(
                                                        FontAwesomeIcons
                                                            .solidTimesCircle,
                                                        color: colorInactive,
                                                        size: 15,
                                                      ),
                                                    ),
                                            ),
                                          )),
                                    ),
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
                                          BlocProvider.of<BottomBarBloc>(
                                                  context)
                                              .changeVisible(true);
                                          focusNode.unfocus();
                                          changeDetail();
                                        },
                                      ))
                                ],
                              ))
                        ],
                      ),
                    ),
                    body: SearchPage()),
                Visibility(
                    maintainState: true,
                    visible: isSearch ? false : true,
                    child: Material(
                      child: SafeArea(
                        child: NestedScrollView(
                            controller: _hideButtonController,
                            headerSliverBuilder: (context, innerBoxScrolled) =>
                                [
                                  SliverAppBar(
                                    automaticallyImplyLeading: false,
                                    elevation: 0.0,
                                    brightness: Brightness.light,
                                    backgroundColor: Colors.white,
                                    pinned: false,
                                    floating: true,
                                    snap: true,
                                    expandedHeight: 97,
                                    flexibleSpace: FlexibleSpaceBar(
                                      collapseMode: CollapseMode.pin,
                                      background: Column(
                                        children: <Widget>[
                                          buildAppBar(context, detailstate),
                                          GestureDetector(
                                            onTap: () {
                                              BlocProvider.of<BottomBarBloc>(
                                                      context)
                                                  .changeVisible(false);
                                              FocusScope.of(context)
                                                  .requestFocus(focusNode);
                                              setState(() {
                                                isSearch = true;
                                              });
                                            },
                                            child: Container(
                                              height: 41.0,
                                              color: Colors.white,
                                              padding: EdgeInsets.only(
                                                  right: 16.0, left: 16.0),
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  5.0)),
                                                      color: colorInactive
                                                          .withOpacity(0.2)),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      Icon(
                                                        Icons.search,
                                                        color: colorInactive,
                                                        size: 18,
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            left: 5.0),
                                                        child: Text(
                                                          "Tìm kiếm bài viết, người đăng",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "Raleway",
                                                              color:
                                                                  colorInactive,
                                                              fontSize: 12),
                                                        ),
                                                      ),
                                                    ],
                                                  )),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SliverPersistentHeader(
                                    pinned: true,
                                    delegate: _SliverAppBarDelegate(
                                      child: PreferredSize(
                                          preferredSize: Size.fromHeight(46),
                                          child: BlocBuilder(
                                            bloc: detailPageBloc,
                                            builder: (context,
                                                DetailPageState state) {
                                              return Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border(
                                                        bottom: BorderSide(
                                                            color:
                                                                colorInactive,
                                                            width: 0.5))),
                                                child: Row(
                                                  children: <Widget>[
                                                    Expanded(
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          FilterManagement()));
                                                        },
                                                        child: Container(
                                                            height: 30,
                                                            margin:
                                                                EdgeInsets.only(
                                                                    top: 8.0,
                                                                    bottom: 8.0,
                                                                    right: 8.0,
                                                                    left: 16.0),
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                border: Border(
                                                                    right: BorderSide(
                                                                        color:
                                                                            colorInactive,
                                                                        width:
                                                                            0.5))),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: <
                                                                  Widget>[
                                                                Expanded(
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: <
                                                                        Widget>[
                                                                      Text(
                                                                        "Danh mục",
                                                                        maxLines:
                                                                            1,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                12,
                                                                            fontFamily:
                                                                                "Ralway",
                                                                            color:
                                                                                colorInactive,
                                                                            fontWeight:
                                                                                FontWeight.w500),
                                                                      ),
                                                                      Text(
                                                                        listMenu[state.indexCategory]
                                                                            .name,
                                                                        maxLines:
                                                                            1,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                12,
                                                                            fontFamily:
                                                                                "Ralway",
                                                                            fontWeight:
                                                                                FontWeight.w500),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  flex: 9,
                                                                ),
                                                                Icon(
                                                                  Icons
                                                                      .arrow_drop_down,
                                                                )
                                                              ],
                                                            )),
                                                      ),
                                                      flex: 3,
                                                    ),
                                                    Expanded(
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          FilterManagement()));
                                                        },
                                                        child: Container(
                                                            height: 30,
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                border: Border(
                                                                    right: BorderSide(
                                                                        color:
                                                                            colorInactive,
                                                                        width:
                                                                            0.5))),
                                                            margin:
                                                                EdgeInsets.only(
                                                                    top: 8.0,
                                                                    bottom:
                                                                        8.0),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: <
                                                                  Widget>[
                                                                Expanded(
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: <
                                                                        Widget>[
                                                                      Text(
                                                                        "Danh mục con",
                                                                        maxLines:
                                                                            1,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                12,
                                                                            fontFamily:
                                                                                "Ralway",
                                                                            color:
                                                                                colorInactive,
                                                                            fontWeight:
                                                                                FontWeight.w500),
                                                                      ),
                                                                      Text(
                                                                        listMenu[state.indexCategory]
                                                                            .childMenu[state.indexChildCategory]
                                                                            .name,
                                                                        maxLines:
                                                                            1,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                12,
                                                                            fontFamily:
                                                                                "Ralway",
                                                                            fontWeight:
                                                                                FontWeight.w500),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  flex: 9,
                                                                ),
                                                                Icon(
                                                                  Icons
                                                                      .arrow_drop_down,
                                                                )
                                                              ],
                                                            )),
                                                      ),
                                                      flex: 2,
                                                    ),
                                                    Expanded(
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      FilterPage(
                                                                          1),
                                                            ),
                                                          );
                                                        },
                                                        child: Container(
                                                            height: 30,
                                                            color: Colors.white,
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        8.0),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: <
                                                                  Widget>[
                                                                Expanded(
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: <
                                                                        Widget>[
                                                                      Text(
                                                                        "Sắp xếp/Lọc",
                                                                        maxLines:
                                                                            1,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                12,
                                                                            fontFamily:
                                                                                "Ralway",
                                                                            color:
                                                                                colorInactive,
                                                                            fontWeight:
                                                                                FontWeight.w500),
                                                                      ),
                                                                      Text(
                                                                        "Yêu thích nhất",
                                                                        maxLines:
                                                                            1,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                12,
                                                                            fontFamily:
                                                                                "Ralway",
                                                                            fontWeight:
                                                                                FontWeight.w500),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  flex: 9,
                                                                ),
                                                                Icon(
                                                                  Icons
                                                                      .arrow_drop_down,
                                                                )
                                                              ],
                                                            )),
                                                      ),
                                                      flex: 2,
                                                    )
                                                  ],
                                                ),
                                              );
                                            },
                                          )),
                                    ),
                                  ),
                                ],
                            body: Container(
                                color: colorBackground,
                                child: new EasyRefresh(
                                  key: _easyRefreshKey,
                                  refreshHeader: ConnectorHeader(
                                      key: _connectorHeaderKey,
                                      header: DeliveryHeader(key: _headerKey)),
                                  outerController: _hideButtonController,
                                  child: CustomScrollView(
                                    controller: _hideButtonController,
                                    slivers: <Widget>[
                                      SliverList(
                                        delegate:
                                            SliverChildListDelegate(<Widget>[
                                          DeliveryHeader(key: _headerKey)
                                        ]),
                                      ),
                                      SliverList(
                                        delegate:
                                            SliverChildListDelegate(<Widget>[
                                          detailstate.indexChildCategory == 0
                                              ? BlocBuilder(
                                                  bloc: apiBloc,
                                                  builder: (context,
                                                      ApiState state) {
                                                    return state.listChildMenu
                                                            .isEmpty
                                                        ? Container(
                                                            color:
                                                                colorBackground,
                                                            child:
                                                                ShimmerChildMenu())
                                                        : HeaderDetail();
                                                  },
                                                )
                                              : Container(),
                                          isLoading
                                              ? Container(
                                                  color: Colors.white,
                                                  child: ShimmerPost(),
                                                )
                                              : Container(
                                                  padding: EdgeInsets.all(2.0),
                                                  color: Colors.white,
                                                  child: ListPost()),
                                        ]),
                                      ),
                                    ],
                                  ),
                                  onRefresh: () async {
                                    await new Future.delayed(
                                        const Duration(seconds: 1), () {
                                    });
                                  },
                                ))),
                      ),
                      type: MaterialType.transparency,
                    ))
              ],
            );
          },
        ));
  }

  Future<bool> _onBackPressed() {
    //print("OKDETAIL");
    BlocProvider.of<BottomBarBloc>(context).changeVisible(true);
    focusNode.unfocus();
    if (isSearch) {
      changeDetail();
    } else {
      apiBloc.changeChildMenu(apiBloc.initialState.listChildMenu);
      functionBloc.onBackPressed(_callBack);
      Navigator.pop(context);
    }
    return Future.value(false);
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final PreferredSize child;

  _SliverAppBarDelegate({this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // TODO: implement build
    return child;
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => child.preferredSize.height;

  @override
  // TODO: implement minExtent
  double get minExtent => child.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    return false;
  }
}
