import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/common/bloc/api_bloc.dart';
import 'package:flutter_food_app/common/state/api_state.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class InfoItem extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => InfoItemState();
}

class InfoItemState extends State<InfoItem> {
  ApiBloc apiBloc;
  final f = new DateFormat('dd-MM-yyyy');
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiBloc = BlocProvider.of<ApiBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder(
      bloc: apiBloc,
      builder: (context, ApiState apiState) {
        return apiState.mainUser == null
            ? Shimmer.fromColors(
                child: Container(
                  height: 400,
                  color: Colors.white,
                ),
                baseColor: Colors.grey[300],
                highlightColor: Colors.grey[100],
              )
            : ListView(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          apiState.mainUser.intro.isNotEmpty
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Icon(
                                          FontAwesomeIcons.userTie,
                                          size: 14,
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(left: 10.0),
                                          child: Text(
                                            "Thông tin",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'Raleway',
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              : Container(
                                  height: 0,
                                  width: 0,
                                ),
                          apiState.mainUser.intro.isNotEmpty
                              ? Container(
                                  margin: EdgeInsets.only(top: 16.0),
                                  child: Text(
                                    apiState.mainUser.intro,
                                    style: TextStyle(
                                      fontFamily: 'Raleway',
                                      fontSize: 14,
                                    ),
                                  ),
                                )
                              : Container(
                                  height: 0,
                                  width: 0,
                                ),
                          Container(
                            margin: EdgeInsets.only(top: 16.0, bottom: 16.0),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  FontAwesomeIcons.home,
                                  size: 14,
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 10.0),
                                  child: Text(
                                    "Địa chỉ",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Raleway',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            apiState.mainUser.address,
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Raleway',
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 16.0, bottom: 16.0),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  FontAwesomeIcons.home,
                                  size: 14,
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 10.0),
                                  child: Text(
                                    "Ngày tham gia",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Raleway',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            f.format(apiState.mainUser.day),
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Raleway',
                            ),
                          ),
                          Container(
                            height: 200,
                            color: Colors.white,
                          )
                        ],
                      )),
                ],
              );
      },
    );
  }
}
