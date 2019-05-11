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

  void navigateToUser(Function _navigateToUser) {
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
      );
    }
  }
}
