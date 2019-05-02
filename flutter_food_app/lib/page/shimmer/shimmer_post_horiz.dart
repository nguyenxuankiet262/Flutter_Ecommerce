import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerPostHoriz extends StatelessWidget {
  final int itemCount = 5;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 283,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: itemCount,
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemBuilder: (BuildContext context, int index) => new Card(
            margin: EdgeInsets.only(
                left: 8.0,
                top: 8.0,
                bottom: 8.0,
                right: index == itemCount - 1 ? 8 : 0),
            child: new Container(
              width: 200,
              child: Shimmer.fromColors(
                baseColor: Colors.grey[300],
                highlightColor: Colors.grey[100],
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        height: 170,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(5.0),
                                topLeft: Radius.circular(5.0))),
                      ),
                      Padding(
                          padding: EdgeInsets.only(
                              right: 10.0, top: 10.0, left: 10.0),
                          child: Container(
                            height: 14,
                            color: Colors.white,
                          )
                      ),
                      Padding(
                          padding: EdgeInsets.only(
                              right: 10.0, bottom: 6.0, left: 10.0, top: 5.0),
                          child: Container(
                            height: 12,
                            color: Colors.white,
                          )
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            right: 10.0, left: 10.0, bottom: 10.0, top: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              height: 14,
                              width: 120,
                              color: Colors.white,
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 2.0),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    height: 12,
                                    width: 100,
                                    color: Colors.white,
                                  ),
                                  Container(
                                    width: 30,
                                    margin: EdgeInsets.only(left: 2.0),
                                    height: 12,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
              ),
            )
        ),
      ),
    );
  }
}
