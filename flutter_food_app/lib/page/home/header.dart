import 'package:flutter/material.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter_food_app/const/value_const.dart';
import 'package:flutter_food_app/page/detail/detail.dart';

class HeaderHome extends StatefulWidget{
  Function navigateToPost;
  HeaderHome(this.navigateToPost);
  @override
  State<StatefulWidget> createState() => HeaderHomeState();
}

class HeaderHomeState extends State<HeaderHome>{
  void _gotoDetailScreen(int index){
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ListAllPost(widget.navigateToPost, index)),
    );
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: listMenu.length,
        itemBuilder: (BuildContext context, int index) => GestureDetector(
          onTap: (){
            _gotoDetailScreen(index);
          },
          child: Container(
            margin: EdgeInsets.all(5.0),
            width: 80.0,
            decoration: new BoxDecoration(
              color: Colors.white,
              border: new Border.all(color: colorInactive),
              borderRadius:
              BorderRadius.all(Radius.circular(10.0)),
            ),
            child: Stack(
              children: <Widget>[
                Container(
                  child: ClipRRect(
                      child: Image.asset(
                        listMenu[index].image,
                        fit: BoxFit.fill,
                      ),
                      borderRadius: new BorderRadius.all(
                          Radius.circular(10.0))),
                  width: 80,
                  height: 100,
                ),
                Center(
                    child: Text(
                      listMenu[index].name,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    )),
              ],
            ),
          ),
        ),
      ),
      height: 80,
      color: Colors.white,
    );
  }
}