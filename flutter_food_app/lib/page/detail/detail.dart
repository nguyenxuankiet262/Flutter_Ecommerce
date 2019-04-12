import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/common/bloc/bottom_bar_bloc.dart';
import 'package:flutter_food_app/common/bloc/search_bloc.dart';
import 'package:flutter_food_app/common/bloc/text_search_bloc.dart';
import 'package:flutter_food_app/page/search/search.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter_food_app/const/value_const.dart';
import 'package:flutter_food_app/page/detail/menu.dart';

class ListAllPost extends StatefulWidget {
  Function navigateToPost, navigateToFilter;
  int index;

  ListAllPost(this.navigateToPost, this.navigateToFilter, this.index);

  @override
  State<StatefulWidget> createState() => _ListAllPostState();
}

class _ListAllPostState extends State<ListAllPost> {
  String _text = "";
  bool complete = false;
  bool isSearch = false;
  final myController = TextEditingController();

  void changeDetail() {
    _text = "";
    isSearch = false;
    BlocProvider.of<SearchInputBloc>(context).searchInput(1, "");
    myController.clear();
    BlocProvider.of<SearchBloc>(context).changePage();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<BottomBarBloc>(context).changeVisible(true);
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myController.dispose();
    super.dispose();
  }

  AppBar buildAppBar(BuildContext context) {
    return new AppBar(
      elevation: 0.0,
      brightness: Brightness.light,
      title: new Text(
        listMenu[this.widget.index].name,
        style: TextStyle(
            fontWeight: FontWeight.bold, color: Colors.black, fontSize: 17),
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(
        color: Colors.black, //change your color here
      ),
      leading: GestureDetector(
        child: Icon(Icons.arrow_back),
        onTap: () {
          if (!isSearch) {
            Navigator.pop(context);
          } else {
            changeDetail();
            Navigator.pop(context);
          }
        },
      ),
      actions: <Widget>[
        GestureDetector(
            onTap: () {
              this.widget.navigateToFilter();
            },
            child: Container(
              color: Colors.white,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(right: 16),
                  child: Container(
                      padding: EdgeInsets.only(
                          top: 3.0, bottom: 3.0, right: 10.0, left: 10.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.all(Radius.circular(100.0)),
                          border: Border.all(color: colorActive, width: 0.5)),
                      child: Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(right: 5.0),
                            child: Icon(
                              FontAwesomeIcons.filter,
                              color: colorActive,
                              size: 10,
                            ),
                          ),
                          Text(
                            "Lọc",
                            style: TextStyle(
                                color: colorActive,
                                fontSize: 12,
                                fontFamily: "Ralway"),
                          )
                        ],
                      )),
                ),
              ),
            )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      child: Scaffold(
          resizeToAvoidBottomPadding: false,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(111.0), // here the desired height
            child: Column(
              children: <Widget>[
                buildAppBar(context),
                isSearch
                    ? Container(
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
                                    setState(() {
                                      changeDetail();
                                    });
                                  },
                                ))
                          ],
                        ))
                    : GestureDetector(
                        onTap: () {
                          BlocProvider.of<SearchBloc>(context).changePage();
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
                      )
              ],
            ),
          ),
          body: Stack(
            children: <Widget>[
              SearchPage(),
              Visibility(
                  maintainState: true,
                  visible: isSearch ? false : true,
                  child: Container(
                    color: colorBackground,
                    child: HeaderDetail(
                        this.widget.navigateToPost, this.widget.index),
                  ))
            ],
          )),
      onWillPop: () {
        changeDetail();
      },
    );
  }
}
