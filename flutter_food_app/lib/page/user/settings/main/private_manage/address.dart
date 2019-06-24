import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/common/bloc/api_bloc.dart';
import 'package:flutter_food_app/common/bloc/info_bloc.dart';
import 'package:flutter_food_app/common/bloc/location_bloc.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter_food_app/page/user/settings/main/private_manage/location_city.dart';
import 'package:flutter_food_app/page/user/settings/main/private_manage/location_province.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:toast/toast.dart';

class AddressPage extends StatefulWidget {
  final Function changeAddress;
  AddressPage(this.changeAddress);
  @override
  State<StatefulWidget> createState() => AddressPageState();
}

class AddressPageState extends State<AddressPage> {
  String address = "";
  LocationBloc locationBloc;
  InfoBloc infoBloc;
  ApiBloc apiBloc;
  int indexCity = 4;
  int indexProvice = 0;
  final myControllerAddress = new TextEditingController();
  final myControllerCity = new TextEditingController();
  final myControllerProvince = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    locationBloc = BlocProvider.of<LocationBloc>(context);
    infoBloc = BlocProvider.of(context);
    apiBloc = BlocProvider.of(context);
    myControllerAddress.addListener(_changeAddress);
  }

  _onChangeCity(int _indexCity) {
    if (_indexCity != indexCity) {
      myControllerProvince.clear();
    }
    myControllerCity.text = locationBloc.currentState.nameCities[_indexCity];
    setState(() {
      indexCity = _indexCity - 1;
    });
  }

  _onChangeProvince(int _indexProvince) {
    myControllerProvince.text =
    locationBloc.currentState.nameProvinces[indexCity + 1][_indexProvince];
    setState(() {
      indexProvice = _indexProvince - 1;
    });
  }

  _changeAddress() {
    setState(() {
      address = myControllerAddress.text;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    myControllerAddress.dispose();
    myControllerCity.dispose();
    myControllerProvince.dispose();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          brightness: Brightness.light,
          title: Text(
            "Chỉnh sửa địa chỉ",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          elevation: 0.5,
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: Container(
          color: Colors.white,
          child: ListView(
            children: <Widget>[
              Card(
                margin: EdgeInsets.only(
                    left: 16, right: 16, top: 20),
                elevation: 5,
                child: TextField(
                  controller: myControllerAddress,
                  textCapitalization: TextCapitalization.words,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(50)
                  ],
                  style: TextStyle(
                    fontFamily: "Ralway",
                    color: Colors.black
                  ),
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        FontAwesomeIcons.locationArrow,
                        size: 20,
                        color: Colors.black26,
                      ),
                      suffixIcon: Icon(
                        Icons.check_circle,
                        color: address.length > 1
                            ? Colors.blue
                            : Colors.black26,
                      ),
                      hintText: "Địa chỉ",
                      hintStyle: TextStyle(
                          color: Colors.black26,
                          fontSize: 12),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(
                            Radius.circular(40.0)),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 16.0)),
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    InfoCityPage(_onChangeCity, indexCity)));
                      },
                      child: Card(
                        margin: EdgeInsets.only(
                            left: 16, right: 16, top: 20),
                        elevation: 5,
                        child: TextField(
                          enabled: false,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              fontFamily: 'Montserrat',
                              fontSize: 12
                          ),
                          controller: myControllerCity,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(100)
                          ],
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                FontAwesomeIcons.solidBuilding,
                                size: 22,
                                color: Colors.black26,
                              ),
                              suffixIcon: Icon(
                                Icons.arrow_drop_down,
                                color: Colors.black26,
                              ),
                              hintText: "Tỉnh/Thành phố",
                              hintStyle: TextStyle(
                                  color: Colors.black26,
                                  fontSize: 12
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.all(
                                    Radius.circular(40.0)),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 16.0)),
                        ),
                      ),
                    ),
                    flex: 1,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        if (myControllerCity.text.isNotEmpty) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      InfoProvincePage(
                                          _onChangeProvince, indexCity,
                                          indexProvice)));
                        }
                        else {
                          Toast.show("Vui lòng chọn thành phố!", context,
                              gravity: Toast.CENTER);
                        }
                      },
                      child: Card(
                        margin: EdgeInsets.only(right: 16, top: 20),
                        elevation: 5,
                        child: TextField(
                          enabled: false,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              fontFamily: 'Montserrat',
                              fontSize: 12
                          ),
                          controller: myControllerProvince,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(100)
                          ],
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.location_on,
                                color: Colors.black26,
                              ),
                              suffixIcon: Icon(
                                Icons.arrow_drop_down,
                                color: Colors.black26,
                              ),
                              hintText: "Quận/Huyện",
                              hintStyle: TextStyle(
                                  color: Colors.black26,
                                  fontSize: 12
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.all(
                                    Radius.circular(40.0)),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 16.0)),
                        ),
                      ),
                    ),
                    flex: 1,
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                child: Container(
                    height: 50,
                    child: RaisedButton(
                      color: colorActive,
                      elevation: 4.0,
                      splashColor: Colors.green,
                      onPressed: (){
                        String tempAddress = address + ", " + myControllerProvince.text +
                            ", " + myControllerCity.text;
                        widget.changeAddress(tempAddress);
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Đồng ý",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    )
                ),
              )
            ],
          ),
        ));
  }
}
