import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 2,
      itemBuilder: (BuildContext context, int index) => Container(
        color: Colors.white,
        padding: EdgeInsets.only(top: 16.0, right: 16.0, left: 16.0, bottom: index == 1 ? 32 : 16),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300],
          highlightColor: Colors.grey[100],
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 50,
                width: 50,
                color: Colors.white,
              ),
              Padding(
                  padding: EdgeInsets.only(left: 16.0, top: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                     Container(
                       height: 14,
                       width: 100,
                       color: Colors.white,
                     ),
                      Padding(
                        padding: EdgeInsets.only(top: 4),
                        child: Container(
                          height: 12,
                          width: 150,
                          color: Colors.white,
                        )
                      )
                    ],
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}
