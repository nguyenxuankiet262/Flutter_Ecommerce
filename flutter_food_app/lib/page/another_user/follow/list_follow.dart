import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/common/bloc/follow_bloc.dart';
import 'follow_item.dart';

class ListFollow extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => ListFollowState();
}

class ListFollowState extends State<ListFollow>{
  FollowBloc followBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    followBloc = BlocProvider.of<FollowBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(right: 15.0, left: 15.0),
      child: ListView.builder(
        itemCount: followBloc.currentState.listFollow.length,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) => FollowItem(index),
      ),
    );
  }
}