import 'package:flutter/material.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerNotification extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) => Container(
            decoration: new BoxDecoration(
                color: Colors.white,
                border: Border(
                    bottom: BorderSide(color: colorInactive, width: 0.5))),
            child: Shimmer.fromColors(
              child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Stack(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: 50.0,
                            height: 50.0,
                            color: Colors.white,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 5.0),
                            child: Container(
                              color: Colors.white,
                              height: 50,
                              width: 70,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                          padding: EdgeInsets.only(
                            left: 60.0,
                            right: 80,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: <Widget>[
                              Container(
                                height: 14,
                                width: MediaQuery.of(context).size.width,
                                color: Colors.white,
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 5.0),
                                height: 14,
                                width: 50,
                                color: Colors.white,
                              )
                            ],
                          )
                      ),
                    ],
                  )),
              baseColor: Colors.grey[300],
              highlightColor: Colors.grey[100],
            )
          ),
    );
  }
}
