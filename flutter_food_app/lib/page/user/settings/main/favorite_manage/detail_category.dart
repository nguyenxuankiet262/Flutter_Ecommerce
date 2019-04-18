import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/common/bloc/address_bloc.dart';
import 'list_post.dart';

class DetailCategory extends StatefulWidget{
  final int index;

  DetailCategory(this.index);

  @override
  State<StatefulWidget> createState() => DetailCategoryState();
}

class DetailCategoryState extends State<DetailCategory>{
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<AddressBloc>(context).changeIndex(2);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      primary: false,
      appBar:
      PreferredSize(child: Container(), preferredSize: Size(0.0, 0.0)),
      body: ListPost(),
    );
  }
}