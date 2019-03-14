import 'package:flutter/material.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'noti_admin_item.dart';

class NotiAdmin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NotiAdminState();
}

class NotiAdminState extends State<NotiAdmin> with AutomaticKeepAliveClientMixin {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _count == 0
        ? Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage("assets/images/icon_notification.png"),
            ),
          ),
          height: 200,
          width: 200,
        ),
        GestureDetector(
          onTap: (){
            setState(() {
              _count = 1;
            });
          },
          child: Text('Nothing to show!'),
        ),
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
            child: GestureDetector(
              onTap: (){
                setState(() {
                  _count = 0;
                });
              },
              child: Text(
                'MỚI',
                style: TextStyle(
                    color: colorText, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        ListNotiAdmin(),
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
        ListNotiAdmin(),
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
