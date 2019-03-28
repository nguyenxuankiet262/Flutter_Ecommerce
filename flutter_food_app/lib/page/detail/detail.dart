import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/common/bloc/location_bloc.dart';
import 'package:flutter_food_app/common/bloc/location_option_bloc.dart';
import 'package:flutter_food_app/common/state/location_option_state.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'mode/filter_mode.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter_food_app/page/detail/mode/view_mode.dart';
import 'package:flutter_food_app/const/value_const.dart';
import 'package:flutter_food_app/page/detail/menu.dart';


class ListAllPost extends StatefulWidget {
  Function callback1;
  int index;

  ListAllPost(this.callback1, this.index);

  @override
  State<StatefulWidget> createState() => _ListAllPostState();
}

class _ListAllPostState extends State<ListAllPost> {
  int indexCity ;
  int indexProvince;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  List<String> nameCities;
  List<List<String>> nameProvinces;


  _showDialogNameCity(bool isCity) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          indexCity = BlocProvider.of<LocationOptionBloc>(context).currentState.indexCity;
          indexProvince = BlocProvider.of<LocationOptionBloc>(context).currentState.indexProvince;
          final size = MediaQuery.of(context).size;
          final widthDialog = size.width;
          final heightList = size.height - 200;
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                )),
            contentPadding: EdgeInsets.only(top: 10.0),
            content: Container(
              width: widthDialog,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    child: Text(
                      isCity ? "Chọn thành phố" : "Chọn quận/huyện",
                      style: TextStyle(fontSize: 24.0),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Divider(
                    color: Colors.grey,
                    height: 4.0,
                  ),
                  Container(
                    height: heightList,
                    child: ListView.builder(
                      itemCount: isCity
                          ? nameCities.length
                          : nameProvinces[indexCity].length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.only(
                              top: 10.0, right: 20.0, left: 20.0, bottom: 10.0),
                          child: GestureDetector(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                    '${isCity ? nameCities[index] : nameProvinces[indexCity][index]}'),
                                isCity
                                    ? (index == indexCity)
                                    ? Icon(Icons.radio_button_checked)
                                    : Icon(Icons.radio_button_unchecked)
                                    : index == indexProvince
                                    ? Icon(Icons.radio_button_checked)
                                    : Icon(Icons.radio_button_unchecked),
                              ],
                            ),
                            onTap: () {
                              setState(() {
                                if (isCity) {
                                  BlocProvider.of<LocationOptionBloc>(context).changeLocation(index, BlocProvider.of<LocationOptionBloc>(context).currentState.indexProvince);
                                  if (index == 0) {
                                    BlocProvider.of<LocationOptionBloc>(context).changeLocation(BlocProvider.of<LocationOptionBloc>(context).currentState.indexCity, 0);
                                  }
                                } else {
                                  BlocProvider.of<LocationOptionBloc>(context).changeLocation(BlocProvider.of<LocationOptionBloc>(context).currentState.indexCity, index);
                                }
                                Navigator.pop(context);
                              });
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  _showFilter() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          final size = MediaQuery.of(context).size;
          final widthDialog = size.width;
          final heightList = (size.height / 5) * 3 - 10.0;
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                )),
            contentPadding: EdgeInsets.only(top: 10.0),
            content: Container(
              width: widthDialog,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                      child: Stack(
                        children: <Widget>[
                          Center(
                            child: Text(
                              "Lọc",
                              style: TextStyle(fontSize: 24.0),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                  margin: EdgeInsets.only(right: 20.0, top: 5.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Icon(
                                      Icons.close,
                                      color: colorInactive,
                                      size: 20,
                                    ),
                                  )))
                        ],
                      )),
                  SizedBox(
                    height: 5.0,
                  ),
                  Container(
                      height: heightList,
                      child: ListView(
                        children: <Widget>[
                          FilterMode(),
                          ViewMode(),
                        ],
                      )),
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: widthDialog,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(10.0),
                              bottomLeft: Radius.circular(10.0)),
                          color: colorActive,
                        ),
                        child: Center(
                          child: Text(
                            "Áp dụng",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      )),
                ],
              ),
            ),
          );
        });
  }

  @override
  void initState() {
    super.initState();
    nameCities = BlocProvider.of<LocationBloc>(context).currentState.nameCities;
    nameProvinces = BlocProvider.of<LocationBloc>(context).currentState.nameProvinces;
  }

  AppBar buildAppBar(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final widthTab = size.width / 3 - 10;
    return new AppBar(
      brightness: Brightness.light,
      title: new Text(
        listMenu[this.widget.index].name,
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(
        color: Colors.black, //change your color here
      ),
      leading: GestureDetector(
        child: Icon(Icons.arrow_back),
        onTap: () {
          Navigator.pop(context);
        },
      ),
      actions: <Widget>[
        GestureDetector(
          onTap: (){

          },
          child: Container(
              margin: EdgeInsets.only(right: 10.0),
              child: Icon(
                Icons.search,
                color: Colors.black,
              )
          ),
        )
      ],
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: Padding(
          padding: EdgeInsets.only(bottom: 13, right: 5.0, left: 5.0),
          child: BlocBuilder(
            bloc: BlocProvider.of<LocationOptionBloc>(context),
            builder: (context, LocationOptionState state){
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 5.0),
                    width: widthTab,
                    child: GestureDetector(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.city,
                            size: 14,
                            color: Colors.blue,
                          ),
                          new Flexible(
                            child: new Container(
                              margin: EdgeInsets.only(left: 5.0),
                              child: new Text(
                                nameCities[state.indexCity],
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 12.0),
                              ),
                            ),
                          ),
                          Icon(Icons.arrow_drop_down),
                        ],
                      ),
                      onTap: () {
                        //_showDialogNameCity(true);
                        BlocProvider.of<LocationOptionBloc>(context).changeLocation(1, 5);
                      },
                    ),
                  ),
                  Container(
                    height: 20.0,
                    width: 1.0,
                    color: Colors.grey,
                  ),
                  Container(
                    width: widthTab,
                    child: GestureDetector(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.streetView,
                            color: Colors.red,
                            size: 14,
                          ),
                          new Flexible(
                            child: new Container(
                              margin: EdgeInsets.only(left: 5.0),
                              child: new Text(
                                nameProvinces[state.indexCity][state.indexProvince],
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 12.0),
                              ),
                            ),
                          ),
                          Icon(Icons.arrow_drop_down),
                        ],
                      ),
                      onTap: () {
                        //_showDialogNameCity(false);
                      },
                    ),
                  ),
                  Container(
                    height: 20.0,
                    width: 1.0,
                    color: Colors.grey,
                  ),
                  Container(
                    width: widthTab,
                    child: GestureDetector(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Icon(
                              FontAwesomeIcons.sortAlphaDown,
                              size: 14,
                              color: Colors.green),
                          new Flexible(
                            child: new Container(
                              child: new Text(
                                'Lọc/Sắp xếp',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 12.0),
                              ),
                            ),
                          ),
                          Icon(Icons.arrow_drop_down),
                        ],
                      ),
                      onTap: () {
                        //_showFilter();
                        _scaffoldKey.currentState.openEndDrawer();
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: Drawer(
          child: ListView(
            children: <Widget>[
              FilterMode(),
              ViewMode(),
            ],
          )),
      appBar: buildAppBar(context),
      body: HeaderDetail(this.widget.callback1, this.widget.index),
    );
  }
}