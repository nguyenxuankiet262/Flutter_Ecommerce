abstract class DetailPageEvent{}

class ChangeCategory extends DetailPageEvent{
  final int indexCategory;
  final int indexChildCategory;
  ChangeCategory(this.indexCategory, this.indexChildCategory);
}

class ChangeFilter extends DetailPageEvent{
  final int min;
  final int max;
  final int code;
  ChangeFilter(this.min, this.max, this.code);
}

class ChangeTempCategory extends DetailPageEvent{
  final int tempCategory;
  final int tempChildCategory;
  ChangeTempCategory(this.tempCategory, this.tempChildCategory);
}

class ChangeTempFilter extends DetailPageEvent{
  final int tempMin;
  final int tempMax;
  final int tempCode;
  ChangeTempFilter(this.tempMin, this.tempMax, this.tempCode);
}

