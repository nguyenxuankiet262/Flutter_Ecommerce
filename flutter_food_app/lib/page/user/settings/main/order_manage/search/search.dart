import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/common/bloc/text_search_bloc.dart';
import 'package:flutter_food_app/common/state/text_search_state.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter_food_app/page/user/settings/main/order_manage/list_order.dart';

class SearchPage extends StatefulWidget {
  final int _index;
  final bool isSellOrder;

  SearchPage(this._index, this.isSellOrder);
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
                  ? ListOrder(widget._index, widget.isSellOrder)
                  : Container(
                      color: colorBackground,
                    );
            }));
  }
}
