import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/common/bloc/api_bloc.dart';
import 'package:flutter_food_app/common/state/api_state.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'follow_item.dart';

class ListFollow extends StatefulWidget{
  final int _index;
  ListFollow(this._index);
  @override
  State<StatefulWidget> createState() => ListFollowState();
}

class ListFollowState extends State<ListFollow>{
  ApiBloc apiBloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiBloc = BlocProvider.of<ApiBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder(
      bloc: apiBloc,
      builder: (context, ApiState state){
        return ((widget._index == 1 && state.mainUser.listFollowed.isEmpty) || (widget._index == 2 && state.mainUser.listFollowing.isEmpty))
        ? Container(
          width: double
              .infinity,
          height: MediaQuery.of(context).size.height -
              150,
          child:
          Column(
            mainAxisAlignment:
            MainAxisAlignment.center,
            crossAxisAlignment:
            CrossAxisAlignment.center,
            children: <
                Widget>[
              Icon(
                const IconData(0xe900, fontFamily: 'box'),
                size: 150,
              ),
              Container(
                margin: EdgeInsets.only(top: 16.0),
                child: Text(
                  "Không có lượt theo dõi nào nào",
                  style: TextStyle(
                    color: colorInactive,
                    fontSize: 12,
                  ),
                ),
              ),
              Container(
                child: Text(
                  "Chúc bạn một ngày vui vẻ!",
                  style: TextStyle(
                    color: colorInactive,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        )
        : Container(
          margin: EdgeInsets.only(right: 15.0, left: 15.0),
          child: ListView.builder(
            itemCount: widget._index == 1 ? state.mainUser.listFollowed.length : state.mainUser.listFollowing.length,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) => FollowItem(widget._index,index),
          ),
        );
      },
    );
  }
}