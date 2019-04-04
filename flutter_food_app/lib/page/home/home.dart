import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/common/bloc/location_bloc.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter_food_app/model/province.dart';
import 'category.dart';
import 'header.dart';
import 'slider.dart';
import 'package:flutter_food_app/page/search/search.dart';

class MyHomePage extends StatefulWidget {
  Function navigateToPost, navigateToFilter, navigateToSearch;

  MyHomePage(this.navigateToPost, this.navigateToFilter, this.navigateToSearch);

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
    this.widget.navigateToPost();
  }

  void navigateToFilter() {
    this.widget.navigateToFilter();
  }

  void navigateToSearch(){
    this.widget.navigateToSearch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(111.0), // here the desired height
          child: Column(
            children: <Widget>[
              AppBar(
                brightness: Brightness.light,
                title: Container(
                  width: MediaQuery.of(context).size.width - MediaQuery.of(context).size.width / 2 + 7 ,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 5.0),
                        child: Image.asset('assets/images/logo.png'),
                      ),
                      new Text(
                        'Anzi',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        textAlign: TextAlign.justify,
                      ),

                    ],
                  ),
                ),
                iconTheme: IconThemeData(
                  color: Colors.black, //change your color here
                ),
                backgroundColor: Colors.white,
                actions: <Widget>[
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(right: 16),
                      child: Container(
                          padding: EdgeInsets.only(
                              top: 3.0,
                              bottom: 3.0,
                              right: 10.0,
                              left: 10.0),
                          height: 31,
                          decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.all(Radius.circular(100.0)),
                              border: Border.all(
                                  color: colorActive, width: 0.5)),
                          child: Row(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(right: 5.0),
                                child: Icon(
                                  Icons.location_on,
                                  color: colorActive,
                                  size: 15,
                                ),
                              ),
                              Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "Chọn khu vực",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 10,
                                        fontFamily: "Ralway"),
                                  ),
                                  Container(
                                      width: 70,
                                      child: Text(
                                        "Quận Tân Bình",
                                        style: TextStyle(
                                            color: colorActive,
                                            fontSize: 10,
                                            fontFamily: "Ralway"),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      )),
                                ],
                              ),
                            ],
                          )),
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: (){
                  navigateToSearch();
                },
                child: Container(
                    height: 55.0,
                    color: Colors.white,
                    padding:
                    EdgeInsets.only(right: 16.0, left: 16.0, bottom: 14.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          color: colorInactive.withOpacity(0.2)),
                      child: Container(
                          margin: EdgeInsets.only(left: 15.0),
                          child: Row(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(right: 10.0),
                                child: Icon(
                                  Icons.search,
                                  color: Colors.grey,
                                  size: 14,
                                ),
                              ),
                              Text(
                                "Tìm kiếm bài viết, người đăng",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: colorInactive,
                                    fontFamily: "Ralway"),
                              )
                            ],
                          )),
                    )),
              ),
            ],
          ),
        ),
        backgroundColor: colorBackground,
        body: ListView(
          children: <Widget>[
            CarouselWithIndicator(),
            Container(
                margin: EdgeInsets.only(top: 16.0, bottom: 16.0),
                child: Container(
                  child: HeaderHome(this.navigateToPost, this.navigateToFilter, this.navigateToSearch),
                )),
            Container(
              child: ListCategory(this.navigateToPost),
            ),
          ],
        ));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
