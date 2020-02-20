class Location {
  final int id;
  final String type;
  final String title;
  final double latitude;
  final double longtitude;
  final int cityId;
  final String cityName;
  final int countryId;
  final String countryName;

  Location.fromJson(Map json)
      : id = json['entity_id'],
        type = json['entity_type'],
        title = json['title'],
        latitude = json['latitude'] is String
            ? double.parse(json['latitude'])
            : json['latitude'],
        longtitude = json['longitude'] is String
            ? double.parse(json['longitude'])
            : json['longitude'],
        cityId = json['city_id'],
        cityName = json['city_name'],
        countryId = json['country_id'],
        countryName = json['country_name'];
}
