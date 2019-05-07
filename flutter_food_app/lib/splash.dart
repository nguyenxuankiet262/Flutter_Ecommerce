import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/common/bloc/camera_bloc.dart';
import 'package:flutter_food_app/common/bloc/location_bloc.dart';
import 'package:flutter_food_app/model/province.dart';
import 'package:flutter_food_app/page/page.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:flutter/services.dart';

class StartPage extends StatefulWidget {
  final cameras;

  StartPage(this.cameras);

  @override
  State<StatefulWidget> createState() => StartPageState();
}

class StartPageState extends State<StartPage> {
  load() async {
    List<String> nameCities = [
      'Toàn quốc',
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
  void initState() {
    // TODO: implement initState
    super.initState();
    load();
    BlocProvider.of<CameraBloc>(context).initCamera(widget.cameras);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent, //or set color with: Color(0xFF0000FF)
    ));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new SplashScreen(
      seconds: 3,
      navigateAfterSeconds: MyMainPage(),
      image: new Image.asset('assets/images/logo.png'),
      backgroundColor: Colors.white,
    );
  }
}
