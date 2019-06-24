import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/common/bloc/another_user_bloc.dart';
import 'package:flutter_food_app/common/state/another_user_state.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class InfoItem extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => InfoItemState();
}

class InfoItemState extends State<InfoItem> {
  AnotherUserBloc anotherUserBloc;
  final f = new DateFormat('dd-MM-yyyy');
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    anotherUserBloc = BlocProvider.of<AnotherUserBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder(
      bloc: anotherUserBloc,
      builder: (context, AnotherUserState state) {
        return state.user == null
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
                padding: EdgeInsets.symmetric(horizontal :16.0, vertical: state.user.intro != null ? 16.0 : 0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    state.user.intro != null
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
                              margin: EdgeInsets.only(left: 10.0),
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
                        : Container(
                      height: 0,
                      width: 0,
                    ),
                    state.user.intro != null
                        ? Container(
                      margin: EdgeInsets.only(top: 16.0),
                      child: Text(
                        state.user.intro,
                        style: TextStyle(
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.w500,
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
                      state.user.address,
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
                      f.format(state.user.day),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Raleway',
                      ),
                    ),
                    state.user.link != null
                    ? Container(
                      margin: EdgeInsets.only(top: 16.0, bottom: 16.0),
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
                    : Container(),
                    state.user.link != null
                    ? Text(
                      state.user.link,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: colorFB,
                          fontStyle: FontStyle.italic,
                          fontFamily: 'Raleway',
                          decoration: TextDecoration.underline
                      ),
                    )
                    : Container(),
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
