class LoadingState {
  final bool loadingDetail;
  final bool loadingCart;
  final bool loadingPostManage;
  final bool loadingFavManage;
  final bool loadingAnother;
  final bool loadingSearch;
  final bool loadingSysNoti;
  final bool loadingFollowNoti;

  const LoadingState(
      {this.loadingDetail,
        this.loadingCart,
        this.loadingPostManage,
        this.loadingFavManage,
        this.loadingAnother,
        this.loadingSearch,
        this.loadingFollowNoti,
        this.loadingSysNoti
      });

  factory LoadingState.initial() => LoadingState(
    loadingDetail: true,
    loadingCart: true,
    loadingPostManage: true,
    loadingFavManage: true,
    loadingAnother: true,
    loadingSearch: true,
    loadingFollowNoti: true,
    loadingSysNoti: true,
  );
}
