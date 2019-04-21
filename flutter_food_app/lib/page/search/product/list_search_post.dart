import "package:flutter/material.dart";
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ListSearchPost extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ListSearchPostState();
}

class _ListSearchPostState extends State<ListSearchPost>
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
                child: SpinKitFadingCircle(
                  color: colorActive,
                  size: 50.0,
                )))
        : ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: 10,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) => Container(
                child: Column(children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 16.0, right: 16.0, left: 16.0, bottom: index == 9 ? 16.0 : 0.0),
                        width: MediaQuery.of(context).size.width - 64,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                child: ClipRRect(
                                  child: Image.asset(
                                    'assets/images/carrot.jpg',
                                    fit: BoxFit.fill,
                                  ),
                                  borderRadius: new BorderRadius.all(
                                      Radius.circular(5.0)),
                                ),
                                width: 105,
                                height: 90,
                              ),
                            ),
                            Flexible(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    height: 65,
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
                                            'Cà rốt tươi ngon đây! Mại zô!',
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
                                            '123A Đường Lên Đỉnh Olympia, F15, Q.TB, TP.HCM',
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: colorText, fontSize: 14),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: 4.0,
                                      right: 10.0,
                                      left: 15.0,
                                    ),
                                    child: Text(
                                      "100.000 VNĐ",
                                      style: TextStyle(
                                          color: colorActive,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17.0),
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
