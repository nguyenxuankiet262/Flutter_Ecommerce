import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/common/bloc/api_bloc.dart';
import 'package:flutter_food_app/common/bloc/detail_bloc.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter_food_app/page/detail/detail.dart';

class HeaderHome extends StatefulWidget {
  final Function navigateToPost, navigateToFilter;

  HeaderHome(this.navigateToPost, this.navigateToFilter);

  @override
  State<StatefulWidget> createState() => HeaderHomeState();
}

class HeaderHomeState extends State<HeaderHome> {
  DetailPageBloc detailPageBloc;
  ApiBloc apiBloc;
  void _gotoDetailScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ListAllPost(),
      ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    detailPageBloc = BlocProvider.of<DetailPageBloc>(context);
    apiBloc = BlocProvider.of<ApiBloc>(context);
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: apiBloc.currentState.listMenu.length - 1,
        itemBuilder: (BuildContext context, int index) => GestureDetector(
              onTap: () {
                detailPageBloc.changeCategory(index + 1, 0);
                _gotoDetailScreen();
              },
              child: Container(
                margin: EdgeInsets.only(
                    left: 16.0,
                    right: index == apiBloc.currentState.listMenu.length - 2 ? 16.0 : 0.0,
                ),
                width: 80.0,
                decoration: new BoxDecoration(
                  color: Colors.white,
                  border: new Border.all(color: colorInactive),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                child: Stack(
                  children: <Widget>[
                    Container(
                      child: ClipRRect(
                          child: Image.network(
                            apiBloc.currentState.listMenu[index + 1].link,
                            fit: BoxFit.fill,
                          ),
                          borderRadius:
                              new BorderRadius.all(Radius.circular(10.0))
                      ),
                      width: 80,
                      height: 80,
                    ),
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius:
                            new BorderRadius.all(Radius.circular(10.0)),
                        color: Colors.black.withOpacity(0.3),
                      ),
                    ),
                    Center(
                        child: Text(
                          apiBloc.currentState.listMenu[index + 1].name,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    )),
                  ],
                ),
              ),
            ),
      ),
      height: 80,
      color: colorBackground,
    );
  }
}
