import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/common/bloc/location_bloc.dart';
import 'package:flutter_food_app/common/state/location_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'list_province.dart';
import 'package:flutter/scheduler.dart';

class ListCity extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => ListCityState();
}

class ListCityState extends State<ListCity>{
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ListProvince(BlocProvider.of<LocationBloc>(context).currentState.indexCity))
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      primary: false,
      appBar: PreferredSize(child: Container(), preferredSize: Size(0.0,0.0)),
      body: BlocBuilder(
          bloc: BlocProvider.of<LocationBloc>(context),
          builder: (context, LocationState state){
            return ListView.builder(
              itemCount: state.nameCities.length,
              itemBuilder: (BuildContext context, int index){
                return new InkWell(
                  //highlightColor: Colors.red,
                  splashColor: colorActive,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ListProvince(index))
                    );
                  },
                  child: new CityItem(state.nameCities[index]),
                );
              },
            );
          }
      )
    );
  }
}

class CityItem extends StatelessWidget {
  final String _text;

  CityItem(this._text);

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: new EdgeInsets.all(15.0),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              bottom: BorderSide(
                color: colorInactive,
                width: 0.5,
              ))),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Container(
            margin: new EdgeInsets.only(left: 10.0),
            child: new Text(
              _text,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
              ),
            ),
          ),
          new Container(
            height: 24.0,
            width: 24.0,
            child: new Center(
              child: Icon(
                Icons.keyboard_arrow_right,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

