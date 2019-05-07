import 'package:flutter/material.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 2,
        itemBuilder: (BuildContext context, int index) => Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            margin: EdgeInsets.only(top: 16.0, right: 16.0, left: 16.0),
            child: Shimmer.fromColors(
              child: Column(children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 15.0, left: 15.0),
                      width: MediaQuery.of(context).size.width - 100,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                    new BorderRadius.all(Radius.circular(5.0)),
                                color: Colors.white),
                            width: 105,
                            height: 90,
                          ),
                          Flexible(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  height: 65,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(
                                          right: 10.0,
                                          bottom: 5.0,
                                          left: 15.0,
                                        ),
                                        height: 14,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                1 /
                                                2,
                                        color: Colors.white,
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(
                                              right: 10.0,
                                              bottom: 5.0,
                                              left: 15.0,
                                              top: 5.0),
                                          child: Container(
                                            height: 14,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                1 /
                                                2,
                                            color: Colors.white,
                                          )),
                                    ],
                                  ),
                                ),
                                Padding(
                                    padding: EdgeInsets.only(
                                      top: 4.0,
                                      right: 10.0,
                                      left: 15.0,
                                    ),
                                    child: Container(
                                      height: 14,
                                      width: 100,
                                      color: Colors.white,
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 25,
                      height: 90,
                      margin:
                          EdgeInsets.only(right: 15.0, top: 15.0, bottom: 15.0),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(color: colorInactive, width: 0.5)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          height: 40,
                          margin: EdgeInsets.only(right: 8.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                  right: BorderSide(
                                      color: colorInactive, width: 0.5))),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 40,
                          margin: EdgeInsets.only(left: 8.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                  right: BorderSide(
                                      color: colorInactive, width: 0.5))),
                        ),
                        flex: 1,
                      ),
                    ],
                  ),
                ),
              ]),
              baseColor: Colors.grey[300],
              highlightColor: Colors.grey[100],
            )));
  }
}
