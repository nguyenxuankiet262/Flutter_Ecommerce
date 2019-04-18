import 'package:flutter/material.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'feedback_item.dart';

class ListFeedback extends StatefulWidget {
  final int index;

  ListFeedback(this.index);

  @override
  State<StatefulWidget> createState() => ListFeedbackState();
}

class ListFeedbackState extends State<ListFeedback> with AutomaticKeepAliveClientMixin{
  int itemCount;
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        isLoading = false;
      });
    });
    if (widget.index == 0) {
      itemCount = 10;
    } else {
      itemCount = 5;
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return isLoading
        ? Container(
            height: MediaQuery.of(context).size.height / 2,
            color: colorBackground,
            child: Center(
                child: CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(colorActive),
            )))
        : Container(
            color: colorBackground,
            child: itemCount == 0
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image:
                                AssetImage("assets/images/icon_heartbreak.png"),
                          ),
                        ),
                        height: 200,
                        width: 200,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {});
                        },
                        child: Text('Chưa có phản hồi!'),
                      ),
                    ],
                  )
                : ListView.builder(
                    padding: EdgeInsets.only(top: 0),
                    shrinkWrap: true,
                    itemCount: itemCount,
                    itemBuilder: (BuildContext context, int index) => Container(
                      margin: EdgeInsets.only(top: index == 0 ? 10 : 5.0, bottom: index == itemCount - 1 ? 5.0 : 0.0),
                      child: FeedbackItem(widget.index),
                    )
            )
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
