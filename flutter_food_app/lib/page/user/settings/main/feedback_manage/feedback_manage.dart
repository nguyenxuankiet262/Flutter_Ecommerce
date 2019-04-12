import 'package:flutter/material.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter_food_app/const/value_const.dart';
import 'list_feedback.dart';
import 'feedback/feedback.dart';

class FeedBackManage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => FeedBackManageState();
}

class FeedBackManageState extends State<FeedBackManage> with SingleTickerProviderStateMixin{
  TabController _tabController;
  ScrollController _scrollViewController;

  @override
  void initState() {
    super.initState();
    _scrollViewController = new ScrollController();
    _tabController =
    new TabController(vsync: this, length: tabsFeedback.length + 1);
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
      length: tabsFeedback.length,
      child: new Scaffold(
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
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => FeedbackPage()));
                    },
                    icon: Icon(
                      Icons.add,
                      color: Colors.black,
                    ),
                  )
                ],
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
                              "Tìm kiếm phản hồi",
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
              return ListFeedback(index);
            }),
          ),
        ),
      ),
    );
  }

}