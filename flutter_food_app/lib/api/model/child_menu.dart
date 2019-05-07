class ChildMenu {
  final String id;
  final String idMenu;
  final String name;
  final String link;

  ChildMenu({this.id, this.idMenu, this.name,this.link});

  factory ChildMenu.fromJson(Map<String, dynamic> json) {
    return ChildMenu(
      id: json['_id'],
      idMenu: json['id_menu'],
      name: json['name'],
      link: json['link'],
    );
  }
}