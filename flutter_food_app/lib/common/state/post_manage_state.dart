class PostManageState {
  final int indexCategory;
  final int indexChildCategory;
  final int min;
  final int max;
  final int code;
  final int tempCategory;
  final int tempChildCategory;
  final int tempMin;
  final int tempMax;
  final int tempCode;

  const PostManageState({
    this.indexCategory, this.indexChildCategory, this.min,
    this.max,
    this.code,
    this.tempCategory,
    this.tempChildCategory,
    this.tempMin,
    this.tempMax,
    this.tempCode,
  });

  factory PostManageState.initial() =>
      PostManageState(
        indexCategory: 0,
        indexChildCategory: 0,
        min: 0,
        max: 10000000,
        code: 4,
        tempCategory: 0,
        tempChildCategory: 0,
        tempMin: 0,
        tempMax: 10000000,
        tempCode: 4,
      );
}
