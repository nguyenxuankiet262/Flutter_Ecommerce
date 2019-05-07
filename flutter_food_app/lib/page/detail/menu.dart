import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/common/bloc/api_bloc.dart';
import 'package:flutter_food_app/common/bloc/detail_bloc.dart';
import 'package:flutter_food_app/common/bloc/function_bloc.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter_food_app/const/value_const.dart';

class HeaderDetail extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HeaderDetailState();
}

class HeaderDetailState extends State<HeaderDetail> {
  DetailPageBloc detailPageBloc;
  ApiBloc apiBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiBloc = BlocProvider.of<ApiBloc>(context);
    detailPageBloc = BlocProvider.of<DetailPageBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            height: 112,
            decoration: BoxDecoration(
                color: colorBackground,
                border: Border(bottom: BorderSide(width: 0.5, color: colorInactive.withOpacity(0.5)))
            ),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: apiBloc.currentState.listChildMenu.length - 1,
              itemBuilder: (BuildContext context, int index) => GestureDetector(
                onTap: () {
                  detailPageBloc.changeCategory(detailPageBloc.currentState.indexCategory, index + 1);
                  BlocProvider.of<FunctionBloc>(context).currentState.isLoading();
                },
                child: Container(
                  margin: EdgeInsets.only(top: 16.0, bottom: 16.0, left: 16.0, right: index == listMenu[detailPageBloc.currentState.indexCategory].childMenu.length - 2 ? 16.0 : 0.0),
                  width: 80.0,
                  decoration: new BoxDecoration(
                    color: Colors.white,
                    border: new Border.all(
                        color: colorInactive),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  child: Stack(
                    children: <Widget>[
                      Container(
                        child: ClipRRect(
                            child: Image.network(
                              apiBloc.currentState.listChildMenu[index + 1]
                                  .link,
                              fit: BoxFit.fill,
                            ),
                            borderRadius: new BorderRadius.all(
                                Radius.circular(10.0))),
                        width: 80,
                        height: 100,
                      ),
                      Container(
                        width: 80,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius:
                          new BorderRadius.all(Radius.circular(10.0)),
                          color: Colors.black.withOpacity(0.3),
                        ),
                      ),
                      Center(
                          child: Text(
                            apiBloc.currentState.listChildMenu[index + 1].name,
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
          ),
        ],
      ),
      color: Colors.white,
    );
  }
}