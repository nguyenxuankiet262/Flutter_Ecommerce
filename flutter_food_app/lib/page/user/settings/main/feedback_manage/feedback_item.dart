import 'package:flutter/material.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:shimmer/shimmer.dart';

class FeedbackItem extends StatefulWidget {
  int index;

  FeedbackItem(this.index);

  @override
  State<StatefulWidget> createState() => FeedBackItemState();
}

class FeedBackItemState extends State<FeedbackItem> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
        child: Container(
      padding: EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
              width: MediaQuery.of(context).size.width - 150,
              child: Text(
                "Đừng nghĩ cứ học Marketing thì có nghĩa là có thể Treo đầu dê - Bán thịt chó!",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12.0,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              )),
          Shimmer.fromColors(
              baseColor: widget.index == 1 ? Colors.black : colorActive,
              highlightColor: widget.index != 1 ? Colors.yellow : colorInactive,
              child: Text(
                widget.index != 1 ? 'Đã trả lời' : "Chưa trả lời",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              )),
        ],
      ),
    ));
  }
}
