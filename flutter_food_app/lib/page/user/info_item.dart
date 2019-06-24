import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/common/bloc/api_bloc.dart';
import 'package:flutter_food_app/common/state/api_state.dart';
import 'package:flutter_food_app/const/color_const.dart';
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
                      padding: EdgeInsets.symmetric(horizontal :16.0, vertical: apiState.mainUser.intro != null ? 16.0 : 0.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          apiState.mainUser.intro != null
                              ? apiState.mainUser.intro.isNotEmpty
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Icon(
                                              FontAwesomeIcons.userAlt,
                                              color: Colors.grey,
                                              size: 18,
                                            ),
                                            Container(
                                              margin:
                                                  EdgeInsets.only(left: 10.0),
                                              child: Text(
                                                "Thông tin",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: 'Raleway',
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  : Container()
                              : Container(),
                          apiState.mainUser.intro != null
                              ? apiState.mainUser.intro.isNotEmpty
                                  ? Container(
                                      margin: EdgeInsets.only(top: 16.0),
                                      child: Text(
                                        apiState.mainUser.intro,
                                        style: TextStyle(
                                          fontFamily: 'Raleway',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                        ),
                                      ),
                                    )
                                  : Container()
                              : Container(),
                          Container(
                            margin: EdgeInsets.only(
                                top: apiState.mainUser.intro != null
                                    ? apiState.mainUser.intro.isNotEmpty
                                        ? 16.0
                                        : 0.0
                                    : 0.0,
                                bottom: 16.0),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  FontAwesomeIcons.home,
                                  color: Colors.grey,
                                  size: 18,
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 10.0),
                                  child: Text(
                                    "Địa chỉ",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Raleway',
                                      fontWeight: FontWeight.w500,
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
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Raleway',
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 16.0, bottom: 16.0),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  FontAwesomeIcons.solidClock,
                                  color: Colors.grey,
                                  size: 18,
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 10.0),
                                  child: Text(
                                    "Ngày tham gia",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
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
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Raleway',
                            ),
                          ),
                          apiState.mainUser.link != null
                              ? apiState.mainUser.link.isNotEmpty
                                  ? Container(
                                      margin: EdgeInsets.only(
                                          top: 16.0, bottom: 16.0),
                                      child: Row(
                                        children: <Widget>[
                                          Icon(
                                            FontAwesomeIcons.link,
                                            color: Colors.grey,
                                            size: 18,
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(left: 10.0),
                                            child: Text(
                                              "Liên kết",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontFamily: 'Raleway',
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Container()
                              : Container(),
                          apiState.mainUser.link != null
                              ? Text(
                                  apiState.mainUser.link,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: colorFB,
                                      fontStyle: FontStyle.italic,
                                      fontFamily: 'Raleway',
                                      decoration: TextDecoration.underline),
                                )
                              : Text(""),
                          Container(
                            height: 201,
                            color: Colors.white,
                          ),
                        ],
                      )),
                ],
              );
      },
    );
  }
}
