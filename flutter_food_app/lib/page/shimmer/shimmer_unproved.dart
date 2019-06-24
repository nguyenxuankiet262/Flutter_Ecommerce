import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerUnprovedPost extends StatelessWidget {
  final int itemCount = 10;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 2,
      itemBuilder: (BuildContext context, int index) => Container(
        color: Colors.white,
        height: 632,
        margin: EdgeInsets.only(
            top: 16.0,
            bottom: index == 1
          ? 16.0
          : 0.0),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300],
        highlightColor: Colors.grey[100],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: 16.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                        BorderRadius.all(Radius.circular(100)),
                    ),
                    width: 50.0,
                    height: 50.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 100,
                        height: 14,
                        color: Colors.white,
                      ),
                      Padding(
                          padding: EdgeInsets.only(top: 2.0),
                          child: Container(
                            height: 14,
                            width: 50,
                            color: Colors.white,
                          ))
                    ],
                  )
                ],
              )
            ),
            Padding(
              padding: EdgeInsets.only(top: 130),
              child: Container(
                color: Colors.white,
                height: 300,
                width: double.infinity,
              ),
            )
          ],
        ),
      ),
      ),
    );
  }
}
