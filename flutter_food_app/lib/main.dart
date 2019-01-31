import 'package:flutter/material.dart';
import 'const/color_const.dart';
import 'package:flutter_food_app/page/home/home.dart';
import 'package:flutter_food_app/page/bookmark/bookmark.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:flutter_food_app/model/province.dart';
import 'package:flutter_food_app/page/notification/notification.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(fontFamily: 'Montserrat'),
      debugShowCheckedModeBanner: false,
      home: MyMainPage(),
    );
  }
}

class MyMainPage extends StatefulWidget {
  @override
  _MyMainPageState createState() => _MyMainPageState();
}

class _MyMainPageState extends State<MyMainPage>
    with SingleTickerProviderStateMixin {
  int _index = 0;
  ScrollController _scrollViewController;
  TabController _tabController;
  final _widgetOptions = [
    MyHomePage(),
    MyBookMark(),
    NotificationPage(),
    Text('Index 3: School'),
  ];

  String nameCity = "";
  String nameProvince = "";
  String option = "Tất cả";

  loadProvince() async {
    String data = await DefaultAssetBundle.of(context)
        .loadString("assets/datas/vn_province.json");
    final city = cityFromJson(data);
    final cities = city.values.toList();
    setState(() {
      nameCity = cities[0].name.split("Thành phố ").elementAt(1);
      nameProvince = cities[0].districts.values.toList().elementAt(0);
      print(nameCity);
      print(nameProvince);
    });
  }

  @override
  void initState() {
    super.initState();
    _scrollViewController = new ScrollController();
    _tabController = new TabController(vsync: this, length: 3);
    WidgetsBinding.instance.addPostFrameCallback((_) => loadProvince());
    changeStatusColor();
  }

  @override
  void dispose() {
    _scrollViewController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  changeStatusColor() async {
    await FlutterStatusbarcolor.setStatusBarColor(colorActive);
    if (useWhiteForeground(colorActive)) {
      FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
    } else {
      FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new NestedScrollView(
        controller: _scrollViewController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            new SliverAppBar(
              title: new Text(
                'Anzi',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                textAlign: TextAlign.justify,
              ),
              centerTitle: true,
              backgroundColor: colorActive,
              actions: [
                GestureDetector(
                  child: Padding(
                    padding: EdgeInsets.only(right: 10.0),
                    child: GestureDetector(
                      child: Padding(
                        child: Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                        padding: EdgeInsets.only(right: 10.0),
                      ),
                    ),
                  ),
                )
              ],
              pinned: true,
              floating: true,
              forceElevated: innerBoxIsScrolled,
              bottom: new TabBar(
                indicatorWeight: 0.1,
                tabs: <Tab>[
                  new Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Image.asset('assets/images/icon_city.png'),
                        new Flexible(
                          child: new Container(
                            child: new Text(
                              nameCity,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.white, fontSize: 13.0),
                            ),
                          ),
                        ),
                        Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  ),
                  new Tab(
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
                              nameProvince,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.white, fontSize: 13.0),
                            ),
                          ),
                        ),
                        Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  ),
                  new Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Icon(Icons.format_indent_decrease,
                            color: Colors.yellowAccent),
                        new Flexible(
                          child: new Container(
                            child: new Text(
                              option,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.white, fontSize: 13.0),
                            ),
                          ),
                        ),
                        Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  ),
                ],
                controller: _tabController,
              ),
            ),
          ];
        },
        body: _widgetOptions.elementAt(_index),
      ),
      resizeToAvoidBottomPadding: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: colorActive,
        child: const Icon(Icons.add),
        onPressed: () {},
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10.0,
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            GestureDetector(
              child: _index == 0
                  ? Icon(
                      Icons.home,
                      color: colorActive,
                    )
                  : Image.asset('assets/images/icon_home.png'),
              onTap: () {
                setState(() {
                  _index = 0;
                });
              },
            ),
            Padding(
              padding: EdgeInsets.only(right: 100.0),
              child: IconButton(
                icon: Icon(
                  _index == 1 ? Icons.star : Icons.star_border,
                  color: _index == 1 ? colorActive : colorInactive,
                ),
                onPressed: () {
                  setState(() {
                    _index = 1;
                  });
                },
              ),
            ),
            IconButton(
              icon: Icon(
                _index == 2 ? Icons.notifications : Icons.notifications_none,
                color: _index == 2 ? colorActive : colorInactive,
              ),
              onPressed: () {
                setState(() {
                  _index = 2;
                });
              },
            ),
            new Stack(children: <Widget>[
              IconButton(
                icon: Icon(
                  _index == 3 ? Icons.person : Icons.person_outline,
                  color: _index == 3 ? colorActive : colorInactive,
                ),
                onPressed: () {
                  setState(() {
                    _index = 3;
                  });
                },
              ),
              new Positioned(
                // draw a red marble
                top: 5.0,
                right: 20.0,
                child: new Icon(Icons.brightness_1,
                    size: 8.0, color: Colors.redAccent),
              )
            ]),
          ],
        ),
      ),
    );
  }
}
