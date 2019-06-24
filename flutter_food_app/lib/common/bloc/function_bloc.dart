import 'package:bloc/bloc.dart';
import 'package:flutter_food_app/common/event/function_event.dart';
import 'package:flutter_food_app/common/state/function_state.dart';

class FunctionBloc extends Bloc<FunctionEvent, FunctionState> {
  void openDrawer(Function _openDrawer) {
    dispatch(OpenDrawer(_openDrawer));
  }

  void navigateToPost(Function(String) _navigateToPost) {
    dispatch(NavigateToPost(_navigateToPost));
  }

  void navigateToFilter(Function _navigateToFilter) {
    dispatch(NavigateToFilter(_navigateToFilter));
  }

  void navigateToFilterHome(Function _navigateToFilterHome) {
    dispatch(NavigateToFilterHome(_navigateToFilterHome));
  }

  void navigateToUser(Function(String) _navigateToUser) {
    dispatch(NavigateToUser(_navigateToUser));
  }

  void navigateToFollow(Function _navigateToFollow) {
    dispatch(NavigateToFollow(_navigateToFollow));
  }

  void navigateToAuthen(Function _navigateToAuthen) {
    dispatch(NavigateToAuthen(_navigateToAuthen));
  }

  void navigateToCamera(Function _navigateToCamera) {
    dispatch(NavigateToCamera(_navigateToCamera));
  }

  void navigateToInfoPost(Function _navigateToInfoPost) {
    dispatch(NavigateToInfoPost(_navigateToInfoPost));
  }

  void isLoading(Function _isLoading) {
    dispatch(IsLoading(_isLoading));
  }

  void onBackPressed(Function _onBackPressed) {
    dispatch(OnBackPressed(_onBackPressed));
  }

  void onPressFav(Function(String id) _onPressFav) {
    dispatch(OnPressFav(_onPressFav));
  }

  void onRefreshOrder(List<Function> _onRefreshOrder) {
    dispatch(OnRefreshOrder(_onRefreshOrder));
  }

  void onFetchProductMenu(Function(String idMenu, String code, String min, String max, String begin, String end, String address) _onFetchProductMenu) {
    dispatch(OnFetchProductMenu(_onFetchProductMenu));
  }

  void onFetchProductChildMenu(Function(String, String code, String min, String max, String begin, String end, String address) _onFetchProductChildMenu) {
    dispatch(OnFetchProductChildMenu(_onFetchProductChildMenu));
  }

  void onRefreshLoadMore(Function _onRefreshLoadMore){
    dispatch(OnRefreshLoadMore(_onRefreshLoadMore));
  }

  void navigateToDetailOrder(Function(String, int,String, bool) _navigateToDetailOrder) {
    dispatch(NavigateToDetailOrder(_navigateToDetailOrder));
  }

  void onBeforeLogin(Function _onBeforeLogin){
    dispatch(OnBeforeLogin(_onBeforeLogin));
  }

  @override
  // TODO: implement initialState
  FunctionState get initialState => FunctionState.initial();

  @override
  Stream<FunctionState> mapEventToState(
      FunctionState currentState, FunctionEvent event) async* {
    // TODO: implement mapEventToState
    if (event is OpenDrawer) {
      yield FunctionState(
        openDrawer: event.openDrawer,
        navigateToPost: currentState.navigateToPost,
        navigateToFilter: currentState.navigateToFilter,
        navigateToFilterHome: currentState.navigateToFilterHome,
        navigateToUser: currentState.navigateToUser,
        navigateToFollow: currentState.navigateToFollow,
        navigateToAuthen: currentState.navigateToAuthen,
        navigateToCamera: currentState.navigateToCamera,
        navigateToInfoPost: currentState.navigateToInfoPost,
        isLoading: currentState.isLoading,
        onBackPressed: currentState.onBackPressed,
        onRefreshOrder: currentState.onRefreshOrder,
        onFetchProductMenu: currentState.onFetchProductMenu,
        onFetchProductChildMenu: currentState.onFetchProductChildMenu,
        onRefreshLoadMore: currentState.onRefreshLoadMore,
        updateFavCart: currentState.updateFavCart,
        navigateToDetailOrder: currentState.navigateToDetailOrder,
        onBeforeLogin: currentState.onBeforeLogin,
      );
    }
    if (event is NavigateToPost) {
      yield FunctionState(
        openDrawer: currentState.openDrawer,
        navigateToPost: event.navigateToPost,
        navigateToFilter: currentState.navigateToFilter,
        navigateToFilterHome: currentState.navigateToFilterHome,
        navigateToUser: currentState.navigateToUser,
        navigateToFollow: currentState.navigateToFollow,
        navigateToAuthen: currentState.navigateToAuthen,
        navigateToCamera: currentState.navigateToCamera,
        navigateToInfoPost: currentState.navigateToInfoPost,
        isLoading: currentState.isLoading,
        onBackPressed: currentState.onBackPressed,
        onRefreshOrder: currentState.onRefreshOrder,
        onFetchProductMenu: currentState.onFetchProductMenu,
        onFetchProductChildMenu: currentState.onFetchProductChildMenu,
        onRefreshLoadMore: currentState.onRefreshLoadMore,
        updateFavCart: currentState.updateFavCart,
        navigateToDetailOrder: currentState.navigateToDetailOrder,
        onBeforeLogin: currentState.onBeforeLogin,
      );
    }
    if (event is NavigateToFilter) {
      yield FunctionState(
        openDrawer: currentState.openDrawer,
        navigateToPost: currentState.navigateToPost,
        navigateToFilter: event.navigateToFilter,
        navigateToFilterHome: currentState.navigateToFilterHome,
        navigateToUser: currentState.navigateToUser,
        navigateToFollow: currentState.navigateToFollow,
        navigateToAuthen: currentState.navigateToAuthen,
        navigateToCamera: currentState.navigateToCamera,
        navigateToInfoPost: currentState.navigateToInfoPost,
        isLoading: currentState.isLoading,
        onBackPressed: currentState.onBackPressed,
        onRefreshOrder: currentState.onRefreshOrder,
        onFetchProductMenu: currentState.onFetchProductMenu,
        onFetchProductChildMenu: currentState.onFetchProductChildMenu,
        onRefreshLoadMore: currentState.onRefreshLoadMore,
        updateFavCart: currentState.updateFavCart,
        navigateToDetailOrder: currentState.navigateToDetailOrder,
        onBeforeLogin: currentState.onBeforeLogin,
      );
    }

    if (event is NavigateToFilterHome) {
      yield FunctionState(
        openDrawer: currentState.openDrawer,
        navigateToPost: currentState.navigateToPost,
        navigateToFilter: currentState.navigateToFilter,
        navigateToFilterHome: event.navigateToFilterHome,
        navigateToUser: currentState.navigateToUser,
        navigateToFollow: currentState.navigateToFollow,
        navigateToAuthen: currentState.navigateToAuthen,
        navigateToCamera: currentState.navigateToCamera,
        navigateToInfoPost: currentState.navigateToInfoPost,
        isLoading: currentState.isLoading,
        onBackPressed: currentState.onBackPressed,
        onRefreshOrder: currentState.onRefreshOrder,
        onFetchProductMenu: currentState.onFetchProductMenu,
        onFetchProductChildMenu: currentState.onFetchProductChildMenu,
        onRefreshLoadMore: currentState.onRefreshLoadMore,
        updateFavCart: currentState.updateFavCart,
        navigateToDetailOrder: currentState.navigateToDetailOrder,
        onBeforeLogin: currentState.onBeforeLogin,
      );
    }

    if (event is NavigateToUser) {
      yield FunctionState(
        openDrawer: currentState.openDrawer,
        navigateToPost: currentState.navigateToPost,
        navigateToFilter: currentState.navigateToFilter,
        navigateToFilterHome: currentState.navigateToFilterHome,
        navigateToUser: event.navigateToUser,
        navigateToFollow: currentState.navigateToFollow,
        navigateToAuthen: currentState.navigateToAuthen,
        navigateToCamera: currentState.navigateToCamera,
        navigateToInfoPost: currentState.navigateToInfoPost,
        isLoading: currentState.isLoading,
        onBackPressed: currentState.onBackPressed,
        onRefreshOrder: currentState.onRefreshOrder,
        onFetchProductMenu: currentState.onFetchProductMenu,
        onFetchProductChildMenu: currentState.onFetchProductChildMenu,
        onRefreshLoadMore: currentState.onRefreshLoadMore,
        updateFavCart: currentState.updateFavCart,
        navigateToDetailOrder: currentState.navigateToDetailOrder,
        onBeforeLogin: currentState.onBeforeLogin,
      );
    }

    if (event is NavigateToFollow) {
      yield FunctionState(
        openDrawer: currentState.openDrawer,
        navigateToPost: currentState.navigateToPost,
        navigateToFilter: currentState.navigateToFilter,
        navigateToFilterHome: currentState.navigateToFilterHome,
        navigateToUser: currentState.navigateToUser,
        navigateToFollow: event.navigateToFollow,
        navigateToAuthen: currentState.navigateToAuthen,
        navigateToCamera: currentState.navigateToCamera,
        navigateToInfoPost: currentState.navigateToInfoPost,
        isLoading: currentState.isLoading,
        onBackPressed: currentState.onBackPressed,
        onRefreshOrder: currentState.onRefreshOrder,
        onFetchProductMenu: currentState.onFetchProductMenu,
        onFetchProductChildMenu: currentState.onFetchProductChildMenu,
        onRefreshLoadMore: currentState.onRefreshLoadMore,
        updateFavCart: currentState.updateFavCart,
        navigateToDetailOrder: currentState.navigateToDetailOrder,
        onBeforeLogin: currentState.onBeforeLogin,
      );
    }

    if (event is NavigateToAuthen) {
      yield FunctionState(
        openDrawer: currentState.openDrawer,
        navigateToPost: currentState.navigateToPost,
        navigateToFilter: currentState.navigateToFilter,
        navigateToFilterHome: currentState.navigateToFilterHome,
        navigateToUser: currentState.navigateToUser,
        navigateToFollow: currentState.navigateToFollow,
        navigateToAuthen: event.navigateToAuthen,
        navigateToCamera: currentState.navigateToCamera,
        navigateToInfoPost: currentState.navigateToInfoPost,
        isLoading: currentState.isLoading,
        onBackPressed: currentState.onBackPressed,
        onRefreshOrder: currentState.onRefreshOrder,
        onFetchProductMenu: currentState.onFetchProductMenu,
        onFetchProductChildMenu: currentState.onFetchProductChildMenu,
        onRefreshLoadMore: currentState.onRefreshLoadMore,
        updateFavCart: currentState.updateFavCart,
        navigateToDetailOrder: currentState.navigateToDetailOrder,
        onBeforeLogin: currentState.onBeforeLogin,
      );
    }

    if (event is NavigateToCamera) {
      yield FunctionState(
        openDrawer: currentState.openDrawer,
        navigateToPost: currentState.navigateToPost,
        navigateToFilter: currentState.navigateToFilter,
        navigateToFilterHome: currentState.navigateToFilterHome,
        navigateToUser: currentState.navigateToUser,
        navigateToFollow: currentState.navigateToFollow,
        navigateToAuthen: currentState.navigateToAuthen,
        navigateToCamera: event.navigateToCamera,
        navigateToInfoPost: currentState.navigateToInfoPost,
        isLoading: currentState.isLoading,
        onBackPressed: currentState.onBackPressed,
        onRefreshOrder: currentState.onRefreshOrder,
        onFetchProductMenu: currentState.onFetchProductMenu,
        onFetchProductChildMenu: currentState.onFetchProductChildMenu,
        onRefreshLoadMore: currentState.onRefreshLoadMore,
        updateFavCart: currentState.updateFavCart,
        navigateToDetailOrder: currentState.navigateToDetailOrder,
        onBeforeLogin: currentState.onBeforeLogin,
      );
    }

    if (event is NavigateToInfoPost) {
      yield FunctionState(
        openDrawer: currentState.openDrawer,
        navigateToPost: currentState.navigateToPost,
        navigateToFilter: currentState.navigateToFilter,
        navigateToFilterHome: currentState.navigateToFilterHome,
        navigateToUser: currentState.navigateToUser,
        navigateToFollow: currentState.navigateToFollow,
        navigateToAuthen: currentState.navigateToAuthen,
        navigateToCamera: currentState.navigateToCamera,
        navigateToInfoPost: event.navigateToInfoPost,
        isLoading: currentState.isLoading,
        onBackPressed: currentState.onBackPressed,
        onRefreshOrder: currentState.onRefreshOrder,
        onFetchProductMenu: currentState.onFetchProductMenu,
        onFetchProductChildMenu: currentState.onFetchProductChildMenu,
        onRefreshLoadMore: currentState.onRefreshLoadMore,
        updateFavCart: currentState.updateFavCart,
        navigateToDetailOrder: currentState.navigateToDetailOrder,
        onBeforeLogin: currentState.onBeforeLogin,
      );
    }

    if (event is IsLoading) {
      yield FunctionState(
        openDrawer: currentState.openDrawer,
        navigateToPost: currentState.navigateToPost,
        navigateToFilter: currentState.navigateToFilter,
        navigateToFilterHome: currentState.navigateToFilterHome,
        navigateToUser: currentState.navigateToUser,
        navigateToFollow: currentState.navigateToFollow,
        navigateToAuthen: currentState.navigateToAuthen,
        navigateToCamera: currentState.navigateToCamera,
        navigateToInfoPost: currentState.navigateToInfoPost,
        isLoading: event.isLoading,
        onBackPressed: currentState.onBackPressed,
        onRefreshOrder: currentState.onRefreshOrder,
        onFetchProductMenu: currentState.onFetchProductMenu,
        onFetchProductChildMenu: currentState.onFetchProductChildMenu,
        onRefreshLoadMore: currentState.onRefreshLoadMore,
        updateFavCart: currentState.updateFavCart,
        navigateToDetailOrder: currentState.navigateToDetailOrder,
        onBeforeLogin: currentState.onBeforeLogin,
      );
    }

    if (event is OnBackPressed) {
      yield FunctionState(
        openDrawer: currentState.openDrawer,
        navigateToPost: currentState.navigateToPost,
        navigateToFilter: currentState.navigateToFilter,
        navigateToFilterHome: currentState.navigateToFilterHome,
        navigateToUser: currentState.navigateToUser,
        navigateToFollow: currentState.navigateToFollow,
        navigateToAuthen: currentState.navigateToAuthen,
        navigateToCamera: currentState.navigateToCamera,
        navigateToInfoPost: currentState.navigateToInfoPost,
        isLoading: currentState.isLoading,
        onBackPressed: event.onBackPressed,
        onRefreshOrder: currentState.onRefreshOrder,
        onFetchProductMenu: currentState.onFetchProductMenu,
        onFetchProductChildMenu: currentState.onFetchProductChildMenu,
        onRefreshLoadMore: currentState.onRefreshLoadMore,
        updateFavCart: currentState.updateFavCart,
        navigateToDetailOrder: currentState.navigateToDetailOrder,
        onBeforeLogin: currentState.onBeforeLogin,
      );
    }

    if (event is OnRefreshOrder) {
      yield FunctionState(
        openDrawer: currentState.openDrawer,
        navigateToPost: currentState.navigateToPost,
        navigateToFilter: currentState.navigateToFilter,
        navigateToFilterHome: currentState.navigateToFilterHome,
        navigateToUser: currentState.navigateToUser,
        navigateToFollow: currentState.navigateToFollow,
        navigateToAuthen: currentState.navigateToAuthen,
        navigateToCamera: currentState.navigateToCamera,
        navigateToInfoPost: currentState.navigateToInfoPost,
        isLoading: currentState.isLoading,
        onBackPressed: currentState.onBackPressed,
        onRefreshOrder: event.onRefreshOrder,
        onFetchProductMenu: currentState.onFetchProductMenu,
        onFetchProductChildMenu: currentState.onFetchProductChildMenu,
        onRefreshLoadMore: currentState.onRefreshLoadMore,
        updateFavCart: currentState.updateFavCart,
        navigateToDetailOrder: currentState.navigateToDetailOrder,
        onBeforeLogin: currentState.onBeforeLogin,
      );
    }

    if (event is OnFetchProductMenu) {
      yield FunctionState(
        openDrawer: currentState.openDrawer,
        navigateToPost: currentState.navigateToPost,
        navigateToFilter: currentState.navigateToFilter,
        navigateToFilterHome: currentState.navigateToFilterHome,
        navigateToUser: currentState.navigateToUser,
        navigateToFollow: currentState.navigateToFollow,
        navigateToAuthen: currentState.navigateToAuthen,
        navigateToCamera: currentState.navigateToCamera,
        navigateToInfoPost: currentState.navigateToInfoPost,
        isLoading: currentState.isLoading,
        onBackPressed: currentState.onBackPressed,
        onRefreshOrder: currentState.onRefreshOrder,
        onFetchProductMenu: event.onFetchProductMenu,
        onFetchProductChildMenu: currentState.onFetchProductChildMenu,
        onRefreshLoadMore: currentState.onRefreshLoadMore,
        updateFavCart: currentState.updateFavCart,
        navigateToDetailOrder: currentState.navigateToDetailOrder,
        onBeforeLogin: currentState.onBeforeLogin,
      );
    }

    if (event is OnFetchProductChildMenu) {
      yield FunctionState(
        openDrawer: currentState.openDrawer,
        navigateToPost: currentState.navigateToPost,
        navigateToFilter: currentState.navigateToFilter,
        navigateToFilterHome: currentState.navigateToFilterHome,
        navigateToUser: currentState.navigateToUser,
        navigateToFollow: currentState.navigateToFollow,
        navigateToAuthen: currentState.navigateToAuthen,
        navigateToCamera: currentState.navigateToCamera,
        navigateToInfoPost: currentState.navigateToInfoPost,
        isLoading: currentState.isLoading,
        onBackPressed: currentState.onBackPressed,
        onRefreshOrder: currentState.onRefreshOrder,
        onFetchProductMenu: currentState.onFetchProductMenu,
        onFetchProductChildMenu: event.onFetchProductChildMenu,
        onRefreshLoadMore: currentState.onRefreshLoadMore,
        updateFavCart: currentState.updateFavCart,
        navigateToDetailOrder: currentState.navigateToDetailOrder,
        onBeforeLogin: currentState.onBeforeLogin,
      );
    }

    if (event is OnRefreshLoadMore) {
      yield FunctionState(
        openDrawer: currentState.openDrawer,
        navigateToPost: currentState.navigateToPost,
        navigateToFilter: currentState.navigateToFilter,
        navigateToFilterHome: currentState.navigateToFilterHome,
        navigateToUser: currentState.navigateToUser,
        navigateToFollow: currentState.navigateToFollow,
        navigateToAuthen: currentState.navigateToAuthen,
        navigateToCamera: currentState.navigateToCamera,
        navigateToInfoPost: currentState.navigateToInfoPost,
        isLoading: currentState.isLoading,
        onBackPressed: currentState.onBackPressed,
        onRefreshOrder: currentState.onRefreshOrder,
        onFetchProductMenu: currentState.onFetchProductMenu,
        onFetchProductChildMenu: currentState.onFetchProductChildMenu,
        onRefreshLoadMore: event.onRefreshLoadMore,
        updateFavCart: currentState.updateFavCart,
        navigateToDetailOrder: currentState.navigateToDetailOrder,
        onBeforeLogin: currentState.onBeforeLogin,
      );
    }

    if (event is OnPressFav) {
      yield FunctionState(
        openDrawer: currentState.openDrawer,
        navigateToPost: currentState.navigateToPost,
        navigateToFilter: currentState.navigateToFilter,
        navigateToFilterHome: currentState.navigateToFilterHome,
        navigateToUser: currentState.navigateToUser,
        navigateToFollow: currentState.navigateToFollow,
        navigateToAuthen: currentState.navigateToAuthen,
        navigateToCamera: currentState.navigateToCamera,
        navigateToInfoPost: currentState.navigateToInfoPost,
        isLoading: currentState.isLoading,
        onBackPressed: currentState.onBackPressed,
        onRefreshOrder: currentState.onRefreshOrder,
        onFetchProductMenu: currentState.onFetchProductMenu,
        onFetchProductChildMenu: currentState.onFetchProductChildMenu,
        onRefreshLoadMore: currentState.onRefreshLoadMore,
        updateFavCart: event.onPressFav,
        navigateToDetailOrder: currentState.navigateToDetailOrder,
        onBeforeLogin: currentState.onBeforeLogin,
      );
    }

    if (event is NavigateToDetailOrder) {
      yield FunctionState(
        openDrawer: currentState.openDrawer,
        navigateToPost: currentState.navigateToPost,
        navigateToFilter: currentState.navigateToFilter,
        navigateToFilterHome: currentState.navigateToFilterHome,
        navigateToUser: currentState.navigateToUser,
        navigateToFollow: currentState.navigateToFollow,
        navigateToAuthen: currentState.navigateToAuthen,
        navigateToCamera: currentState.navigateToCamera,
        navigateToInfoPost: currentState.navigateToInfoPost,
        isLoading: currentState.isLoading,
        onBackPressed: currentState.onBackPressed,
        onRefreshOrder: currentState.onRefreshOrder,
        onFetchProductMenu: currentState.onFetchProductMenu,
        onFetchProductChildMenu: currentState.onFetchProductChildMenu,
        onRefreshLoadMore: currentState.onRefreshLoadMore,
        updateFavCart: currentState.updateFavCart,
        navigateToDetailOrder: event.navigateToDetailOrder,
        onBeforeLogin: currentState.onBeforeLogin,
      );
    }

    if (event is OnBeforeLogin) {
      yield FunctionState(
        openDrawer: currentState.openDrawer,
        navigateToPost: currentState.navigateToPost,
        navigateToFilter: currentState.navigateToFilter,
        navigateToFilterHome: currentState.navigateToFilterHome,
        navigateToUser: currentState.navigateToUser,
        navigateToFollow: currentState.navigateToFollow,
        navigateToAuthen: currentState.navigateToAuthen,
        navigateToCamera: currentState.navigateToCamera,
        navigateToInfoPost: currentState.navigateToInfoPost,
        isLoading: currentState.isLoading,
        onBackPressed: currentState.onBackPressed,
        onRefreshOrder: currentState.onRefreshOrder,
        onFetchProductMenu: currentState.onFetchProductMenu,
        onFetchProductChildMenu: currentState.onFetchProductChildMenu,
        onRefreshLoadMore: currentState.onRefreshLoadMore,
        updateFavCart: currentState.updateFavCart,
        navigateToDetailOrder: currentState.navigateToDetailOrder,
        onBeforeLogin: event.onBeforeLogin,
      );
    }
  }
}
