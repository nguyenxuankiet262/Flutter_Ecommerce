import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/common/bloc/text_search_bloc.dart';
import 'package:flutter_food_app/common/state/text_search_state.dart';
import 'list_search_post.dart';

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
            resizeToAvoidBottomPadding: false,
            backgroundColor: Colors.black54,
            body: state.searchInput.isNotEmpty
                ? GestureDetector(
              child: ListSearchPost(),
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
