import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:flutter/services.dart';
import 'app.dart';

class StartPage extends StatefulWidget {
  var cameras;
  StartPage(this.cameras);
  @override
  State<StatefulWidget> createState() => StartPageState();
}

class StartPageState extends State<StartPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.white, //or set color with: Color(0xFF0000FF)
    ));
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new SplashScreen(
        seconds: 3,
        navigateAfterSeconds: new MainApp(widget.cameras),
        image: new Image.asset('assets/images/logo.png'),
        backgroundColor: Colors.white,
        photoSize: 300.0,
    );
  }
}
