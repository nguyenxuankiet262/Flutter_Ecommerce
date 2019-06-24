abstract class PostManageEvent{}

class ChangeCategory extends PostManageEvent{
  final int indexCategory;
  final int indexChildCategory;
  ChangeCategory(this.indexCategory, this.indexChildCategory);
}

class ChangeFilter extends PostManageEvent{
  final int min;
  final int max;
  final int code;
  ChangeFilter(this.min, this.max, this.code);
}

class ChangeTempCategory extends PostManageEvent{
  final int tempCategory;
  final int tempChildCategory;
  ChangeTempCategory(this.tempCategory, this.tempChildCategory);
}

class ChangeTempFilter extends PostManageEvent{
  final int tempMin;
  final int tempMax;
  final int tempCode;
  ChangeTempFilter(this.tempMin, this.tempMax, this.tempCode);
}

