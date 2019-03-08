import "package:flutter/material.dart";
import 'category.dart';
import 'header.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:flutter_food_app/page/detail/detail.dart';

class MyHomePage extends StatefulWidget {
  Function callback1, callback2;
  MyHomePage(this.callback1, this.callback2);
  @override
  State<StatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with AutomaticKeepAliveClientMixin {
  SearchBar searchBar;

  void navigateToListPost() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ListAllPost(this.navigateToPost, this.navigateToUserPage)),
    );
  }

  void navigateToPost(){
    this.widget.callback1();
  }

  void navigateToUserPage(){
    this.widget.callback2();
  }

  _MyHomePageState() {
    searchBar = new SearchBar(
        inBar: false,
        setState: setState,
        onSubmitted: print,
        buildDefaultAppBar: buildAppBar);
  }

  AppBar buildAppBar(BuildContext context) {
    return new AppBar(
        brightness: Brightness.light,
        leading: GestureDetector(
          child: Image.asset('assets/images/logo.png'),
          onTap: (){

          },
        ),
        title: new Text(
          'Anzi',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          textAlign: TextAlign.justify,
        ),
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: [searchBar.getSearchAction(context)]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(128.0), // here the desired height
        child: Column(
          children: <Widget>[
            searchBar.build(context),
            HeaderHome(this.navigateToListPost),
            new Container(
              height: 1,
              color: Colors.black12,
            ),
          ],
        ),
      ),
      body: ListCategory(this.navigateToListPost, this.navigateToPost, this.navigateToUserPage),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
