class Country {
  int id;
  String countryName;

  Country(this.id, this.countryName);
  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      json['id'] ?? 0,
      json['country_name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id.toString(),
      'country_name': countryName,
    };
  }
}
