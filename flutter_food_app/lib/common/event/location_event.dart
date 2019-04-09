abstract class LocationEvent{}

class AddLocation extends LocationEvent{
  final List<String> nameCities;
  final List<List<String>> nameProvinces;
  AddLocation(this.nameCities, this.nameProvinces);
}

class ChangeLocation extends LocationEvent{
  final int indexCity;
  final int indeProvince;
  ChangeLocation(this.indexCity, this.indeProvince);
}
