import 'package:flutter/material.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'noti.dart';

class NotificationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NotificationState();
}

class NotificationState extends State<NotificationPage> with AutomaticKeepAliveClientMixin {
  int itemCount = 1;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        title: Text(
          'Thông báo',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: itemCount == 0
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage(
                                "assets/images/icon_notification.png"),
                          ),
                        ),
                        height: 200,
                        width: 200,
                      ),
                      Text('Nothing to show!'),
                    ],
                  )
                : ListView(
                    children: <Widget>[
                      Container(
                        color: colorContainer,
                        height: 40,
                        width: double.infinity,
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            'MỚI',
                            style: TextStyle(
                                color: colorText, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      ListNoti(),
                      Container(
                        color: colorContainer,
                        height: 40,
                        width: double.infinity,
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            'GẦN ĐÂY',
                            style: TextStyle(
                                color: colorText, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      ListNoti(),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
