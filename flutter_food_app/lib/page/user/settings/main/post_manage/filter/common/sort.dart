import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/common/bloc/post_manage_bloc.dart';
import 'package:flutter_food_app/common/state/post_manage_state.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter_food_app/const/value_const.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SortContent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SortContentState();
}

class SortContentState extends State<SortContent> {
  PostManageBloc postManageBloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    postManageBloc = BlocProvider.of<PostManageBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder(
      bloc: postManageBloc,
      builder: (context, PostManageState state){
        return Container(
            padding: EdgeInsets.only(left: 16.0, right: 16.0),
            child: ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 16.0),
                  child: Text(
                    "SẮP XẾP THEO",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ListView.builder(
                    itemCount: listSort.length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) =>
                        GestureDetector(
                            onTap: () {
                              postManageBloc.changeTempFilter(state.tempMin, state.tempMax, index + 1);
                            },
                            child: Container(
                              color: Colors.white,
                              margin: EdgeInsets.only(bottom: 16.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(right: 12.0),
                                        child: listIconSort[index],
                                      ),
                                      Text(
                                        listSort[index],
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    ],
                                  ),
                                  index == state.tempCode - 1
                                  ? Icon(
                                    FontAwesomeIcons.solidDotCircle,
                                    size: 20,
                                    color: colorActive,
                                  )
                                      : Icon(
                                    FontAwesomeIcons.solidCircle,
                                    size: 20,
                                    color: colorInactive.withOpacity(0.3),
                                  )
                                ],
                              ),
                            )))
              ],
            ));
      },
    );
  }
}
