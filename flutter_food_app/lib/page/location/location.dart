import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/api/api.dart';
import 'package:flutter_food_app/common/bloc/api_bloc.dart';
import 'package:flutter_food_app/common/bloc/bottom_bar_bloc.dart';
import 'package:flutter_food_app/common/bloc/function_bloc.dart';
import 'package:flutter_food_app/common/bloc/list_search_product_bloc.dart';
import 'package:flutter_food_app/common/bloc/loading_bloc.dart';
import 'package:flutter_food_app/common/bloc/location_bloc.dart';
import 'package:flutter_food_app/common/bloc/search_bloc.dart';
import 'package:flutter_food_app/common/bloc/text_search_bloc.dart';
import 'package:flutter_food_app/common/state/search_state.dart';
import 'package:flutter_food_app/common/state/text_search_state.dart';
import 'list_city.dart';
import 'package:flutter_food_app/const/color_const.dart';

class LocationPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => LocationPageState();
}

class LocationPageState extends State<LocationPage>{
  SearchBloc searchBloc;
  SearchInputBloc searchInputBloc;
  ListSearchProductBloc searchProductBloc;
  LocationBloc locationBloc;
  LoadingBloc loadingBloc;
  FunctionBloc functionBloc;
  ApiBloc apiBloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiBloc = BlocProvider.of(context);
    searchBloc = BlocProvider.of<SearchBloc>(context);
    searchInputBloc = BlocProvider.of<SearchInputBloc>(context);
    searchProductBloc = BlocProvider.of<ListSearchProductBloc>(context);
    functionBloc = BlocProvider.of<FunctionBloc>(context);
    loadingBloc = BlocProvider.of<LoadingBloc>(context);
    locationBloc = BlocProvider.of<LocationBloc>(context);
    BlocProvider.of<BottomBarBloc>(context)
        .changeVisible(true);
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder(
      bloc: searchBloc,
      builder: (context, SearchState state){
        return BlocBuilder(
          bloc: searchInputBloc,
          builder: (context, TextSearchState inputState){
            return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                elevation: 0.5,
                brightness: Brightness.light,
                iconTheme: IconThemeData(
                  color: Colors.black, //change your color here
                ),
                title: Text(
                  "Khu vực",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                backgroundColor: Colors.white,
                centerTitle: true,
                leading: new Center(
                  child: Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: GestureDetector(
                      child: Text(
                        'HỦY',
                        textScaleFactor: 1.5,
                        style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                            fontSize: 10),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
                actions: <Widget>[
                  new Center(
                    child: Padding(
                      padding: EdgeInsets.only(right: 16),
                      child: GestureDetector(
                        child: Text(
                          'ÁP DỤNG',
                          textScaleFactor: 1.5,
                          style: TextStyle(
                              color: colorActive,
                              fontWeight: FontWeight.bold,
                              fontSize: 10),
                        ),
                        onTap: () {
                          locationBloc.changeLocation(
                            locationBloc.currentState.tempCity,
                            locationBloc.currentState.tempProvince,
                          );
                          Navigator.pop(context);
                          String address = " ";
                          if (locationBloc.currentState.tempCity != 0) {
                            if (locationBloc.currentState.tempProvince != 0) {
                              address = locationBloc.currentState
                                  .nameProvinces[locationBloc.currentState.tempCity]
                              [locationBloc.currentState.tempProvince] +
                                  ", " +
                                  locationBloc.currentState.nameCities[locationBloc.currentState.tempCity];
                            } else {
                              address = locationBloc.currentState.nameCities[locationBloc.currentState.tempCity];
                            }
                          }
                          apiBloc.changeTopNewest(null);
                          apiBloc.changeTopFav(null);
                          fetchTopTenNewestProduct(apiBloc, address);
                          fetchTopTenFavProduct(apiBloc, address);
                          if(state.isSearch){
                            functionBloc.currentState.onRefreshLoadMore();
                            loadingBloc.changeLoadingSearch(true);
                            searchProductsAll(searchProductBloc, loadingBloc, inputState.searchInput, "1", "10", address);
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
              body: Container(
                color: colorBackground,
                child: MaterialApp(
                  home: ListCity(),
                  theme: ThemeData(
                    fontFamily: 'Montserrat',
                  ),
                  debugShowCheckedModeBanner: false,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
