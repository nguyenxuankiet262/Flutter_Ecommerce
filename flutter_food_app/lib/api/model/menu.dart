class Menu {
  final String id;
  final String name;
  final String link;

  Menu({this.id, this.name,this.link});

  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      id: json['_id'],
      name: json['name'],
      link: json['link'],
    );
  }
}