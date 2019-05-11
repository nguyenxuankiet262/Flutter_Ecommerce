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
  final Function navigateToUser;
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

