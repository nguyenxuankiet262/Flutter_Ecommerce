import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/common/bloc/bottom_bar_bloc.dart';
import 'package:flutter_food_app/const/value_const.dart';
import 'list_feedback.dart';
import 'feedback/feedback.dart';

class FeedBackManage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FeedBackManageState();
}

class FeedBackManageState extends State<FeedBackManage>
    with SingleTickerProviderStateMixin {
  bool complete = false;
  bool isSearch = false;
  final myController = TextEditingController();
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        new TabController(vsync: this, length: tabsFeedback.length + 1);
    BlocProvider.of<BottomBarBloc>(context).changeVisible(true);
  }

  @override
  void dispose() {
    _tabController.dispose();
    myController.dispose();
    super.dispose();
  }

  void changeHome() {
    myController.clear();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new DefaultTabController(
      length: tabsFeedback.length,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          brightness: Brightness.light,
          title: new Text(
            'Phản hồi',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
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
        body: TabBarView(
          controller: _tabController,
          children: new List.generate(tabsFeedback.length, (index) {
            return ListFeedback(index);
          }),
        ),
      ),
    );
  }
}
