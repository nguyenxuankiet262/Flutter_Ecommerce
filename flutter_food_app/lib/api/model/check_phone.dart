class Code {
  int code;
  String msg;

  Code({
    this.code,
    this.msg,
  });

  factory Code.fromJson(Map<String, dynamic> json) => new Code(
    code: json["code"],
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "msg": msg,
  };
}