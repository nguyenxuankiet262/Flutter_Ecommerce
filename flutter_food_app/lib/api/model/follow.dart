class Follow {
  int code;
  int following;
  int follower;

  Follow({
    this.code,
    this.following,
    this.follower,
  });

  factory Follow.fromJson(Map<String, dynamic> json) => new Follow(
    code: json["code"],
    following: json["following"],
    follower: json["follower"],
  );
}