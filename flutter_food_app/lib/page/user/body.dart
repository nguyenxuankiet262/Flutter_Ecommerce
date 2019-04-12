import "package:flutter/material.dart";
import 'package:flutter_food_app/const/color_const.dart';
import 'list_post.dart';
import 'list_rating.dart';
import 'info_item.dart';

class Body extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BodyState();
}

class BodyState extends State<Body> with SingleTickerProviderStateMixin {
  int index = 0;
  TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = new TabController(vsync: this, length: 3);
    _tabController.addListener(() {
      if (_tabController.index == 0) {
        setState(() {
          index = 0;
        });
      } else if (_tabController.index == 1) {
        setState(() {
          index = 1;
        });
      } else {
        setState(() {
          index = 2;
        });
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _fragments = [
      Container(
        padding: EdgeInsets.all(2.0),
        child: ListPost(),
      ),
      ListRating(),
      InfoItem(),
    ];
    return ListView(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: <Widget>[
        Container(
          height: 54,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(bottom: BorderSide(color: colorInactive,width: 0.5)),
          ),
          child: TabBar(
            controller: _tabController,
            indicatorColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            labelColor: Colors.black,
            tabs: [
              Tab(
                child: Text(
                  "Bài viết",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),),
              Tab(
                child: Text(
                  "Đánh giá",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),),
              Tab(
                child: Text(
                  "Thông tin",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
        Container(
          color: index == 2 ? Colors.white : colorBackground,
          child: _fragments[index],
        ),
      ],
    );
  }
}
