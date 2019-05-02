import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new ListView.builder(
        itemCount: 1,
        itemBuilder: (BuildContext context, int index) => Shimmer.fromColors(
          child: Container(
            height: 180,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white
            ),
            margin: EdgeInsets.only(
                top: 16.0,
                right: 16.0,
                left: 16.0,
                bottom: 16),
          ),
          baseColor: Colors.grey[300],
          highlightColor: Colors.grey[100],
        )
    );
  }
}
