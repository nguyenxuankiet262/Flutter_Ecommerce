import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/common/bloc/location_bloc.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InfoCityPage extends StatefulWidget {
  final Function changeCity;
  final int index;

  InfoCityPage(this.changeCity, this.index);

  @override
  State<StatefulWidget> createState() => InfoCityPageState();
}

class InfoCityPageState extends State<InfoCityPage> {
  LocationBloc locationBloc;
  int _index;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    locationBloc = BlocProvider.of<LocationBloc>(context);
    _index = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        brightness: Brightness.light,
        title: Text(
          "Chọn Tỉnh/Thành phố",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        elevation: 0.5,
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.done,
              color: colorActive,
            ),
            onPressed: (){
              widget.changeCity(_index + 1);
              Navigator.pop(context);
            },
          )
        ],
      ),
      body: Container(
        color: colorBackground,
        child: ListView.builder(
          itemCount: locationBloc.currentState.nameCities.length - 1,
          itemBuilder: (BuildContext context, int index) {
            return new InkWell(
                //highlightColor: Colors.red,
                splashColor: colorActive,
                onTap: () {
                  setState(() {
                    _index = index;
                  });
                },
                child: new CityItem(
                  _index == index ? true : false,
                  locationBloc.currentState.nameCities[index + 1],
                ));
          },
        ),
      ),
    );
  }
}

class CityItem extends StatelessWidget {
  final bool _isSelected;
  final String _text;

  CityItem(this._isSelected, this._text);

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
