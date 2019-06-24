class Liked {
  int liked;

  Liked({
    this.liked,
  });

  factory Liked.fromJson(Map<String, dynamic> json) => new Liked(
    liked: json["liked"],
  );

  Map<String, dynamic> toJson() => {
    "liked": liked,
  };
}