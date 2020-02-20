import 'package:restaurant_map/domains/restaurant/model/rating_model.dart';

class Restaurant {
  final String id;
  final String name;
  final String url;
  final String cuisines;
  final String timings;
  final int avraegeCost;
  final int priceRange;
  final String currency;
  final String thumbUrl;
  final String imageUrl;
  final String address;
  final String city;
  final int cityId;
  final double latitude;
  final double longtitude;
  final int countryId;
  final String locality;
  final Rating rating;

  Restaurant.fromJson(Map json)
      : id = json['id'],
        name = json['name'],
        url = json['url'],
        cuisines = json['cuisines'],
        timings = json['timings'],
        avraegeCost = json['average_cost_for_two'],
        priceRange = json['price_range'],
        currency = json['currency'],
        thumbUrl = json['thumb'],
        imageUrl = json['featured_image'],
        address = json['location']['address'],
        city = json['location']['city'],
        cityId = json['location']['city_id'],
        latitude = double.parse(json['location']['latitude']),
        longtitude = double.parse(json['location']['longitude']),
        countryId = json['location']['country_id'],
        locality = json['location']['locality'],
        rating = Rating.fromJson(json['user_rating']);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Restaurant && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
