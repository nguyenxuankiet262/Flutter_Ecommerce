import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/api/api.dart';
import 'package:flutter_food_app/api/model/product.dart';
import 'package:flutter_food_app/common/bloc/api_bloc.dart';
import 'package:flutter_food_app/common/bloc/bottom_bar_bloc.dart';
import 'package:flutter_food_app/common/bloc/favorite_manage_bloc.dart';
import 'package:flutter_food_app/common/bloc/function_bloc.dart';
import 'package:flutter_food_app/common/bloc/list_search_product_bloc.dart';
import 'package:flutter_food_app/common/bloc/loading_bloc.dart';
import 'package:flutter_food_app/common/bloc/search_bloc.dart';
import 'package:flutter_food_app/common/bloc/text_search_bloc.dart';
import 'package:flutter_food_app/common/state/favorite_manage_state.dart';
import 'package:flutter_food_app/common/state/search_state.dart';
import 'package:flutter_food_app/common/state/text_search_state.dart';
import 'package:flutter_food_app/const/color_const.dart';
import 'sort.dart';
import 'price.dart';

class FilterCommon extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FilterCommonState();
}

class FilterCommonState extends State<FilterCommon> {
  FavoriteManageBloc favoriteManageBloc;
  FunctionBloc functionBloc;
  LoadingBloc loadingBloc;
  ApiBloc apiBloc;
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
    favoriteManageBloc = BlocProvider.of<FavoriteManageBloc>(context);
    loadingBloc = BlocProvider.of<LoadingBloc>(context);
    apiBloc = BlocProvider.of<ApiBloc>(context);
    functionBloc = BlocProvider.of<FunctionBloc>(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    favoriteManageBloc.changeTempFilter(favoriteManageBloc.currentState.min,
        favoriteManageBloc.currentState.max, favoriteManageBloc.currentState.code);
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
              bloc: favoriteManageBloc,
              builder: (context, FavoriteManageState favState) {
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
                              favoriteManageBloc.changeTempFilter(
                                  favoriteManageBloc.initialState.tempMin,
                                  favoriteManageBloc.initialState.tempMax,
                                  favoriteManageBloc.initialState.tempCode);
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
                        SortContent()
                      ],
                    ),
                  ),
                  bottomNavigationBar: Container(
                      height: 50,
                      width: double.infinity,
                      child: RaisedButton(
                        onPressed: () async {
                          favoriteManageBloc.changeFilter(
                              favState.tempMin, favState.tempMax, favState.tempCode);
                          BlocProvider.of<FunctionBloc>(context)
                              .currentState
                              .isLoading();
                          functionBloc.currentState.isLoading();
                          loadingBloc.changeLoadingFavManage(true);
                          Navigator.pop(context);
                          if (favoriteManageBloc.currentState.indexCategory == 0) {
                            if(state.isSearch){
                              functionBloc.currentState.onRefreshLoadMore();
                              loadingBloc.changeLoadingSearch(true);
                              searchProductBloc.changeListSearchProduct(List<Product>());
                              await searchFavAllOfUser(searchProductBloc, loadingBloc,
                                  apiBloc.currentState.mainUser.id,
                                  inputState.searchInput,
                                  favoriteManageBloc.currentState.tempCode.toString(),
                                  favoriteManageBloc.currentState.tempMin.toString(),
                                  favoriteManageBloc.currentState.tempMax.toString(),
                                  "1",
                                  "10"
                              );
                            }
                            await fetchFavOfUser(
                                apiBloc,
                                loadingBloc,
                                apiBloc.currentState.mainUser.id,
                                favoriteManageBloc.currentState.tempCode.toString(),
                                favoriteManageBloc.currentState.tempMin.toString(),
                                favoriteManageBloc.currentState.tempMax.toString(),
                                "1",
                                "10");
                          } else {
                            if (favoriteManageBloc.currentState.indexChildCategory == 0) {
                              if(state.isSearch){
                                functionBloc.currentState.onRefreshLoadMore();
                                loadingBloc.changeLoadingSearch(true);
                                searchProductBloc.changeListSearchProduct(List<Product>());
                                await searchFavOfMenuOfUser(searchProductBloc, loadingBloc,
                                    apiBloc
                                        .currentState
                                        .listMenu[
                                    favoriteManageBloc.currentState.indexCategory]
                                        .id,
                                    apiBloc.currentState.mainUser.id,
                                    inputState.searchInput,
                                    favoriteManageBloc.currentState.tempCode.toString(),
                                    favoriteManageBloc.currentState.tempMin.toString(),
                                    favoriteManageBloc.currentState.tempMax.toString(),
                                    "1",
                                    "10"
                                );
                              }
                              await fetchFavOfMenuOfUser(
                                  apiBloc,
                                  loadingBloc,
                                  apiBloc.currentState.mainUser.id,
                                  apiBloc
                                      .currentState
                                      .listMenu[
                                  favoriteManageBloc.currentState.indexCategory]
                                      .id,
                                  favoriteManageBloc.currentState.tempCode.toString(),
                                  favoriteManageBloc.currentState.tempMin.toString(),
                                  favoriteManageBloc.currentState.tempMax.toString(),
                                  "1",
                                  "10");

                            } else {
                              if(state.isSearch){
                                functionBloc.currentState.onRefreshLoadMore();
                                loadingBloc.changeLoadingSearch(true);
                                searchProductBloc.changeListSearchProduct(List<Product>());
                                await searchFavOfChildMenuOfUser(searchProductBloc, loadingBloc,
                                    apiBloc
                                        .currentState
                                        .listMenu[
                                    favoriteManageBloc.currentState.indexCategory]
                                        .listChildMenu[favoriteManageBloc
                                        .currentState.indexChildCategory]
                                        .id,
                                    apiBloc.currentState.mainUser.id,
                                    inputState.searchInput,
                                    favoriteManageBloc.currentState.tempCode.toString(),
                                    favoriteManageBloc.currentState.tempMin.toString(),
                                    favoriteManageBloc.currentState.tempMax.toString(),
                                    "1",
                                    "10"
                                );
                              }
                              await fetchFavOfChildMenuOfUser(
                                  apiBloc,
                                  loadingBloc,
                                  apiBloc.currentState.mainUser.id,
                                  apiBloc
                                      .currentState
                                      .listMenu[
                                  favoriteManageBloc.currentState.indexCategory]
                                      .listChildMenu[favoriteManageBloc
                                      .currentState.indexChildCategory]
                                      .id,
                                  favoriteManageBloc.currentState.tempCode.toString(),
                                  favoriteManageBloc.currentState.tempMin.toString(),
                                  favoriteManageBloc.currentState.tempMax.toString(),
                                  "1",
                                  "10");
                            }
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
