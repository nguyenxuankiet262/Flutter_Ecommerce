import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/common/bloc/text_search_bloc.dart';
import 'package:flutter_food_app/common/state/text_search_state.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter_food_app/page/user/settings/main/feedback_manage/list_feedback.dart';

class SearchPage extends StatefulWidget {
  final int _index;
  SearchPage(this._index);
  @override
  State<StatefulWidget> createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: colorBackground,
        body: BlocBuilder(
            bloc: BlocProvider.of<SearchInputBloc>(context),
            builder: (context, TextSearchState state) {
              return state.searchInput.isNotEmpty
                  ? ListFeedback(widget._index)
                  : Container(
                      color: colorBackground,
                    );
            }));
  }
}
