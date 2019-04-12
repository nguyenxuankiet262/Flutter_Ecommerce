abstract class FunctionEvent{}

class OpenDrawer extends FunctionEvent{
  final Function openDrawer;
  OpenDrawer(this.openDrawer);
}

class NavigateToPost extends FunctionEvent{
  final Function navigateToPost;
  NavigateToPost(this.navigateToPost);
}

class NavigateToFilter extends FunctionEvent{
  final Function navigateToFilter;
  NavigateToFilter(this.navigateToFilter);
}

class NavigateToUser extends FunctionEvent{
  final Function navigateToUser;
  NavigateToUser(this.navigateToUser);
}
