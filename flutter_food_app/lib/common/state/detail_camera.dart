class DetailCameraState{
  final List<String> imagePaths;
  final String title;
  final String content;
  final int indexCategory;
  final int indexChildCategory;
  final String priceBefore;
  final String priceAfter;
  final String unit;

  const DetailCameraState({this.imagePaths, this.title, this.content, this.indexCategory, this.indexChildCategory, this.priceBefore, this.priceAfter, this.unit});

  factory DetailCameraState.initial() => DetailCameraState(
    imagePaths: [],
    title: "",
    content: "",
    indexCategory: 1,
    indexChildCategory: 1,
    priceBefore: "0",
    priceAfter: "0",
    unit: "kg",
  );
}