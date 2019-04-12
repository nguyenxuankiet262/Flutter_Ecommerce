import "package:flutter/material.dart";
import 'package:flutter_food_app/const/color_const.dart';

class ListSearchUser extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ListSearchUserState();
}

class _ListSearchUserState extends State<ListSearchUser>
    with AutomaticKeepAliveClientMixin {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  Widget build(BuildContext context) {
    // TODO: implement build
    return isLoading
        ? Container(
            height: MediaQuery.of(context).size.height / 2,
            color: Colors.white,
            child: Center(
                child: CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(colorActive),
            )))
        : ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: 20,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) => Container(
                color: Colors.white,
                child: Column(children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 16.0, right: 16.0, left: 16.0, bottom: index == 19 ? 16.0 : 0.0),
                        width: MediaQuery.of(context).size.width - 64,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {},
                              child: ClipOval(
                                child: Image.asset(
                                  index % 2 == 0
                                      ? 'assets/images/cat.jpg'
                                      : 'assets/images/dog.jpg',
                                  fit: BoxFit.cover,
                                  width: 50.0,
                                  height: 50.0,
                                ),
                              ),
                            ),
                            Container(
                              height: 50,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(
                                              right: 10.0, left: 15.0),
                                          child: Text(
                                            'meowmeow',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              right: 10.0,
                                              bottom: 5.0,
                                              left: 15.0,
                                              top: 5.0),
                                          child: Text(
                                            'Trần Văn Mèo',
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: colorText, fontSize: 14),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ])));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => false;
}
