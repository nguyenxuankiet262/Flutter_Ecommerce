import "package:flutter/material.dart";
import 'list_post.dart';
import 'list_rating.dart';

class Body extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BodyState();
}

class BodyState extends State<Body> with SingleTickerProviderStateMixin {
  TabController _tabController;
  int index = 0;
  int lengthComment = 5;
  int lengthPost = 10;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 2);
    _tabController.addListener(() {
      if (_tabController.index == 0) {
        setState(() {
          index = 0;
        });
      } else {
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

  @override
  Widget build(BuildContext context) {
    final double heightEmpty = MediaQuery.of(context).size.height - 300;
    return Container(
      height: index == 0
          ? (lengthPost == 0
              ? heightEmpty
              : 60 + ((lengthPost / 2).round() * 297.0))
          : (lengthComment == 0 ? heightEmpty : 60 + lengthComment * 83.0),
      child: Scaffold(
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
                  icon: Icon(
                Icons.collections,
              )),
              Tab(
                  icon: Icon(
                Icons.star,
              )),
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
          ],
        ),
      ),
    );
  }
}
