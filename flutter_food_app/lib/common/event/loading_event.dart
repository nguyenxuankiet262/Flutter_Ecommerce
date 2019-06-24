abstract class LoadingEvent{}

class ChangeLoadingDetail extends LoadingEvent{
  final bool isLoading;
  ChangeLoadingDetail(this.isLoading);
}

class ChangeLoadingCart extends LoadingEvent{
  final bool isLoading;
  ChangeLoadingCart(this.isLoading);
}

class ChangeLoadingPostManage extends LoadingEvent{
  final bool isLoading;
  ChangeLoadingPostManage(this.isLoading);
}

class ChangeLoadingFavManage extends LoadingEvent{
  final bool isLoading;
  ChangeLoadingFavManage(this.isLoading);
}

class ChangeLoadingSearch extends LoadingEvent{
  final bool isLoading;
  ChangeLoadingSearch(this.isLoading);
}

class ChangeLoadSysNoti extends LoadingEvent{
  final bool isLoading;
  ChangeLoadSysNoti(this.isLoading);
}

class ChangeLoadFollowNoti extends LoadingEvent{
  final bool isLoading;
  ChangeLoadFollowNoti(this.isLoading);
}