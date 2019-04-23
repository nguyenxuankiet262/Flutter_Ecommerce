class PostManageState {
  final int indexCategory;
  final int indexChildCategory;
  final int filter;
  final int tempCategory;
  final int tempChildCategory;
  final int tempFilter;

  const PostManageState({
    this.indexCategory, this.indexChildCategory, this.filter,
    this.tempCategory,
    this.tempChildCategory,
    this.tempFilter
});

  factory PostManageState.initial() =>
      PostManageState(
        indexCategory: 0,
        indexChildCategory: 0,
        filter: 0,
        tempCategory: 0,
        tempChildCategory: 0,
        tempFilter: 0,
      );
}
