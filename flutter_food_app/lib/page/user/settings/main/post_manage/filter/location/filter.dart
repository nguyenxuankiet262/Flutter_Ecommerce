import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/api/api.dart';
import 'package:flutter_food_app/api/model/product.dart';
import 'package:flutter_food_app/common/bloc/api_bloc.dart';
import 'package:flutter_food_app/common/bloc/function_bloc.dart';
import 'package:flutter_food_app/common/bloc/list_search_product_bloc.dart';
import 'package:flutter_food_app/common/bloc/loading_bloc.dart';
import 'package:flutter_food_app/common/bloc/post_manage_bloc.dart';
import 'package:flutter_food_app/common/bloc/search_bloc.dart';
import 'package:flutter_food_app/common/bloc/text_search_bloc.dart';
import 'package:flutter_food_app/common/state/post_manage_state.dart';
import 'package:flutter_food_app/common/state/search_state.dart';
import 'package:flutter_food_app/common/state/text_search_state.dart';
import 'package:flutter_food_app/page/user/settings/main/post_manage/filter/location/category.dart';
import 'package:flutter_food_app/const/color_const.dart';

class FilterCategory extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FilterCategoryState();
}

class FilterCategoryState extends State<FilterCategory> {
  PostManageBloc postManageBloc;
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
    postManageBloc = BlocProvider.of<PostManageBloc>(context);
    loadingBloc = BlocProvider.of<LoadingBloc>(context);
    apiBloc = BlocProvider.of<ApiBloc>(context);
    functionBloc = BlocProvider.of<FunctionBloc>(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    postManageBloc.changeTempFilter(postManageBloc.currentState.min,
        postManageBloc.currentState.max, postManageBloc.currentState.code);
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
              bloc: postManageBloc,
              builder: (context, PostManageState postState) {
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
                              postManageBloc.changeCategory(
                                postManageBloc.currentState.tempCategory,
                                postManageBloc.currentState.tempChildCategory,
                              );
                              functionBloc.currentState.isLoading();
                              loadingBloc.changeLoadingPostManage(true);
                              Navigator.pop(context);
                              if (postManageBloc.currentState.tempCategory == 0) {
                                if(state.isSearch){
                                  functionBloc.currentState.onRefreshLoadMore();
                                  loadingBloc.changeLoadingSearch(true);
                                  searchProductBloc.changeListSearchProduct(List<Product>());
                                  await searchProductsAllOfUser(searchProductBloc, loadingBloc,
                                      apiBloc.currentState.mainUser.id,
                                      inputState.searchInput,
                                      postManageBloc.currentState.code.toString(),
                                      postManageBloc.currentState.min.toString(),
                                      postManageBloc.currentState.max.toString(),
                                      "1",
                                      "10"
                                  );
                                }
                                await fetchProductOfUser(
                                    apiBloc,
                                    loadingBloc,
                                    apiBloc.currentState.mainUser.id,
                                    postManageBloc.currentState.code.toString(),
                                    postManageBloc.currentState.min.toString(),
                                    postManageBloc.currentState.max.toString(),
                                    "1",
                                    "10");
                              } else {
                                if (postManageBloc.currentState.tempChildCategory == 0) {
                                  if(state.isSearch){
                                    functionBloc.currentState.onRefreshLoadMore();
                                    loadingBloc.changeLoadingSearch(true);
                                    searchProductBloc.changeListSearchProduct(List<Product>());
                                    await searchProductsOfMenuOfUser(searchProductBloc, loadingBloc,
                                        apiBloc
                                            .currentState
                                            .listMenu[
                                        postManageBloc.currentState.tempCategory]
                                            .id,
                                        apiBloc.currentState.mainUser.id,
                                        inputState.searchInput,
                                        postManageBloc.currentState.code.toString(),
                                        postManageBloc.currentState.min.toString(),
                                        postManageBloc.currentState.max.toString(),
                                        "1",
                                        "10"
                                    );
                                  }
                                  await fetchProductOfMenuOfUser(
                                      apiBloc,
                                      loadingBloc,
                                      apiBloc.currentState.mainUser.id,
                                      apiBloc
                                          .currentState
                                          .listMenu[
                                      postManageBloc.currentState.tempCategory]
                                          .id,
                                      postManageBloc.currentState.code.toString(),
                                      postManageBloc.currentState.min.toString(),
                                      postManageBloc.currentState.max.toString(),
                                      "1",
                                      "10");
                                } else {
                                  if(state.isSearch){
                                    functionBloc.currentState.onRefreshLoadMore();
                                    loadingBloc.changeLoadingSearch(true);
                                    searchProductBloc.changeListSearchProduct(List<Product>());
                                    await searchProductsOfChildMenuOfUser(searchProductBloc, loadingBloc,
                                        apiBloc
                                            .currentState
                                            .listMenu[
                                        postManageBloc.currentState.tempCategory]
                                            .listChildMenu[postManageBloc
                                            .currentState.tempChildCategory]
                                            .id,
                                        apiBloc.currentState.mainUser.id,
                                        inputState.searchInput,
                                        postManageBloc.currentState.code.toString(),
                                        postManageBloc.currentState.min.toString(),
                                        postManageBloc.currentState.max.toString(),
                                        "1",
                                        "10"
                                    );
                                    await fetchProductOfChildMenuOfUser(
                                        apiBloc,
                                        loadingBloc,
                                        apiBloc.currentState.mainUser.id,
                                        apiBloc
                                            .currentState
                                            .listMenu[
                                        postManageBloc.currentState.tempCategory]
                                            .listChildMenu[postManageBloc
                                            .currentState.tempChildCategory]
                                            .id,
                                        postManageBloc.currentState.code.toString(),
                                        postManageBloc.currentState.min.toString(),
                                        postManageBloc.currentState.max.toString(),
                                        "1",
                                        "10");
                                  }
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
