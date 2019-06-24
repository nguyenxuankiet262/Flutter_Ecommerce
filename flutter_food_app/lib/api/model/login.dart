class Login {
  String token;
  String user;
  int code;
  String status;

  Login({
    this.token,
    this.user,
    this.code,
    this.status,
  });

  factory Login.fromJson(Map<String, dynamic> json) => new Login(
    token: json["token"],
    user: json["user"],
    code: json["code"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "token": token,
    "user": user,
    "code": code,
    "status": status,
  };
}