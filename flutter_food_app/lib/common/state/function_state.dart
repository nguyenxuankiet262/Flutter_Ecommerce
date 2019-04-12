class FunctionState {
  final Function openDrawer;
  final Function navigateToPost;
  final Function navigateToFilter;
  final Function navigateToUser;

  const FunctionState(
      {this.openDrawer,
      this.navigateToPost,
      this.navigateToFilter,
      this.navigateToUser});

  factory FunctionState.initial() => FunctionState(
      openDrawer: () {},
      navigateToPost: () {},
      navigateToFilter: () {},
      navigateToUser: () {});
}
