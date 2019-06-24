import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/common/bloc/location_bloc.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RegisterProvincePage extends StatefulWidget {
  final Function changeProvince;
  final int indexCity;
  final int indexProvince;

  RegisterProvincePage(this.changeProvince, this.indexCity, this.indexProvince);

  @override
  State<StatefulWidget> createState() => RegisterProvincePageState();
}

class RegisterProvincePageState extends State<RegisterProvincePage> {
  LocationBloc locationBloc;
  int _index;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    locationBloc = BlocProvider.of<LocationBloc>(context);
    _index = widget.indexProvince;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        brightness: Brightness.light,
        title: Text(
          "Chọn Quận/Huyện",
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
              widget.changeProvince(_index + 1);
              Navigator.pop(context);
            },
          )
        ],
      ),
      body: Container(
        color: colorBackground,
        child: ListView.builder(
          itemCount: locationBloc.currentState.nameProvinces[widget.indexCity + 1].length - 1,
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
                  locationBloc.currentState.nameProvinces[widget.indexCity + 1][index + 1],
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
