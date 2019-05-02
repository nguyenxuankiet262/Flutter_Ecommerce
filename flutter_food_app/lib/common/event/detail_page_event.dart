abstract class DetailPageEvent{}

class ChangeCategory extends DetailPageEvent{
  final int indexCategory;
  final int indexChildCategory;
  ChangeCategory(this.indexCategory, this.indexChildCategory);
}

class ChangeFilter extends DetailPageEvent{
  final int filter;
  ChangeFilter(this.filter);
}

class ChangeTempCategory extends DetailPageEvent{
  final int tempCategory;
  final int tempChildCategory;
  ChangeTempCategory(this.tempCategory, this.tempChildCategory);
}

class ChangeTempFilter extends DetailPageEvent{
  final int tempFilter;
  ChangeTempFilter(this.tempFilter);
}
