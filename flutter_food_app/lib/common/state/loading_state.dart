class LoadingState {
  final bool loadingDetail;
  final bool loadingCart;
  final bool loadingNoti;

  const LoadingState(
      {this.loadingDetail,
        this.loadingCart,
        this.loadingNoti,
      });

  factory LoadingState.initial() => LoadingState(
    loadingDetail: true,
    loadingCart: true,
    loadingNoti: true,
  );
}
