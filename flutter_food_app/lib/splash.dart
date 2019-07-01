import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/api/api.dart';
import 'package:flutter_food_app/common/bloc/api_bloc.dart';
import 'package:flutter_food_app/common/bloc/camera_bloc.dart';
import 'package:flutter_food_app/common/bloc/loading_bloc.dart';
import 'package:flutter_food_app/common/bloc/location_bloc.dart';
import 'package:flutter_food_app/common/bloc/user_bloc.dart';
import 'package:flutter_food_app/common/helper/helper.dart';
import 'package:flutter_food_app/model/province.dart';
import 'package:flutter_food_app/page/page.dart';
import 'package:flutter/services.dart';
import 'package:toast/toast.dart';

class StartPage extends StatefulWidget {
  final cameras;

  StartPage(this.cameras);

  @override
  State<StatefulWidget> createState() => StartPageState();
}

class StartPageState extends State<StartPage> {
  ApiBloc apiBloc;
  LoadingBloc loadingBloc;
  UserBloc userBloc;
  String token;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
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
  initState() {
    // TODO: implement initState
    super.initState();
    userBloc = BlocProvider.of<UserBloc>(context);
    apiBloc = BlocProvider.of<ApiBloc>(context);
    loadingBloc = BlocProvider.of<LoadingBloc>(context);
    (() async {
      await load();
      if(await Helper().check()){
        fetchBanner(apiBloc);
        fetchMenus(apiBloc);
        fetchTopTenNewestProduct(apiBloc, " ");
        fetchTopTenFavProduct(apiBloc, " ");
        String check = await checkValidToken();
        if(check != "403" && check != "err"){
          userBloc.login();
          await fetchUserById(apiBloc, check);
        }
        Future.delayed(const Duration(milliseconds: 1000), () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => MyMainPage())
          );
        });
        if(check != "403" && check != "err") {
          await _firebaseMessaging.getToken().then((_token){
            setState(() {
              token = _token;
            });
          });
          _firebaseMessaging.onTokenRefresh.listen((newToken) {
            setState(() {
              token = newToken;
            });
          });
          updateToken(check, token);
          fetchCountNewOrder(apiBloc, check);
          fetchSystemNotificaion(apiBloc, loadingBloc, check, "1", "10");
          fetchFollowNotificaion(apiBloc, loadingBloc, check, "1", "10");
          fetchAmountNewFollowNoti(apiBloc, check);
          fetchAmountNewSystemNoti(apiBloc, check);
          fetchListPostUser(apiBloc, loadingBloc, check, 1, 10);
          fetchRatingByUser(apiBloc, check, "1", "10");
          fetchCartByUserId(apiBloc, loadingBloc, check);
        }
      }else {
        new Future.delayed(
            const Duration(seconds: 1),
                () {
              Toast.show(
                  "Vui lòng kiểm tra mạng!",
                  context,
                  gravity: Toast.CENTER,
                  backgroundColor:
                  Colors.black87);
            });
      }
    })();
    BlocProvider.of<CameraBloc>(context).initCamera(widget.cameras);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent, //or set color with: Color(0xFF0000FF)
    ));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      child: Center(
        child:  new Image.asset('assets/images/logo.png'),
      ),
      color: Colors.white,
    );
  }
}
