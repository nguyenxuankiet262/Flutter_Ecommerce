class AmountFav{
  int code;
  int like;
  AmountFav({
    this.code,
    this.like,
  });

  factory AmountFav.fromJson(Map<String, dynamic> json) => new AmountFav(
    code: json["code"],
    like: json["like"],
  );
}