import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/common/bloc/location_bloc.dart';
import 'package:flutter_food_app/common/state/location_state.dart';

class FilterMode extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => FilterModeState();
}

class FilterModeState extends State<FilterMode>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder(
      bloc: BlocProvider.of<LocationBloc>(context),
      builder: (context, LocationState state){
        return Center(
          child: GestureDetector(
            onTap: (){
              print(BlocProvider.of<LocationBloc>(context).currentState.nameCities.elementAt(2));
            },
            child: Text(
              state.nameCities.elementAt(1),
            ),
          )
        );
      },
    );
  }
}