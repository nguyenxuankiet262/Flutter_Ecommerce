import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerChildMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 112,
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: 1,
        itemBuilder: (BuildContext context, int index) => Shimmer.fromColors(
          baseColor: Colors.grey[300],
          highlightColor: Colors.grey[100],
          child: Container(
            margin: EdgeInsets.only(top: 16.0, bottom: 16.0, left: 16.0),
            width: 80.0,
            decoration: new BoxDecoration(
              color: Colors.white,
              border: new Border.all(color: Colors.white),
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
          ),
        ),)
    );
  }
}
