import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/common/bloc/api_bloc.dart';
import 'package:flutter_food_app/common/bloc/post_manage_bloc.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter_food_app/model/category.dart';
import 'child_category.dart';
import 'package:flutter/scheduler.dart';

class CategoryRadio extends StatefulWidget {
  @override
  createState() {
    return new CategoryRadioState();
  }
}

class CategoryRadioState extends State<CategoryRadio> {
  List<CategoryModel> categories = new List<CategoryModel>();
  ApiBloc apiBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiBloc = BlocProvider.of<ApiBloc>(context);
    for (int i = 0; i < apiBloc.currentState.listMenu.length; i++) {
      categories.add(new CategoryModel(apiBloc.currentState.listMenu[i].link, apiBloc.currentState.listMenu[i].name));
    }
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ChildCategory(BlocProvider.of<PostManageBloc>(context).currentState.indexCategory))
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        primary: false,
        appBar:
            PreferredSize(child: Container(), preferredSize: Size(0.0, 0.0)),
        body: new ListView.builder(
          itemCount: categories.length,
          itemBuilder: (BuildContext context, int index) {
            return new InkWell(
              //highlightColor: Colors.red,
              splashColor: colorActive,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChildCategory(index))
                );
              },

              child: new CategeoryItem(categories[index]),
            );
          },
        ),
    );
  }
}

class CategeoryItem extends StatelessWidget {
  final CategoryModel _item;

  CategeoryItem(this._item);

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: new EdgeInsets.all(16.0),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              bottom: BorderSide(
                  color: colorInactive.withOpacity(0.2), width: 0.5))),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Container(
              margin: new EdgeInsets.only(left: 10.0),
              child:new Text(
                _item.text,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),),
          new Container(
            height: 24.0,
            width: 24.0,
            child: new Center(
              child: Icon(
                Icons.keyboard_arrow_right,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
