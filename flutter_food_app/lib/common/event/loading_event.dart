abstract class LoadingEvent{}

class ChangeLoadingDetail extends LoadingEvent{
  final bool isLoading;
  ChangeLoadingDetail(this.isLoading);
}

class ChangeLoadingCart extends LoadingEvent{
  final bool isLoading;
  ChangeLoadingCart(this.isLoading);
}

class ChangeLoadingNoti extends LoadingEvent{
  final bool isLoading;
  ChangeLoadingNoti(this.isLoading);
}

