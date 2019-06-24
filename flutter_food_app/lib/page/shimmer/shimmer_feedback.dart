import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerFeedback extends StatelessWidget {
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
        height: 150,
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: 100,
                            height: 14,
                            color: Colors.white,
                          ),
                          Container(
                            height: 14,
                            width: 50,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Container(
                          height: 14,
                          width: 200,
                          color: Colors.white,
                        )
                      ),
                    ],
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
