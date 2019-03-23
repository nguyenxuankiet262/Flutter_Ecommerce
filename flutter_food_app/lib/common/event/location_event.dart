abstract class LocationEvent{}

class AddLocation extends LocationEvent{
  final List<String> nameCities;
  final List<List<String>> nameProvinces;
  AddLocation(this.nameCities, this.nameProvinces);
}
