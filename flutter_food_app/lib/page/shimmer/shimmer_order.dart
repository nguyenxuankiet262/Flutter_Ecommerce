import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerOrder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StaggeredGridView.countBuilder(
        padding: EdgeInsets.only(top: 5),
        crossAxisCount: 2,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 2,
        itemBuilder: (BuildContext context, int index) => Card(
                child: Container(
              padding: EdgeInsets.all(16.0),
              color: Colors.white,
              child: Shimmer.fromColors(
                  baseColor: Colors.grey[300],
                  highlightColor: Colors.grey[100],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width / 2,
                            height: 14,
                            color: Colors.white,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            width: MediaQuery.of(context).size.width / 2.5,
                            height: 14,
                            color: Colors.white,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            width: MediaQuery.of(context).size.width / 2,
                            height: 14,
                            color: Colors.white,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            width: MediaQuery.of(context).size.width / 3,
                            height: 14,
                            color: Colors.white,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            width: MediaQuery.of(context).size.width / 2.5,
                            height: 14,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            width: 80,
                            height: 14,
                            color: Colors.white,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5.0),
                            height: 12,
                            width: 50,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ],
                  )),
            )),
        staggeredTileBuilder: (int index) => new StaggeredTile.fit(2));
  }
}
