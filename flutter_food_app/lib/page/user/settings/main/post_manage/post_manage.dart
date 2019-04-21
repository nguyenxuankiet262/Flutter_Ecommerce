import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/common/bloc/bottom_bar_bloc.dart';
import 'package:flutter_food_app/common/bloc/text_search_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'search/search.dart';
import 'list_post.dart';
import 'package:flutter_food_app/const/color_const.dart';

class PostManage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PostManageState();
}

class PostManageState extends State<PostManage> {
  String _text = "";
  bool complete = false;
  bool isSearch = false;
  ScrollController _scrollViewController;
  final myController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollViewController = new ScrollController();
    BlocProvider.of<BottomBarBloc>(context).changeVisible(true);
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myController.dispose();
    _scrollViewController.dispose();
    super.dispose();
  }

  void changeHome() {
    _text = "";
    isSearch = false;
    BlocProvider.of<SearchInputBloc>(context).searchInput(1, "");
    myController.clear();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: NestedScrollView(
        controller: _scrollViewController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            new SliverAppBar(
              elevation: 0.5,
              brightness: Brightness.light,
              title: new Text(
                "Quản lý bài viết",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black),
              ),
              iconTheme: IconThemeData(
                color: Colors.black, //change your color here
              ),
              centerTitle: true,
              backgroundColor: Colors.white,
              pinned: true,
              floating: true,
              snap: true,
              expandedHeight: 150,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                    margin: EdgeInsets.only(right: 15.0, left: 15.0, top: 80,bottom: 50),
                    child: isSearch
                        ? Container(
                        height: 55.0,
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(right: 16.0),
                                padding:
                                EdgeInsets.symmetric(vertical: 3.0),
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
                                              myController
                                                  .clear();
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
                                              fontWeight:
                                              FontWeight.w600,
                                              fontFamily: "Ralway"),
                                        ),
                                      )),
                                  onTap: () {
                                    setState(() {
                                      changeHome();
                                    });
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
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(5.0)),
                                color:
                                colorInactive.withOpacity(0.2)),
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
                        child: Container(
                          height: 30,
                          margin: EdgeInsets.only(top: 8.0, bottom: 8.0, right: 8.0, left: 16.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border(right: BorderSide(color: colorInactive, width: 0.5))
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "Danh mục",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: "Ralway",
                                          color: colorInactive,
                                          fontWeight: FontWeight.w500
                                      ),
                                    ),
                                    Text(
                                      "Thực phẩm bổ dưỡng",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: "Ralway",
                                          fontWeight: FontWeight.w500
                                      ),
                                    ),
                                  ],
                                ),
                                flex: 9,
                              ),
                              Icon(
                                Icons.arrow_drop_down,
                              )
                            ],
                          )
                        ),
                        flex: 3,
                      ),
                      Expanded(
                        child: Container(
                          height: 30,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border(right: BorderSide(color: colorInactive, width: 0.5))
                          ),
                          margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "Danh mục con",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: "Ralway",
                                          color: colorInactive,
                                          fontWeight: FontWeight.w500
                                      ),
                                    ),
                                    Text(
                                      "Rau - củ - quả",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: "Ralway",
                                          fontWeight: FontWeight.w500
                                      ),
                                    ),
                                  ],
                                ),
                                flex: 9,
                              ),
                              Icon(
                                Icons.arrow_drop_down,
                              )
                            ],
                          )
                        ),
                        flex: 2,
                      ),
                      Expanded(
                        child: Container(
                          height: 30,
                          color: Colors.white,
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "Sắp xếp/Lọc",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: "Ralway",
                                          color: colorInactive,
                                          fontWeight: FontWeight.w500
                                      ),
                                    ),
                                    Text(
                                      "Yêu thích nhất",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: "Ralway",
                                          fontWeight: FontWeight.w500
                                      ),
                                    ),
                                  ],
                                ),
                                flex: 9,
                              ),
                              Icon(
                                Icons.arrow_drop_down,
                              )
                            ],
                          )
                        ),
                        flex: 2,
                      )
                    ],
                  ),
                )
              ),
            )
          ];
        },
        body: Stack(children: <Widget>[
          SearchPage(),
          Visibility(
            maintainState: true,
            visible: isSearch ? false : true,
            child: ListPost(),
          )
        ]),
      ),
    );
  }
}
