import 'dart:convert';

Map<String, City> cityFromJson(String str) {
  final jsonData = json.decode(str);
  return new Map.from(jsonData).map((k, v) => new MapEntry<String, City>(k, City.fromJson(v)));
}

String cityToJson(Map<String, City> data) {
  final dyn = new Map.from(data).map((k, v) => new MapEntry<String, dynamic>(k, v.toJson()));
  return json.encode(dyn);
}

class City {
  String name;
  Map<String, String> districts;

  City({
    this.name,
    this.districts,
  });

  factory City.fromJson(Map<String, dynamic> json) => new City(
    name: json["name"],
    districts: new Map.from(json["districts"]).map((k, v) => new MapEntry<String, String>(k, v)),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "districts": new Map.from(districts).map((k, v) => new MapEntry<String, dynamic>(k, v)),
  };
}
