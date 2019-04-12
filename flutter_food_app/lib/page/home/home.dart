import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/common/bloc/location_bloc.dart';
import 'package:flutter_food_app/common/bloc/search_bloc.dart';
import 'package:flutter_food_app/common/bloc/text_search_bloc.dart';
import 'package:flutter_food_app/common/state/location_state.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'body.dart';
import 'package:flutter_food_app/page/search/search.dart';

class MyHomePage extends StatefulWidget {
  Function navigateToPost, navigateToFilter, navigateToSearch;

  MyHomePage(this.navigateToPost, this.navigateToFilter, this.navigateToSearch);

  @override
  State<StatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with AutomaticKeepAliveClientMixin {
  String _text = "";
  bool complete = false;
  bool isSearch = false;
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myController.dispose();
    super.dispose();
  }


  void navigateToPost() {
    this.widget.navigateToPost();
  }

  void navigateToFilter() {
    this.widget.navigateToFilter();
  }

  void navigateToSearch() {
    this.widget.navigateToSearch();
  }

  void changeHome() {
    _text = "";
    isSearch = false;
    BlocProvider.of<SearchInputBloc>(context).searchInput(1, "");
    myController.clear();
    BlocProvider.of<SearchBloc>(context).changePage();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
          resizeToAvoidBottomPadding: false,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(111.0), // here the desired height
            child: Column(
              children: <Widget>[
                AppBar(
                  brightness: Brightness.light,
                  title: Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width -
                        MediaQuery
                            .of(context)
                            .size
                            .width / 2 +
                        7,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 5.0),
                          child: Image.asset('assets/images/logo.png'),
                        ),
                        new Text(
                          'Anzi',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                  iconTheme: IconThemeData(
                    color: Colors.black, //change your color here
                  ),
                  backgroundColor: Colors.white,
                  actions: <Widget>[
                    GestureDetector(
                        onTap: () {
                          navigateToSearch();
                        },
                        child: Container(
                          color: Colors.white,
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.only(right: 16),
                              child: Container(
                                  padding: EdgeInsets.only(
                                      top: 3.0,
                                      bottom: 3.0,
                                      right: 10.0,
                                      left: 10.0),
                                  height: 31,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(100.0)),
                                      border: Border.all(
                                          color: colorActive, width: 0.5)),
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(right: 5.0),
                                        child: Icon(
                                          Icons.location_on,
                                          color: colorActive,
                                          size: 15,
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            "Chọn khu vực",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 10,
                                                fontFamily: "Ralway"),
                                          ),
                                          BlocBuilder(
                                              bloc: BlocProvider.of<
                                                  LocationBloc>(
                                                  context),
                                              builder:
                                                  (context,
                                                  LocationState state) {
                                                return Container(
                                                    width: 70,
                                                    child: Text(
                                                      state.indexProvince == 0
                                                          ? state
                                                          .nameCities[state
                                                          .indexCity]
                                                          : state
                                                          .nameProvinces[state
                                                          .indexCity][state
                                                          .indexProvince],
                                                      style: TextStyle(
                                                          color: colorActive,
                                                          fontSize: 10,
                                                          fontFamily: "Ralway"),
                                                      overflow:
                                                      TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                    ));
                                              }),
                                        ],
                                      ),
                                    ],
                                  )),
                            ),
                          ),
                        ))
                  ],
                ),
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
                                      BlocProvider.of<SearchInputBloc>(context)
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
                                  changeHome();
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
          backgroundColor: colorBackground,
          body: Stack(
            children: <Widget>[
              SearchPage(),
              Visibility(
                maintainState: true,
                visible: isSearch ? false : true,
                child: Container(
                  color: colorBackground,
                  child: BodyContent(this.navigateToPost, this.navigateToFilter),
                )
              )
            ],
          )

      ),
      onWillPop: () {
        if (isSearch) {
          setState(() {
            changeHome();
          });
        }
      },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
