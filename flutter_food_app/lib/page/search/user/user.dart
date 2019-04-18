import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/common/bloc/text_search_bloc.dart';
import 'package:flutter_food_app/common/state/text_search_state.dart';
import 'package:flutter_food_app/page/search/hotkey.dart';
import 'list_user.dart';
import 'search_user.dart';

class UserContent extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => UserContentState();
}

class UserContentState extends State<UserContent> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder(
        bloc: BlocProvider.of<SearchInputBloc>(context),
        builder: (context, TextSearchState state) {
          return state.searchInput.isNotEmpty
              ? SearchUser()
              : Container(
              color: Colors.white,
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  Container(
                    padding:
                    EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
                    child: Text(
                      "TỪ KHÓA HOT",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 17
                      ),
                    ),
                  ),
                  HotkeyContent(2),
                  Container(
                    padding: EdgeInsets.only(left: 16.0, right: 16.0),
                    child: Text(
                      "GỢI Ý",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                          fontSize: 17
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10.0),
                    child: ListUser(),
                  )
                ],
              ));
        });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}