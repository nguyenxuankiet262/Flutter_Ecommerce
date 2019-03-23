import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/common/bloc/location_bloc.dart';
import 'package:flutter_food_app/model/province.dart';
import 'category.dart';
import 'header.dart';
import 'slider.dart';

class MyHomePage extends StatefulWidget {
  Function callback1;

  MyHomePage(this.callback1);

  @override
  State<StatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with AutomaticKeepAliveClientMixin {
  load() async {
    List<String> nameCities = [
      'Tất cả',
    ];
    List<List<String>> nameProvinces = [
      ['Tất cả']
    ];

    String data = await DefaultAssetBundle.of(context)
        .loadString("assets/datas/vn_province.json");
    final city = cityFromJson(data);
    final cities = city.values.toList();
    for (var i = 0; i < cities.length; i++) {
      if (cities[i].name.contains("Thành phố ")) {
        nameCities.add(cities[i].name.split("Thành phố ").elementAt(1));
      }
      if (cities[i].name.contains("Tỉnh ")) {
        nameCities.add(cities[i].name.split("Tỉnh ").elementAt(1));
      }
      List<String> temp = cities[i].districts.values.toList();
      temp.insert(0, 'Tất cả');
      nameProvinces.add(temp);
    }

    BlocProvider.of<LocationBloc>(context)
        .addLocation(nameCities, nameProvinces);
  }

  @override
  initState() {
    // TODO: implement initState
    super.initState();
    load();
  }

  void navigateToPost() {
    this.widget.callback1();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(138.0), // here the desired height
          child: Column(
            children: <Widget>[
              AppBar(
                brightness: Brightness.light,
                leading: GestureDetector(
                  child: Image.asset('assets/images/logo.png'),
                  onTap: () {},
                ),
                title: new Text(
                  'Anzi',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  textAlign: TextAlign.justify,
                ),
                iconTheme: IconThemeData(
                  color: Colors.black, //change your color here
                ),
                centerTitle: true,
                backgroundColor: Colors.white,
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
              ),
              HeaderHome(this.navigateToPost),
            ],
          ),
        ),
        body: ListView(
          children: <Widget>[
            CarouselWithIndicator(),
            ListCategory(this.navigateToPost),
          ],
        ));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
