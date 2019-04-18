import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/common/bloc/detail_camera_bloc.dart';
import 'package:flutter_food_app/common/state/detail_camera.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:toast/toast.dart';

class ListImage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ListImageState();
}

class ListImageState extends State<ListImage> {
  int itemCount = 10;
  DetailCameraBloc blocProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    blocProvider = BlocProvider.of<DetailCameraBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder(
      bloc: blocProvider,
      builder: (context, DetailCameraState state) {
        return ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: state.imagePaths.length,
          itemBuilder: (BuildContext context, int index) => GestureDetector(
                child: Container(
                  margin: EdgeInsets.only(right: 10.0),
                  width: 100,
                  height: 90,
                  decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),
                  child: Stack(
                    children: <Widget>[
                      Center(
                        child: Icon(
                          Icons.add,
                          size: 30,
                        ),
                      ),
                      Container(
                        child: ClipRRect(
                          child: Image.file(
                            File(state.imagePaths[index]),
                            fit: BoxFit.fill,
                          ),
                          borderRadius:
                              new BorderRadius.all(Radius.circular(5.0)),
                        ),
                        width: 100,
                        height: 100,
                      ),
                      index == 0
                          ? Positioned(
                              bottom: 0,
                              height: 25,
                              width: 100,
                              child: Container(
                                height: 10,
                                width: double.infinity,
                                color: Colors.black.withOpacity(0.5),
                                child: Center(
                                  child: Text(
                                    "Ảnh bìa",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontFamily: "Ralway"),
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                      Positioned(
                          top: 0,
                          right: 0,
                          height: 25,
                          width: 25,
                          child: GestureDetector(
                            onTap: () {
                              if(state.imagePaths.length != 1){
                                List<String> temp =
                                    blocProvider.currentState.imagePaths;
                                temp.removeAt(index);
                                blocProvider.changeImageList(temp);
                              }
                              else{
                                Toast.show("Bài viết có ít nhất 1 ảnh bìa!", context);
                              }
                            },
                            child: Container(
                              height: 10,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.5),
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(5.0))),
                              child: Center(
                                  child: Icon(
                                FontAwesomeIcons.times,
                                size: 12,
                                color: Colors.white,
                              )),
                            ),
                          ))
                    ],
                  ),
                ),
              ),
        );
      },
    );
  }
}
