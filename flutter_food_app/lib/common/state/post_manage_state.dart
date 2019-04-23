class PostManageState {
  final int indexCategory;
  final int indexChildCategory;
  final int filter;

  const PostManageState({this.indexCategory, this.indexChildCategory, this.filter});

  factory PostManageState.initial() =>
      PostManageState(
        indexCategory: 0,
        indexChildCategory: 0,
        filter: 0,
      );
}
