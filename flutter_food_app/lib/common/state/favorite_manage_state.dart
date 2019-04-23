class FavoriteManageState {
  final int indexCategory;
  final int indexChildCategory;
  final int filter;
  final int tempCategory;
  final int tempChildCategory;
  final int tempFilter;

  const FavoriteManageState({
    this.indexCategory, this.indexChildCategory, this.filter,
    this.tempCategory,
    this.tempChildCategory,
    this.tempFilter
});

  factory FavoriteManageState.initial() =>
      FavoriteManageState(
        indexCategory: 0,
        indexChildCategory: 0,
        filter: 0,
        tempCategory: 0,
        tempChildCategory: 0,
        tempFilter: 0,
      );
}
