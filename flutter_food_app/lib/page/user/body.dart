import "package:flutter/material.dart";
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter_food_app/page/notification/noti.dart';

class Body extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => BodyState();
}

class BodyState extends State<Body> with SingleTickerProviderStateMixin{
  TabController _tabController;
  int index = 0;
  int lengthComment = 0;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 2);
    _tabController.addListener(() {
      if(_tabController.index == 0){
        setState(() {
          index = 0;
        });
      }
      else{
        setState(() {
          index = 1;
        });
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  final double height = 6 * 82.0;
  @override
  Widget build(BuildContext context) {
    final double heightRating = MediaQuery.of(context).size.height - 130;
    return Container(
      height: index == 0 ? height : lengthComment == 0 ? heightRating : lengthComment * 300.0,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: TabBar(
            controller: _tabController,
            indicatorColor: Colors.black,
            tabs: [
              Tab(icon: Icon(Icons.collections, color: Colors.black,)),
              Tab(icon: Icon(Icons.star, color: Colors.black,)),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            ListNoti(),
            lengthComment == 0 ?
            Center(
              child: Text('No rating'),
            )
                : Center(
              child: Text('No ratingasdasd'),
            )
          ],
        ),
      ),
    );
  }
}