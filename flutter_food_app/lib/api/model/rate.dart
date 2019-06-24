class Rate {
  double rate;
  Rate({this.rate});

  factory Rate.fromJson(Map<String, dynamic> json) => new Rate(
    rate: json["rate"].toDouble(),
  );
}
