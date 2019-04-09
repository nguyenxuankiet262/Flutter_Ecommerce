class LocationState {
  final List<String> nameCities;
  final List<List<String>> nameProvinces;
  final int indexCity;
  final int indexProvince;

  const LocationState(
      {this.nameCities,
      this.nameProvinces,
      this.indexCity,
      this.indexProvince});

  factory LocationState.initial() => LocationState(
        nameCities: [],
        nameProvinces: [],
        indexCity: 5,
        indexProvince: 0,
      );
}
