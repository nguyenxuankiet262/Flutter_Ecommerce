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

  void changeLoadingNoti(bool isLoading) {
    dispatch(ChangeLoadingNoti(isLoading));
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
        loadingNoti: currentState.loadingNoti
      );
    }
    if (event is ChangeLoadingCart) {
      yield LoadingState(
          loadingDetail: currentState.loadingDetail,
          loadingCart: event.isLoading,
          loadingNoti: currentState.loadingNoti
      );
    }
    if (event is ChangeLoadingNoti) {
      yield LoadingState(
          loadingDetail: currentState.loadingDetail,
          loadingCart: currentState.loadingCart,
          loadingNoti: event.isLoading,
      );
    }
  }
}
