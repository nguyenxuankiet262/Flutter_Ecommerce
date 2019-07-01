import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/common/bloc/text_search_bloc.dart';
import 'package:flutter_food_app/common/state/text_search_state.dart';
import 'package:flutter_food_app/page/admin/member/user/search/list_search_user.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  SearchInputBloc searchInputBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchInputBloc = BlocProvider.of<SearchInputBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder(
      bloc: searchInputBloc,
      builder: (context, TextSearchState state) {
        return Scaffold(
            resizeToAvoidBottomPadding: true,
            backgroundColor: Colors.black54,
            body: state.searchInput.isNotEmpty
                ? GestureDetector(
              child: ListSearchUser(),
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
            )
                : Container(
              color: Colors.transparent,
              height: MediaQuery
                  .of(context)
                  .size
                  .height,
              child: ListView(
                shrinkWrap: true,
              ),
            ));
      },
    );
  }
}
