class FunctionState {
  final Function openDrawer;
  final Function navigateToPost;
  final Function navigateToFilter;
  final Function navigateToUser;
  final Function navigateToFollow;
  final Function navigateToAuthen;
  final Function navigateToCamera;
  final Function navigateToInfoPost;
  final Function isLoading;
  final Function onBackPressed;

  const FunctionState({
    this.openDrawer,
    this.navigateToPost,
    this.navigateToFilter,
    this.navigateToUser,
    this.navigateToFollow,
    this.navigateToAuthen,
    this.navigateToCamera,
    this.navigateToInfoPost,
    this.isLoading,
    this.onBackPressed,
  });

  factory FunctionState.initial() => FunctionState(
        openDrawer: () {},
        navigateToPost: () {},
        navigateToFilter: () {},
        navigateToUser: () {},
        navigateToFollow: () {},
        navigateToAuthen: () {},
        navigateToCamera: () {},
        navigateToInfoPost: () {},
        isLoading: () {},
        onBackPressed: () {},
      );
}
