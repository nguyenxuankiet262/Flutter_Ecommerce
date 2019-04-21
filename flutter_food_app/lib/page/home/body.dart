import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/common/bloc/bottom_bar_bloc.dart';
import 'slider.dart';
import 'category.dart';
import 'header.dart';

class BodyContent extends StatefulWidget{
  final Function navigateToPost, navigateToFilter;
  BodyContent(this.navigateToPost, this.navigateToFilter);
  @override
  State<StatefulWidget> createState() => BodyContentState();
}

class BodyContentState extends State<BodyContent> with AutomaticKeepAliveClientMixin{
  ScrollController _hideButtonController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _hideButtonController = new ScrollController();
    _hideButtonController.addListener(() {
      if (_hideButtonController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        BlocProvider.of<BottomBarBloc>(context)
            .changeVisible(false);
      }
      if (_hideButtonController.position.userScrollDirection ==
          ScrollDirection.forward) {
        BlocProvider.of<BottomBarBloc>(context)
            .changeVisible(true);
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _hideButtonController.dispose();
  }

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
      padding: EdgeInsets.only(top: 0.0),
      controller: _hideButtonController,
      children: <Widget>[
        CarouselWithIndicator(),
        Container(
            margin: EdgeInsets.only(top: 16.0, bottom: 16.0),
            child: Container(
              child: HeaderHome(this.navigateToPost,
                  this.navigateToFilter),
            )),
        Container(
          child: ListCategory(this.navigateToPost),
        ),
      ],
    );
  }

}