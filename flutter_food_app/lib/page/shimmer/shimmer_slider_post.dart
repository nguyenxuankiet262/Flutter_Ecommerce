import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerSliderPost extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Shimmer.fromColors(
      baseColor: Colors.grey[300],
      highlightColor: Colors.grey[100],
      child: Container(
        height: 300,
        color: Colors.white,
      ),
    );
  }
}
