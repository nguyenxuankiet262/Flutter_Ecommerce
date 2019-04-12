import 'package:flutter/material.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/common/bloc/location_bloc.dart';
import 'package:flutter_food_app/common/state/location_state.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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

  Future<bool> _saveState() async {
    BlocProvider.of<LocationBloc>(context)
        .changeLocation(tempCity, tempProvince);
    Navigator.of(context);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
        onWillPop: _saveState,
        child: BlocBuilder(
            bloc: BlocProvider.of<LocationBloc>(context),
            builder: (context, LocationState state) {
              return Scaffold(
                primary: false,
                appBar: PreferredSize(
                  child: Container(
                    color: Colors.white,
                    child: Stack(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 1.0),
                          child: IconButton(
                            icon: Icon(
                              Icons.chevron_left,
                              size: 36,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        Center(
                          child: Text(
                            state.nameCities[widget._index],
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          ),
                        )
                      ],
                    ),
                  ),
                  preferredSize: Size(0.0, 54.0),
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
              );
            }));
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
                  ? Icon(
                      FontAwesomeIcons.solidDotCircle,
                      size: 20,
                      color: colorActive,
                    )
                  : Icon(
                      FontAwesomeIcons.solidCircle,
                      size: 20,
                      color: colorInactive.withOpacity(0.3),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
