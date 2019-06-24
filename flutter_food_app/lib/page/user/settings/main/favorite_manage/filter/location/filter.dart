import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/api/api.dart';
import 'package:flutter_food_app/api/model/product.dart';
import 'package:flutter_food_app/common/bloc/api_bloc.dart';
import 'package:flutter_food_app/common/bloc/favorite_manage_bloc.dart';
import 'package:flutter_food_app/common/bloc/function_bloc.dart';
import 'package:flutter_food_app/common/bloc/list_search_product_bloc.dart';
import 'package:flutter_food_app/common/bloc/loading_bloc.dart';
import 'package:flutter_food_app/common/bloc/search_bloc.dart';
import 'package:flutter_food_app/common/bloc/text_search_bloc.dart';
import 'package:flutter_food_app/common/state/favorite_manage_state.dart';
import 'package:flutter_food_app/common/state/search_state.dart';
import 'package:flutter_food_app/common/state/text_search_state.dart';
import 'category.dart';
import 'package:flutter_food_app/const/color_const.dart';

class FilterCategory extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FilterCategoryState();
}

class FilterCategoryState extends State<FilterCategory> {
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
                    automaticallyImplyLeading: false,
                    elevation: 0.5,
                    brightness: Brightness.light,
                    iconTheme: IconThemeData(
                      color: Colors.black, //change your color here
                    ),
                    title: Text(
                      "Danh mục",
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
                            onTap: () async {
                              favoriteManageBloc.changeCategory(
                                favState.tempCategory,
                                favState.tempChildCategory,
                              );
                              functionBloc.currentState.isLoading();
                              loadingBloc.changeLoadingFavManage(true);
                              Navigator.pop(context);
                              if (favState.tempCategory == 0) {
                                if(state.isSearch){
                                  functionBloc.currentState.onRefreshLoadMore();
                                  loadingBloc.changeLoadingSearch(true);
                                  searchProductBloc.changeListSearchProduct(List<Product>());
                                  await searchFavAllOfUser(searchProductBloc, loadingBloc,
                                      apiBloc.currentState.mainUser.id,
                                      inputState.searchInput,
                                      favState.code.toString(),
                                      favState.min.toString(),
                                      favState.max.toString(),
                                      "1",
                                      "10"
                                  );
                                }
                                await fetchFavOfUser(
                                    apiBloc,
                                    loadingBloc,
                                    apiBloc.currentState.mainUser.id,
                                    favState.code.toString(),
                                    favState.min.toString(),
                                    favState.max.toString(),
                                    "1",
                                    "10");
                              } else {
                                if (favState.tempChildCategory == 0) {
                                  if(state.isSearch){
                                    functionBloc.currentState.onRefreshLoadMore();
                                    loadingBloc.changeLoadingSearch(true);
                                    searchProductBloc.changeListSearchProduct(List<Product>());
                                    await searchFavOfMenuOfUser(searchProductBloc, loadingBloc,
                                        apiBloc
                                            .currentState
                                            .listMenu[
                                        favState.tempCategory]
                                            .id,
                                        apiBloc.currentState.mainUser.id,
                                        inputState.searchInput,
                                        favState.code.toString(),
                                        favState.min.toString(),
                                        favState.max.toString(),
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
                                      favState.tempCategory]
                                          .id,
                                      favState.code.toString(),
                                      favState.min.toString(),
                                      favState.max.toString(),
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
                                        favState.tempCategory]
                                            .listChildMenu[favState.tempChildCategory]
                                            .id,
                                        apiBloc.currentState.mainUser.id,
                                        inputState.searchInput,
                                        favState.code.toString(),
                                        favState.min.toString(),
                                        favState.max.toString(),
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
                                      favState.tempCategory]
                                          .listChildMenu[favState.tempChildCategory]
                                          .id,
                                      favState.code.toString(),
                                      favState.min.toString(),
                                      favState.max.toString(),
                                      "1",
                                      "10");
                                }
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
                      home: CategoryRadio(),
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
      },
    );
  }
}
