import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'main.dart';
import 'package:flutter/services.dart';

class StartPage extends StatefulWidget {
  var cameras;
  StartPage(this.cameras);
  @override
  State<StatefulWidget> createState() => StartPageState();
}

class StartPageState extends State<StartPage> {
  void _changeStatusColor(Color color) async {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: color,
      statusBarIconBrightness: Brightness.dark,
    ));
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _changeStatusColor(Colors.white);
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new SplashScreen(
        seconds: 3,
        navigateAfterSeconds: new MyMainPage(widget.cameras),
        image: new Image.asset('assets/images/logo.png'),
        backgroundColor: Colors.white,
        photoSize: 300.0,
    );
  }
}
