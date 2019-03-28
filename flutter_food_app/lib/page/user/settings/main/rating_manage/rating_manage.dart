import 'package:flutter/material.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter_food_app/const/value_const.dart';
import 'list_rating.dart';

class RatingManage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RatingManageState();
}

class RatingManageState extends State<RatingManage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  ScrollController _scrollViewController;

  @override
  void initState() {
    super.initState();
    _scrollViewController = new ScrollController();
    _tabController =
    new TabController(vsync: this, length: tabsRating.length + 1);
  }

  @override
  void dispose() {
    _scrollViewController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new DefaultTabController(
      length: tabsRating.length,
      child: new Scaffold(
        body: new NestedScrollView(
          controller: _scrollViewController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              new SliverAppBar(
                brightness: Brightness.light,
                title: new Text(
                  'Đánh giá',
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
                expandedHeight: 150,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    margin: EdgeInsets.only(right: 15.0, left: 15.0, top: 80,bottom: 50),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        color: colorInactive.withOpacity(0.2)),
                    child: Container(
                        margin: EdgeInsets.only(left: 15.0),
                        child: Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(right: 10.0),
                              child: Icon(
                                Icons.search,
                                color: Colors.grey,
                                size: 14,
                              ),
                            ),
                            Text(
                              "Tìm kiếm đánh giá",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: colorInactive,
                                  fontFamily: "Ralway"
                              ),
                            )
                          ],
                        )
                    ),
                  ),
                ),
                forceElevated: innerBoxIsScrolled,
                bottom: new TabBar(
                  isScrollable: true,
                  indicatorColor: Colors.white,
                  unselectedLabelColor: Colors.grey,
                  labelColor: Colors.black,
                  tabs: new List.generate(tabsRating.length, (index) {
                    return new Tab(
                      text: tabsRating[index].toUpperCase(),
                    );
                  }),
                  controller: _tabController,
                ),
              ),
            ];
          },
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            controller: _tabController,
            children: new List.generate(tabsRating.length, (index) {
              return ListRating(index);
            }),
          ),
        ),
      ),
    );
  }
}
