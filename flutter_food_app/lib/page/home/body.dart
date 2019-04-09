import 'package:flutter/material.dart';
import 'slider.dart';
import 'category.dart';
import 'header.dart';

class BodyContent extends StatefulWidget{
  Function navigateToPost, navigateToFilter;
  BodyContent(this.navigateToPost, this.navigateToFilter);
  @override
  State<StatefulWidget> createState() => BodyContentState();
}

class BodyContentState extends State<BodyContent> with AutomaticKeepAliveClientMixin{
  void navigateToPost() {
    this.widget.navigateToPost();
  }

  void navigateToFilter() {
    this.widget.navigateToFilter();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView(
      children: <Widget>[
        CarouselWithIndicator(),
        Container(
            margin: EdgeInsets.only(top: 16.0, bottom: 16.0),
            child: Container(
              child: HeaderHome(this.navigateToPost,
                  this.navigateToFilter),
            )),
        Container(
          padding: EdgeInsets.only(bottom: 54),
          child: ListCategory(this.navigateToPost),
        ),
      ],
    );
  }

}