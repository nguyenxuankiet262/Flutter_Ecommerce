import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/api/api.dart';
import 'package:flutter_food_app/api/model/product.dart';
import 'package:flutter_food_app/common/bloc/api_bloc.dart';
import 'package:flutter_food_app/common/bloc/bottom_bar_bloc.dart';
import 'package:flutter_food_app/common/bloc/detail_bloc.dart';
import 'package:flutter_food_app/common/bloc/function_bloc.dart';
import 'package:flutter_food_app/common/bloc/list_search_product_bloc.dart';
import 'package:flutter_food_app/common/bloc/loading_bloc.dart';
import 'package:flutter_food_app/common/bloc/location_bloc.dart';
import 'package:flutter_food_app/common/bloc/search_bloc.dart';
import 'package:flutter_food_app/common/bloc/text_search_bloc.dart';
import 'package:flutter_food_app/common/state/detail_page_state.dart';
import 'package:flutter_food_app/common/state/search_state.dart';
import 'package:flutter_food_app/common/state/text_search_state.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'package:flutter_food_app/page/filter/common/price.dart';
import 'package:flutter_food_app/page/filter/common/sort.dart';

class FilterPage extends StatefulWidget {
  //_index = 1: full options
  //_index = 2: remove location sort and price sort
  //_index = 3: only rating sort
  @override
  State<StatefulWidget> createState() => FilterPageState();
}

class FilterPageState extends State<FilterPage> {
  DetailPageBloc detailPageBloc;
  FunctionBloc functionBloc;
  LoadingBloc loadingBloc;
  ApiBloc apiBloc;
  LocationBloc locationBloc;
  String address = "";
  SearchBloc searchBloc;
  SearchInputBloc searchInputBloc;
  ListSearchProductBloc searchProductBloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchBloc = BlocProvider.of<SearchBloc>(context);
    searchInputBloc = BlocProvider.of<SearchInputBloc>(context);
    searchProductBloc = BlocProvider.of<ListSearchProductBloc>(context);
    locationBloc = BlocProvider.of<LocationBloc>(context);
    if(locationBloc.currentState.indexCity != 0){
      if(locationBloc.currentState.indexProvince != 0){
        address = locationBloc.currentState.nameProvinces
        [locationBloc.currentState.indexCity]
        [locationBloc.currentState.indexProvince]
            + ", "
            + locationBloc.currentState.nameCities
            [locationBloc.currentState.indexCity];
      }
      else{
        address = locationBloc.currentState.nameCities
        [locationBloc.currentState.indexCity];
      }
    }
    detailPageBloc = BlocProvider.of<DetailPageBloc>(context);
    loadingBloc = BlocProvider.of<LoadingBloc>(context);
    apiBloc = BlocProvider.of<ApiBloc>(context);
    functionBloc = BlocProvider.of<FunctionBloc>(context);
    BlocProvider.of<BottomBarBloc>(context).changeVisible(false);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    detailPageBloc.changeTempFilter(detailPageBloc.currentState.min,
        detailPageBloc.currentState.max, detailPageBloc.currentState.code);
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
            return BlocBuilder(
              bloc: detailPageBloc,
              builder: (context, DetailPageState detailState) {
                return Scaffold(
                  appBar: AppBar(
                    elevation: 0.5,
                    brightness: Brightness.light,
                    title: new Text(
                      "Lọc",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 20),
                    ),
                    centerTitle: true,
                    backgroundColor: Colors.white,
                    iconTheme: IconThemeData(
                      color: Colors.black, //change your color here
                    ),
                    actions: <Widget>[
                      new Center(
                        child: Padding(
                          padding: EdgeInsets.only(right: 16),
                          child: GestureDetector(
                            child: Text(
                              'ĐẶT LẠI',
                              textScaleFactor: 1.5,
                              style: TextStyle(
                                  color: colorActive,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10),
                            ),
                            onTap: () {
                              detailPageBloc.changeTempFilter(
                                  detailPageBloc.initialState.tempMin,
                                  detailPageBloc.initialState.tempMax,
                                  detailPageBloc.initialState.tempCode);
                            },
                          ),
                        ),
                      ),
                    ],
                    leading: GestureDetector(
                      child: Icon(Icons.arrow_back),
                      onTap: () {
                        BlocProvider.of<BottomBarBloc>(context).changeVisible(true);
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  body: Container(
                    color: Colors.white,
                    child: ListView(
                      children: <Widget>[
                        PriceFilter(),
                        SortContent(),
                      ],
                    ),
                  ),
                  bottomNavigationBar: Container(
                      height: 50,
                      width: double.infinity,
                      child: RaisedButton(
                        onPressed: () async {
                          detailPageBloc.changeFilter(
                              detailState.tempMin, detailState.tempMax, detailState.tempCode);

                          BlocProvider.of<BottomBarBloc>(context).changeVisible(true);
                          BlocProvider.of<FunctionBloc>(context)
                              .currentState
                              .isLoading();
                          loadingBloc.changeLoadingDetail(true);
                          Navigator.pop(context);
                          if (detailState.indexChildCategory == 0) {
                            if(state.isSearch){
                              functionBloc.currentState.onRefreshLoadMore();
                              loadingBloc.changeLoadingSearch(true);
                              searchProductBloc.changeListSearchProduct(List<Product>());
                              await searchProductsOfMenu(searchProductBloc, loadingBloc, apiBloc
                                  .currentState
                                  .listMenu[
                              detailState.indexCategory]
                                  .id,
                                  inputState.searchInput,
                                  detailState.tempCode.toString(),
                                  detailState.tempMin.toString(),
                                  detailState.tempMax.toString(),
                                  "1",
                                  "10",
                                  address);
                            }
                            await functionBloc.currentState.onFetchProductMenu(
                                apiBloc
                                    .currentState
                                    .listMenu[detailState.indexCategory]
                                    .id,
                                detailState.tempCode.toString(),
                                detailState.tempMin.toString(),
                                detailState.tempMax.toString(),
                                "1",
                                "10",
                                address);
                          } else {
                            if(state.isSearch){
                              functionBloc.currentState.onRefreshLoadMore();
                              loadingBloc.changeLoadingSearch(true);
                              searchProductBloc.changeListSearchProduct(List<Product>());
                              await searchProductsOfChildMenu(searchProductBloc, loadingBloc, apiBloc
                                  .currentState
                                  .listMenu[
                              detailState.indexCategory]
                                  .listChildMenu[detailState.indexChildCategory]
                                  .id,
                                  inputState.searchInput,
                                  detailState.tempCode.toString(),
                                  detailState.tempMin.toString(),
                                  detailState.tempMax.toString(),
                                  "1",
                                  "10",
                                  address);
                            }
                            await functionBloc.currentState.onFetchProductChildMenu(
                                apiBloc
                                    .currentState
                                    .listMenu[detailState.indexCategory]
                                    .listChildMenu[
                                detailState.indexChildCategory]
                                    .id,
                                detailState.tempCode.toString(),
                                detailState.tempMin.toString(),
                                detailState.tempMax.toString(),
                                "1",
                                "10",
                                address);
                          }
                        },
                        color: colorActive,
                        child: Center(
                          child: Text(
                            'ÁP DỤNG',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 12.0),
                          ),
                        ),
                      )),
                );
              },
            );
          },
        );
      },
    );
  }
}
