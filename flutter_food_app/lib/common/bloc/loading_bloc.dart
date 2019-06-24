import 'package:bloc/bloc.dart';
import 'package:flutter_food_app/common/event/loading_event.dart';
import 'package:flutter_food_app/common/state/loading_state.dart';

class LoadingBloc extends Bloc<LoadingEvent, LoadingState> {
  void changeLoadingDetail(bool isLoading) {
    dispatch(ChangeLoadingDetail(isLoading));
  }

  void changeLoadingCart(bool isLoading) {
    dispatch(ChangeLoadingCart(isLoading));
  }

  void changeLoadingPostManage(bool isLoading) {
    dispatch(ChangeLoadingPostManage(isLoading));
  }

  void changeLoadingFavManage(bool isLoading) {
    dispatch(ChangeLoadingFavManage(isLoading));
  }

  void changeLoadingSearch(bool isLoading) {
    dispatch(ChangeLoadingSearch(isLoading));
  }

  void changeLoadingSysNoti(bool isLoading) {
    dispatch(ChangeLoadSysNoti(isLoading));
  }

  void changeLoadingFollowNoti(bool isLoading) {
    dispatch(ChangeLoadFollowNoti(isLoading));
  }

  @override
  // TODO: implement initialState
  LoadingState get initialState => LoadingState.initial();

  @override
  Stream<LoadingState> mapEventToState(
      LoadingState currentState, LoadingEvent event) async* {
    // TODO: implement mapEventToState
    if (event is ChangeLoadingDetail) {
      yield LoadingState(
        loadingDetail: event.isLoading,
        loadingCart: currentState.loadingCart,
        loadingPostManage: currentState.loadingPostManage,
        loadingFavManage: currentState.loadingFavManage,
        loadingSearch: currentState.loadingSearch,
        loadingSysNoti: currentState.loadingSysNoti,
        loadingFollowNoti: currentState.loadingFollowNoti,
      );
    }
    if (event is ChangeLoadingCart) {
      yield LoadingState(
        loadingDetail: currentState.loadingDetail,
        loadingCart: event.isLoading,
        loadingPostManage: currentState.loadingPostManage,
        loadingFavManage: currentState.loadingFavManage,
        loadingSearch: currentState.loadingSearch,
        loadingSysNoti: currentState.loadingSysNoti,
        loadingFollowNoti: currentState.loadingFollowNoti,
      );
    }
    if (event is ChangeLoadingPostManage) {
      yield LoadingState(
        loadingDetail: currentState.loadingDetail,
        loadingCart: currentState.loadingCart,
        loadingPostManage: event.isLoading,
        loadingFavManage: currentState.loadingFavManage,
        loadingSearch: currentState.loadingSearch,
        loadingSysNoti: currentState.loadingSysNoti,
        loadingFollowNoti: currentState.loadingFollowNoti,
      );
    }
    if (event is ChangeLoadingFavManage) {
      yield LoadingState(
        loadingDetail: currentState.loadingDetail,
        loadingCart: currentState.loadingCart,
        loadingPostManage: currentState.loadingPostManage,
        loadingFavManage: event.isLoading,
        loadingSearch: currentState.loadingSearch,
        loadingSysNoti: currentState.loadingSysNoti,
        loadingFollowNoti: currentState.loadingFollowNoti,
      );
    }

    if (event is ChangeLoadingSearch) {
      yield LoadingState(
        loadingDetail: currentState.loadingDetail,
        loadingCart: currentState.loadingCart,
        loadingPostManage: currentState.loadingPostManage,
        loadingFavManage: currentState.loadingFavManage,
        loadingSearch: event.isLoading,
        loadingSysNoti: currentState.loadingSysNoti,
        loadingFollowNoti: currentState.loadingFollowNoti,
      );
    }

    if (event is ChangeLoadSysNoti) {
      yield LoadingState(
        loadingDetail: currentState.loadingDetail,
        loadingCart: currentState.loadingCart,
        loadingPostManage: currentState.loadingPostManage,
        loadingFavManage: currentState.loadingFavManage,
        loadingSearch: currentState.loadingFollowNoti,
        loadingSysNoti: event.isLoading,
        loadingFollowNoti: currentState.loadingFollowNoti,
      );
    }

    if (event is ChangeLoadFollowNoti) {
      yield LoadingState(
        loadingDetail: currentState.loadingDetail,
        loadingCart: currentState.loadingCart,
        loadingPostManage: currentState.loadingPostManage,
        loadingFavManage: currentState.loadingFavManage,
        loadingSearch: currentState.loadingSearch,
        loadingSysNoti: currentState.loadingSysNoti,
        loadingFollowNoti: event.isLoading,
      );
    }
  }
}
