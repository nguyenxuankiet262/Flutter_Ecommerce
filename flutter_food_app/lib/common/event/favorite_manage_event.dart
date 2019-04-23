abstract class FavoriteManageEvent{}

class ChangeCategory extends FavoriteManageEvent{
  final int indexCategory;
  final int indexChildCategory;
  ChangeCategory(this.indexCategory, this.indexChildCategory);
}

class ChangeFilter extends FavoriteManageEvent{
  final int filter;
  ChangeFilter(this.filter);
}

class ChangeTempCategory extends FavoriteManageEvent{
  final int tempCategory;
  final int tempChildCategory;
  ChangeTempCategory(this.tempCategory, this.tempChildCategory);
}

class ChangeTempFilter extends FavoriteManageEvent{
  final int tempFilter;
  ChangeTempFilter(this.tempFilter);
}
