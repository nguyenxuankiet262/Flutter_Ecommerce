class FunctionState {
  final Function openDrawer;
  final Function(String) navigateToPost;
  final Function navigateToFilter;
  final Function navigateToFilterHome;
  final Function(String) navigateToUser;
  final Function navigateToFollow;
  final Function navigateToAuthen;
  final Function navigateToCamera;
  final Function navigateToInfoPost;
  final Function isLoading;
  final Function onBackPressed;
  final Function onBeforeLogin;
  final List<Function> onRefreshOrder;
  final Function(String idMenu, String code, String min, String max,
      String begin, String end, String address) onFetchProductMenu;
  final Function(String, String code, String min, String max, String begin,
      String end, String address) onFetchProductChildMenu;
  final Function onRefreshLoadMore;
  final Function updateFavCart;
  final Function(String, int, String, bool) navigateToDetailOrder;

  const FunctionState({
    this.openDrawer,
    this.navigateToPost,
    this.navigateToFilter,
    this.navigateToFilterHome,
    this.navigateToUser,
    this.navigateToFollow,
    this.navigateToAuthen,
    this.navigateToCamera,
    this.navigateToInfoPost,
    this.isLoading,
    this.onBackPressed,
    this.onRefreshOrder,
    this.onFetchProductMenu,
    this.onFetchProductChildMenu,
    this.onRefreshLoadMore,
    this.updateFavCart,
    this.navigateToDetailOrder,
    this.onBeforeLogin,
  });

  factory FunctionState.initial() => FunctionState(
        openDrawer: () {},
        navigateToPost: (String temp) {},
        navigateToFilter: () {},
        navigateToFilterHome: () {},
        navigateToUser: (String idUser) {},
        navigateToFollow: () {},
        navigateToAuthen: () {},
        navigateToCamera: () {},
        navigateToInfoPost: () {},
        navigateToDetailOrder: (String idUser, int index, String order, bool isSeller) {},
        isLoading: () {},
        onBackPressed: () {},
        onRefreshOrder: new List<Function>(),
        onFetchProductMenu: (String idMenu, String code, String min, String max,
            String begin, String end, String address) {},
        onFetchProductChildMenu: (String idChildMenu, String code, String min,
            String max, String begin, String end, String address) {},
        onRefreshLoadMore: () {},
        updateFavCart: (String id) {},
    onBeforeLogin: (){}
      );
}
