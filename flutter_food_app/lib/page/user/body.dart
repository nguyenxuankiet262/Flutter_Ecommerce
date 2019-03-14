import "package:flutter/material.dart";
import 'list_post.dart';
import 'list_rating.dart';
import 'info_item.dart';

class Body extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BodyState();
}

class BodyState extends State<Body> with SingleTickerProviderStateMixin {
  TabController _tabController;
  int index = 0;
  int lengthComment = 5;
  int lengthPost = 13;

  @override
  void initState() {
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
    final double height = 400.0;
    return Container(
      height: index == 0
          ? (lengthPost == 0 ? height : 60 + ((lengthPost / 2).round() * 297.0))
          : index == 1
              ? (lengthComment == 0 ? height : 60 + lengthComment * 83.0)
              : height,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: TabBar(
            controller: _tabController,
            indicatorColor: Colors.white,
            unselectedLabelColor: Colors.grey,
            labelColor: Colors.black,
            tabs: [
              Tab(
                  child: Text(
                    "Bài viết",
                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
                  ),),
              Tab(
                  child: Text(
                    "Đánh giá",
                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
                  ),),
              Tab(
                child: Text(
                  "Thông tin",
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: _tabController,
          children: [
            lengthPost == 0
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.image,
                        color: Colors.grey,
                        size: 200,
                      ),
                      Text(
                        'Chưa có bài viết nào',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    ],
                  )
                : ListPost(),
            lengthComment == 0
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.star,
                        color: Colors.grey,
                        size: 200,
                      ),
                      Text(
                        'Chưa có đánh giá nào',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    ],
                  )
                : ListRating(),
            InfoItem(),
          ],
        ),
      ),
    );
  }
}
