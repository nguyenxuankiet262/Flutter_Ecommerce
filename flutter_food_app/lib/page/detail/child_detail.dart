import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/common/bloc/bottom_bar_bloc.dart';
import 'package:flutter_food_app/common/bloc/function_bloc.dart';
import 'package:flutter_food_app/common/bloc/search_bloc.dart';
import 'package:flutter_food_app/common/bloc/text_search_bloc.dart';
import 'package:flutter_food_app/page/search/search.dart';
import 'package:flutter_food_app/page/shimmer/shimmer_post.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter_food_app/const/value_const.dart';
import 'list_post.dart';

class ChildDetail extends StatefulWidget {
  final int indexCategory;
  final int indexChild;

  ChildDetail(this.indexCategory, this.indexChild);

  @override
  State<StatefulWidget> createState() => _ChildDetailState();
}

class _ChildDetailState extends State<ChildDetail> {
  String _text = "";
  bool complete = false;
  bool isSearch = false;
  bool isLoading = true;
  final myController = TextEditingController();
  FunctionBloc functionBloc;
  ScrollController _hideButtonController;

  void changeDetail() {
    setState(() {
      _text = "";
      isSearch = false;
      myController.clear();
    });
    BlocProvider.of<SearchInputBloc>(context).searchInput(1, "");
    BlocProvider.of<SearchBloc>(context).changePage();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        isLoading = false;
      });
    });
    functionBloc = BlocProvider.of<FunctionBloc>(context);
    BlocProvider.of<BottomBarBloc>(context).changeVisible(true);
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
    // Clean up the controller when the Widget is disposed
    myController.dispose();
    _hideButtonController.dispose();
    super.dispose();
  }

  AppBar buildAppBar(BuildContext context) {
    return new AppBar(
      elevation: 0.0,
      brightness: Brightness.light,
      title: new Text(
        listMenu[this.widget.indexCategory]
            .childMenu[this.widget.indexChild]
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
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: NestedScrollView(
          controller: _hideButtonController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              new SliverAppBar(
                automaticallyImplyLeading: false,
                elevation: 0.5,
                brightness: Brightness.light,
                backgroundColor: Colors.white,
                pinned: true,
                floating: true,
                snap: true,
                expandedHeight: 150,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.pin,
                  background: Column(
                    children: <Widget>[
                      buildAppBar(context),
                      isSearch
                          ? Container(
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
                                            autofocus: true,
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
                                          changeDetail();
                                        },
                                      ))
                                ],
                              ))
                          : GestureDetector(
                              onTap: () {
                                BlocProvider.of<SearchBloc>(context)
                                    .changePage();
                                setState(() {
                                  isSearch = true;
                                });
                              },
                              child: Container(
                                height: 55.0,
                                color: Colors.white,
                                padding: EdgeInsets.only(
                                    right: 16.0, left: 16.0, bottom: 14.0),
                                child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5.0)),
                                        color: colorInactive.withOpacity(0.2)),
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
                            )
                    ],
                  ),
                ),
                forceElevated: innerBoxIsScrolled,
                bottom: PreferredSize(
                    preferredSize: Size.fromHeight(46),
                    child: Container(
                      color: Colors.white,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: GestureDetector(
                              onTap: () {},
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
                                              color: colorInactive,
                                              width: 0.5))),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              "Danh mục",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontFamily: "Ralway",
                                                  color: colorInactive,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Text(
                                              "Thực phẩm bổ dưỡng",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontFamily: "Ralway",
                                                  fontWeight: FontWeight.w500),
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
                              onTap: () {},
                              child: Container(
                                  height: 30,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border(
                                          right: BorderSide(
                                              color: colorInactive,
                                              width: 0.5))),
                                  margin:
                                      EdgeInsets.only(top: 8.0, bottom: 8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              "Danh mục con",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontFamily: "Ralway",
                                                  color: colorInactive,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Text(
                                              "Rau - củ - quả",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontFamily: "Ralway",
                                                  fontWeight: FontWeight.w500),
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
                              onTap: () {},
                              child: Container(
                                  height: 30,
                                  color: Colors.white,
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              "Sắp xếp/Lọc",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontFamily: "Ralway",
                                                  color: colorInactive,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Text(
                                              "Yêu thích nhất",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontFamily: "Ralway",
                                                  fontWeight: FontWeight.w500),
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
                    )),
              )
            ];
          },
          body: Stack(
            children: <Widget>[
              SearchPage(),
              Visibility(
                  maintainState: true,
                  visible: isSearch ? false : true,
                  child: Container(
                    color: isLoading ? Colors.white : colorBackground,
                    child: ListView(
                      padding: EdgeInsets.only(top: 0.0),
                      physics: NeverScrollableScrollPhysics(),
                      children: <Widget>[
                        isLoading
                            ? ShimmerPost()
                            : Container(
                                padding: EdgeInsets.all(2.0),
                                child: ListPost()),
                      ],
                    ),
                  ))
            ],
          )),
    );
  }
}
