import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/common/bloc/api_bloc.dart';
import 'package:flutter_food_app/common/bloc/bottom_bar_bloc.dart';
import 'package:flutter_food_app/common/bloc/favorite_manage_bloc.dart';
import 'package:flutter_food_app/common/bloc/function_bloc.dart';
import 'package:flutter_food_app/common/bloc/text_search_bloc.dart';
import 'package:flutter_food_app/common/state/favorite_manage_state.dart';
import 'package:flutter_food_app/page/filter/common/filter.dart';
import 'package:flutter_food_app/page/shimmer/shimmer_post.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'search/search.dart';
import 'list_post.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'filter/filter.dart';

class FavoriteManage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FavoriteManagementState();
}

class FavoriteManagementState extends State<FavoriteManage> {
  String _text = "";
  bool complete = false;
  bool isSearch = false;
  ScrollController _hideButtonController;
  FunctionBloc functionBloc;
  FocusNode focusNode;
  final myController = TextEditingController();
  FavoriteManageBloc favoriteManageBloc;
  bool isLoading = true;
  ApiBloc apiBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<FunctionBloc>(context).isLoading(_isLoading);
    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        isLoading = false;
      });
    });
    favoriteManageBloc = BlocProvider.of<FavoriteManageBloc>(context);
    apiBloc = BlocProvider.of<ApiBloc>(context);
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
    });
    BlocProvider.of<BottomBarBloc>(context).changeVisible(true);
    functionBloc = BlocProvider.of<FunctionBloc>(context);
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
  }

  void changeHome() {
    setState(() {
      _text = "";
      isSearch = false;
      myController.clear();
    });
    BlocProvider.of<SearchInputBloc>(context).searchInput(1, "");
  }

  AppBar buildAppBar(BuildContext context) {
    return new AppBar(
      elevation: 0.0,
      brightness: Brightness.light,
      title: new Text(
        "Bài viết yêu thích",
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
      child: Stack(
        children: <Widget>[
          Scaffold(
              resizeToAvoidBottomPadding: false,
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(111.0),
                // here the desired height
                child: Column(
                  children: <Widget>[
                    buildAppBar(context),
                    Container(
                        height: 55.0,
                        color: Colors.white,
                        padding: EdgeInsets.only(
                            right: 16.0, left: 16.0, bottom: 14.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    color: colorInactive.withOpacity(0.2)),
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
                                          BlocProvider.of<SearchInputBloc>(
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
                                        hintText: 'Nhập tên bài viết',
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
                                    focusNode.unfocus();
                                    changeHome();
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
                  child: CustomScrollView(
                    controller: _hideButtonController,
                    slivers: <Widget>[
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
                              buildAppBar(context),
                              GestureDetector(
                                onTap: () {
                                  BlocProvider.of<BottomBarBloc>(context)
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
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5.0)),
                                          color: colorInactive
                                              .withOpacity(0.2)),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(
                                            Icons.search,
                                            color: colorInactive,
                                            size: 18,
                                          ),
                                          Container(
                                            margin:
                                            EdgeInsets.only(left: 5.0),
                                            child: Text(
                                              "Tìm kiếm bài viết",
                                              style: TextStyle(
                                                  fontFamily: "Raleway",
                                                  color: colorInactive,
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
                                bloc: favoriteManageBloc,
                                builder: (context, FavoriteManageState state) {
                                  return Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border(
                                            bottom: BorderSide(
                                                color: colorInactive,
                                                width: 0.5))),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          FilterManagement()));
                                            },
                                            child: Container(
                                                height: 30,
                                                margin: EdgeInsets.only(
                                                    top: 8.0,
                                                    bottom: 8.0,
                                                    right: 8.0,
                                                    left: 16.0),
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border(
                                                        right: BorderSide(
                                                            color:
                                                            colorInactive,
                                                            width: 0.5))),
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: <Widget>[
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: <Widget>[
                                                          Text(
                                                            "Danh mục",
                                                            maxLines: 1,
                                                            overflow:
                                                            TextOverflow
                                                                .ellipsis,
                                                            style: TextStyle(
                                                                fontSize:
                                                                12,
                                                                fontFamily:
                                                                "Ralway",
                                                                color:
                                                                colorInactive,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                          ),
                                                          Text(
                                                            apiBloc.currentState.listMenu[state
                                                                .indexCategory]
                                                                .name,
                                                            maxLines: 1,
                                                            overflow:
                                                            TextOverflow
                                                                .ellipsis,
                                                            style: TextStyle(
                                                                fontSize:
                                                                12,
                                                                fontFamily:
                                                                "Ralway",
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                          ),
                                                        ],
                                                      ),
                                                      flex: 9,
                                                    ),
                                                    Icon(
                                                      Icons.arrow_drop_down,
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
                                                      builder: (context) =>
                                                          FilterManagement()));
                                            },
                                            child: Container(
                                                height: 30,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border(
                                                        right: BorderSide(
                                                            color:
                                                            colorInactive,
                                                            width: 0.5))),
                                                margin: EdgeInsets.only(
                                                    top: 8.0, bottom: 8.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: <Widget>[
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: <Widget>[
                                                          Text(
                                                            "Danh mục con",
                                                            maxLines: 1,
                                                            overflow:
                                                            TextOverflow
                                                                .ellipsis,
                                                            style: TextStyle(
                                                                fontSize:
                                                                12,
                                                                fontFamily:
                                                                "Ralway",
                                                                color:
                                                                colorInactive,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                          ),
                                                          Text(
                                                            state.indexCategory == 0
                                                                ? apiBloc.currentState.listMenu[state
                                                                .indexCategory].name
                                                                : apiBloc.currentState.listMenu[state
                                                                .indexCategory]
                                                                .listChildMenu[state
                                                                .indexChildCategory]
                                                                .name,
                                                            maxLines: 1,
                                                            overflow:
                                                            TextOverflow
                                                                .ellipsis,
                                                            style: TextStyle(
                                                                fontSize:
                                                                12,
                                                                fontFamily:
                                                                "Ralway",
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                          ),
                                                        ],
                                                      ),
                                                      flex: 9,
                                                    ),
                                                    Icon(
                                                      Icons.arrow_drop_down,
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
                                                  builder: (context) =>
                                                      FilterPage(2),
                                                ),
                                              );
                                            },
                                            child: Container(
                                                height: 30,
                                                color: Colors.white,
                                                padding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 8.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: <Widget>[
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: <Widget>[
                                                          Text(
                                                            "Sắp xếp/Lọc",
                                                            maxLines: 1,
                                                            overflow:
                                                            TextOverflow
                                                                .ellipsis,
                                                            style: TextStyle(
                                                                fontSize:
                                                                12,
                                                                fontFamily:
                                                                "Ralway",
                                                                color:
                                                                colorInactive,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                          ),
                                                          Text(
                                                            "Yêu thích nhất",
                                                            maxLines: 1,
                                                            overflow:
                                                            TextOverflow
                                                                .ellipsis,
                                                            style: TextStyle(
                                                                fontSize:
                                                                12,
                                                                fontFamily:
                                                                "Ralway",
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                          ),
                                                        ],
                                                      ),
                                                      flex: 9,
                                                    ),
                                                    Icon(
                                                      Icons.arrow_drop_down,
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
                      SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            isLoading
                                ? Container(
                              color: Colors.white,
                              child: ShimmerPost(),
                            )
                                : Container(
                                padding: EdgeInsets.all(2.0),
                                color: Colors.white,
                                child: ListPost()),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                type: MaterialType.transparency,
              ))
        ],
      ),
      onWillPop: () {
        BlocProvider.of<BottomBarBloc>(context).changeVisible(true);
        focusNode.unfocus();
        if (isSearch) {
          changeHome();
        } else {
          Navigator.pop(context);
        }
      },
    );
  }
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
