import 'package:flutter/material.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/common/bloc/location_bloc.dart';
import 'package:flutter_food_app/common/state/location_state.dart';

class ListProvince extends StatefulWidget {
  int _index;

  ListProvince(this._index);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ListProvinceState();
  }
}

class ListProvinceState extends State<ListProvince> {
  int tempCity;
  int tempProvince;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tempCity = BlocProvider.of<LocationBloc>(context).currentState.indexCity;
    tempProvince =
        BlocProvider.of<LocationBloc>(context).currentState.indexProvince;
  }

  _saveState() {
    BlocProvider.of<LocationBloc>(context)
        .changeLocation(tempCity, tempProvince);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder(
        bloc: BlocProvider.of<LocationBloc>(context),
        builder: (context, LocationState state) {
          return WillPopScope(
            onWillPop: () {
              _saveState();
            },
            child: Scaffold(
              appBar: AppBar(
                elevation: 0.5,
                brightness: Brightness.light,
                iconTheme: IconThemeData(
                  color: Colors.black, //change your color here
                ),
                title: Text(
                  state.nameCities[widget._index],
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                backgroundColor: Colors.white,
                centerTitle: true,
                actions: <Widget>[
                  new Center(
                    child: Padding(
                      padding: EdgeInsets.only(right: 16),
                      child: GestureDetector(
                        child: Text(
                          'ÁP DỤNG',
                          textScaleFactor: 1.5,
                          style: TextStyle(
                              color: colorActive,
                              fontWeight: FontWeight.bold,
                              fontSize: 10),
                        ),
                        onTap: () {
                          BlocProvider.of<LocationBloc>(context).changeLocation(
                            BlocProvider.of<LocationBloc>(context)
                                .currentState
                                .indexCity,
                            BlocProvider.of<LocationBloc>(context)
                                .currentState
                                .indexProvince,
                          );
                          Navigator.of(context).popUntil((route) => route.isFirst);
                        },
                      ),
                    ),
                  ),
                ],
              ),
              body: Container(
                color: colorBackground,
                child: ListView.builder(
                  itemCount: state.nameProvinces[widget._index].length,
                  itemBuilder: (BuildContext context, int index) {
                    return new InkWell(
                      //highlightColor: Colors.red,
                      splashColor: colorActive,
                      onTap: () {
                        BlocProvider.of<LocationBloc>(context)
                            .changeLocation(widget._index, index);
                      },
                      child: new ProvinceItem(
                          widget._index == state.indexCity &&
                                  index == state.indexProvince
                              ? true
                              : false,
                          state.nameProvinces[widget._index][index]),
                    );
                  },
                ),
              ),
            ),
          );
        });
  }
}

class ProvinceItem extends StatelessWidget {
  final bool _isSelected;
  final String _text;

  ProvinceItem(this._isSelected, this._text);

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
              style: TextStyle(color: Colors.black, fontSize: 14),
            ),
          ),
          new Container(
            height: 24.0,
            width: 24.0,
            child: new Center(
              child: _isSelected
                  ? Icon(Icons.check_box)
                  : Icon(Icons.check_box_outline_blank),
            ),
          ),
        ],
      ),
    );
  }
}
