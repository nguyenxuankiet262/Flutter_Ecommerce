abstract class FavoriteManageEvent{}

class ChangeCategory extends FavoriteManageEvent{
  final int indexCategory;
  final int indexChildCategory;
  ChangeCategory(this.indexCategory, this.indexChildCategory);
}

class ChangeFilter extends FavoriteManageEvent{
  final int min;
  final int max;
  final int code;
  ChangeFilter(this.min, this.max, this.code);
}

class ChangeTempCategory extends FavoriteManageEvent{
  final int tempCategory;
  final int tempChildCategory;
  ChangeTempCategory(this.tempCategory, this.tempChildCategory);
}

class ChangeTempFilter extends FavoriteManageEvent{
  final int tempMin;
  final int tempMax;
  final int tempCode;
  ChangeTempFilter(this.tempMin, this.tempMax, this.tempCode);
}
