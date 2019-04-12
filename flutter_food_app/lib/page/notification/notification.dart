import 'package:flutter/material.dart';
import 'noti_user.dart';
import 'noti_admin.dart';

class NotificationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NotificationState();
}

class NotificationState extends State<NotificationPage> with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        child: Container(
          child: TabBar(
            controller: _tabController,
            indicatorColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            labelColor: Colors.black,
            tabs: [
              Tab(
                child: Text(
                  "Đang theo dõi",
                  style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Tab(
                child: Text(
                  "Hệ thống",
                  style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold
                  ),
                ),
              )
            ],
          ),
          margin: const EdgeInsets.only(top: 30.0),
        ),
        preferredSize: Size.fromHeight(54),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          NotiUser(),
          NotiAdmin(),
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
