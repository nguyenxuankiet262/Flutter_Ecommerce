abstract class LocationEvent{}

class AddLocation extends LocationEvent{
  final List<String> nameCities;
  final List<List<String>> nameProvinces;
  AddLocation(this.nameCities, this.nameProvinces);
}

class ChangeLocation extends LocationEvent{
  final int indexCity;
  final int indexProvince;
  ChangeLocation(this.indexCity, this.indexProvince);
}

class ChangeTemp extends LocationEvent{
  final int tempCity;
  final int tempProvince;
  ChangeTemp(this.tempCity, this.tempProvince);
}