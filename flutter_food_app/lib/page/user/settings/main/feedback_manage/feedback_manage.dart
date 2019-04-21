import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/common/bloc/bottom_bar_bloc.dart';
import 'package:flutter_food_app/common/bloc/text_search_bloc.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter_food_app/const/value_const.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'list_feedback.dart';
import 'feedback/feedback.dart';
import 'search/search.dart';

class FeedBackManage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FeedBackManageState();
}

class FeedBackManageState extends State<FeedBackManage>
    with SingleTickerProviderStateMixin {
  String _text = "";
  bool complete = false;
  bool isSearch = false;
  final myController = TextEditingController();
  TabController _tabController;
  ScrollController _scrollViewController;

  @override
  void initState() {
    super.initState();
    _scrollViewController = new ScrollController();
    _tabController =
        new TabController(vsync: this, length: tabsFeedback.length + 1);
    BlocProvider.of<BottomBarBloc>(context).changeVisible(true);
  }

  @override
  void dispose() {
    _scrollViewController.dispose();
    _tabController.dispose();
    myController.dispose();
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
    return new DefaultTabController(
      length: tabsFeedback.length,
      child: new Scaffold(
        resizeToAvoidBottomPadding: false,
        body: new NestedScrollView(
          controller: _scrollViewController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              new SliverAppBar(
                elevation: 0.5,
                brightness: Brightness.light,
                title: new Text(
                  'Phản hồi',
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
                actions: <Widget>[
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FeedbackPage()));
                    },
                    icon: Icon(
                      Icons.add,
                      color: Colors.black,
                    ),
                  )
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                      margin: EdgeInsets.only(
                          right: 15.0, left: 15.0, top: 80, bottom: 52),
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
                                              hintText: 'Nhập tên phản hồi',
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
                                            "Tìm kiếm phản hồi",
                                            style: TextStyle(
                                                fontFamily: "Raleway",
                                                color: colorInactive,
                                                fontSize: 12),
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                            )),
                ),
                bottom: new TabBar(
                  indicatorColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  labelColor: Colors.black,
                  tabs: new List.generate(tabsFeedback.length, (index) {
                    return new Tab(
                      text: tabsFeedback[index].toUpperCase(),
                    );
                  }),
                  controller: _tabController,
                ),
              ),
            ];
          },
          body: TabBarView(
            controller: _tabController,
            children: new List.generate(tabsFeedback.length, (index) {
              return Stack(
                children: <Widget>[
                  SearchPage(index),
                  Visibility(
                    maintainState: true,
                    visible: isSearch ? false : true,
                    child: ListFeedback(index),
                  )
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
