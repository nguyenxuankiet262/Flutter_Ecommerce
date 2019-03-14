import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:flutter_food_app/model/province.dart';
import 'filter_mode.dart';
import 'package:flutter_food_app/page/detail/list_post.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'view_mode.dart';

class ListAllPost extends StatefulWidget {
  Function callback1, callback2;

  ListAllPost(this.callback1, this.callback2);

  @override
  State<StatefulWidget> createState() => _ListAllPostState();
}

class _ListAllPostState extends State<ListAllPost>
    with AutomaticKeepAliveClientMixin {
  int indexCity = 5;
  int indexProvince = 0;
  bool _showBar = true;
  double _posY = 0.0;
  SearchBar searchBar;
  ScrollController _scrollController;

  List<String> nameCities = [
    'Tất cả',
  ];
  List<List<String>> nameProvinces = [
    ['Tất cả']
  ];

  load() async {
    String data = await DefaultAssetBundle.of(context)
        .loadString("assets/datas/vn_province.json");
    final city = cityFromJson(data);
    final cities = city.values.toList();
    setState(() {
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
    });
  }

  _showDialogNameCity(bool isCity) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
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
                                  indexCity = index;
                                  if (index == 0) {
                                    indexProvince = 0;
                                  }
                                } else {
                                  indexProvince = index;
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
                              onTap: (){
                                Navigator.pop(context);
                              },
                              child: Icon(
                                Icons.close,
                                color: colorInactive,
                                size: 20,
                              ),
                            )
                          ))
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
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: widthDialog,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(bottomRight: Radius.circular(10.0), bottomLeft: Radius.circular(10.0)),
                        color: colorActive,
                      ),
                      child: Center(
                        child: Text(
                          "Áp dụng",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                    )
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  void initState() {
    super.initState();
    load();
    _scrollController = ScrollController()
      ..addListener(() {
        if (mounted) {
          double x = _scrollController.offset;
          setState(() {
            if (_posY < x - 15) {
              _showBar = false;
            }
            if (_posY > x + 15) {
              _showBar = true;
            }
            _posY = _scrollController.offset;
          });
        }
      });
  }

  @override
  void dispose() {
    _scrollController
        .dispose(); // it is a good practice to dispose the controller
    super.dispose();
  }

  _ListAllPostState() {
    searchBar = new SearchBar(
        inBar: false,
        setState: setState,
        onSubmitted: print,
        buildDefaultAppBar: buildAppBar);
  }

  AppBar buildAppBar(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final widthTab = size.width / 3 - 10;
    return new AppBar(
      brightness: Brightness.light,
      title: new Text(
        'Rau củ',
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
      actions: [searchBar.getSearchAction(context)],
      bottom: !_showBar
          ? null
          : PreferredSize(
              preferredSize: Size.fromHeight(40),
              child: Padding(
                padding: EdgeInsets.only(bottom: 13, right: 5.0, left: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: widthTab,
                      child: GestureDetector(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Image.asset('assets/images/icon_city.png'),
                            new Flexible(
                              child: new Container(
                                child: new Text(
                                  nameCities[indexCity],
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16.0),
                                ),
                              ),
                            ),
                            Icon(Icons.arrow_drop_down),
                          ],
                        ),
                        onTap: () {
                          _showDialogNameCity(true);
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
                              Icons.location_on,
                              color: Colors.red,
                            ),
                            new Flexible(
                              child: new Container(
                                child: new Text(
                                  nameProvinces[indexCity][indexProvince],
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16.0),
                                ),
                              ),
                            ),
                            Icon(Icons.arrow_drop_down),
                          ],
                        ),
                        onTap: () {
                          _showDialogNameCity(false);
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
                            Icon(Icons.format_indent_decrease,
                                color: Colors.green),
                            new Flexible(
                              child: new Container(
                                child: new Text(
                                  'Lọc',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16.0),
                                ),
                              ),
                            ),
                            Icon(Icons.arrow_drop_down),
                          ],
                        ),
                        onTap: () {
                          _showFilter();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return (nameCities.length < 2 && nameProvinces.length < 2)
        ? Center(child: CircularProgressIndicator(backgroundColor: colorActive))
        : Scaffold(
            appBar: searchBar.build(context),
            body: ListView(
              controller: _scrollController,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 5.0),
                  child: ListPost(this.widget.callback1, this.widget.callback2),
                ),
              ],
            ),
          );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
