class LocationState {
  final List<String> nameCities;
  final List<List<String>> nameProvinces;
  final int indexCity;
  final int indexProvince;
  final int tempCity;
  final int tempProvince;

  const LocationState(
      {this.nameCities,
      this.nameProvinces,
      this.indexCity,
      this.indexProvince,
      this.tempCity,
      this.tempProvince});

  factory LocationState.initial() => LocationState(
        nameCities: [],
        nameProvinces: [],
        indexCity: 0,
        indexProvince: 0,
        tempCity: 0,
        tempProvince: 0,
      );
}
