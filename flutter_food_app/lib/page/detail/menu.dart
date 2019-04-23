import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/common/bloc/bottom_bar_bloc.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter_food_app/const/value_const.dart';
import 'package:flutter_food_app/page/shimmer/shimmer_post.dart';
import 'list_post.dart';
import 'child_detail.dart';

class HeaderDetail extends StatefulWidget {
  final int index;

  HeaderDetail(this.index);

  @override
  State<StatefulWidget> createState() => HeaderDetailState();
}

class HeaderDetailState extends State<HeaderDetail> {
  bool isLoading = true;
  ScrollController _hideButtonController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        isLoading = false;
      });
    });
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

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        controller: _hideButtonController,
        children: <Widget>[
          Container(
            height: 112,
            decoration: BoxDecoration(
                color: colorBackground,
                border: Border(bottom: BorderSide(width: 0.5, color: colorInactive.withOpacity(0.5)))
            ),
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: listMenu[widget.index].childMenu.length - 1,
              itemBuilder: (BuildContext context, int index) => GestureDetector(
                onTap: () {
                  setState(() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChildDetail(widget.index, index + 1)),
                    );
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(top: 16.0, bottom: 16.0, left: 16.0, right: index == listMenu[widget.index].childMenu.length - 1 ? 16.0 : 0.0),
                  width: 80.0,
                  decoration: new BoxDecoration(
                    color: Colors.white,
                    border: new Border.all(
                        color: index == 0 ? colorActive : colorInactive),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  child: Stack(
                    children: <Widget>[
                      Container(
                        child: ClipRRect(
                            child: Image.asset(
                              listMenu[widget.index]
                                  .childMenu[index + 1]
                                  .image,
                              fit: BoxFit.fill,
                            ),
                            borderRadius: new BorderRadius.all(
                                Radius.circular(10.0))),
                        width: 80,
                        height: 100,
                      ),
                      Container(
                        width: 80,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius:
                          new BorderRadius.all(Radius.circular(10.0)),
                          color: Colors.black.withOpacity(0.3),
                        ),
                      ),
                      Center(
                          child: Text(
                            listMenu[widget.index].childMenu[index + 1].name,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.center,
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ),
          isLoading
              ? ShimmerPost()
              : Container(
              padding: EdgeInsets.all(2.0),
              child: ListPost()
          ),
        ],
      ),
      color: Colors.white,
    );
  }
}