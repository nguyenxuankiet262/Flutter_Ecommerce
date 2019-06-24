abstract class FunctionEvent{}

class OpenDrawer extends FunctionEvent{
  final Function openDrawer;
  OpenDrawer(this.openDrawer);
}

class NavigateToPost extends FunctionEvent{
  final Function(String) navigateToPost;
  NavigateToPost(this.navigateToPost);
}

class NavigateToFilter extends FunctionEvent{
  final Function navigateToFilter;
  NavigateToFilter(this.navigateToFilter);
}

class NavigateToFilterHome extends FunctionEvent{
  final Function navigateToFilterHome;
  NavigateToFilterHome(this.navigateToFilterHome);
}

class NavigateToUser extends FunctionEvent{
  final Function(String) navigateToUser;
  NavigateToUser(this.navigateToUser);
}

class NavigateToFollow extends FunctionEvent{
  final Function navigateToFollow;
  NavigateToFollow(this.navigateToFollow);
}

class NavigateToAuthen extends FunctionEvent{
  final Function navigateToAuthen;
  NavigateToAuthen(this.navigateToAuthen);
}

class NavigateToCamera extends FunctionEvent{
  final Function navigateToCamera;
  NavigateToCamera(this.navigateToCamera);
}

class NavigateToInfoPost extends FunctionEvent{
  final Function navigateToInfoPost;
  NavigateToInfoPost(this.navigateToInfoPost);
}

class IsLoading extends FunctionEvent{
  final Function isLoading;
  IsLoading(this.isLoading);
}

class OnBackPressed extends FunctionEvent{
  final Function onBackPressed;
  OnBackPressed(this.onBackPressed);
}

class OnRefreshOrder extends FunctionEvent{
  final List<Function> onRefreshOrder;
  OnRefreshOrder(this.onRefreshOrder);
}

class OnFetchProductMenu extends FunctionEvent{
  final Function(String idMenu, String code, String min, String max, String begin, String end, String address) onFetchProductMenu;
  OnFetchProductMenu(this.onFetchProductMenu);
}

class OnFetchProductChildMenu extends FunctionEvent{
  final Function(String, String code, String min, String max, String begin, String end, String address) onFetchProductChildMenu;
  OnFetchProductChildMenu(this.onFetchProductChildMenu);
}

class OnRefreshLoadMore extends FunctionEvent{
  final Function onRefreshLoadMore;
  OnRefreshLoadMore(this.onRefreshLoadMore);
}

class OnPressFav extends FunctionEvent{
  final Function(String id) onPressFav;
  OnPressFav(this.onPressFav);
}

class NavigateToDetailOrder extends FunctionEvent{
  final Function(String idUser, int index, String order, bool isSeller) navigateToDetailOrder;
  NavigateToDetailOrder(this.navigateToDetailOrder);
}

class OnBeforeLogin extends FunctionEvent{
  final Function onBeforeLogin;
  OnBeforeLogin(this.onBeforeLogin);
}