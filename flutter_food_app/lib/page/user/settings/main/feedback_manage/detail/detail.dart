import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/common/bloc/api_bloc.dart';
import 'package:flutter_food_app/common/helper/helper.dart';
import 'package:flutter_food_app/const/color_const.dart';

class DetailFeedback extends StatefulWidget{
  final int _index;
  final bool isRep;

  DetailFeedback(this._index, this.isRep);
  @override
  State<StatefulWidget> createState() => DetailFeedbackState();
}

class DetailFeedbackState extends State<DetailFeedback> {
  ApiBloc apiBloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiBloc = BlocProvider.of<ApiBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        brightness: Brightness.light,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          "Thông tin phản hồi",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Container(
          color: Colors.white,
          child: ListView(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      "Tiêu đề",
                      style: TextStyle(
                          fontFamily: "Ralway", fontWeight: FontWeight.bold),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.0),
                      margin: EdgeInsets.only(left: 8.0),
                      decoration: BoxDecoration(
                          color: colorComment,
                          borderRadius: BorderRadius.all(
                              Radius.circular(10.0)),
                          border:
                          Border.all(color: colorComment)),
                      child: Center(
                        child: Text(
                          Helper()
                              .timeAgo(widget.isRep ? apiBloc.currentState.mainUser.listRepFeedback[widget._index].day : apiBloc.currentState.mainUser.listUnrepFeedback[widget._index].day),
                          style: TextStyle(
                            color: colorInactive,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ),
              Container(
                padding: EdgeInsets.only(right: 16.0, left: 16.0),
                color: Colors.white,
                child: Text(
                  widget.isRep ? apiBloc.currentState.mainUser.listRepFeedback[widget._index].title : apiBloc.currentState.mainUser.listUnrepFeedback[widget._index].title,
                  style: TextStyle(
                    fontFamily: "Ralway",
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "Miêu tả vấn đề",
                  style: TextStyle(
                      fontFamily: "Ralway", fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 16.0, left: 16.0, bottom: 16.0),
                color: Colors.white,
                child: Text(
                  widget.isRep ? apiBloc.currentState.mainUser.listRepFeedback[widget._index].feedBack : apiBloc.currentState.mainUser.listUnrepFeedback[widget._index].feedBack,
                  style: TextStyle(
                    fontFamily: "Ralway",
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 16.0, left: 16.0, bottom: 16.0),
                child: Text(
                  "Trả lời",
                  style: TextStyle(
                      fontFamily: "Ralway", fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: EdgeInsets.all(16.0),
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                color: colorBackground,
                child: Text(
                  widget.isRep ? apiBloc.currentState.mainUser.listRepFeedback[widget._index].reply : "Chưa trả lời",
                  style: TextStyle(
                    fontFamily: "Ralway",
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
