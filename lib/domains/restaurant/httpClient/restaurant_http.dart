import 'dart:async';
import 'package:restaurant_map/api/base_api.dart';
import 'package:restaurant_map/domains/location/model/location_model.dart';
import 'package:restaurant_map/domains/restaurant/model/restaurant_model.dart';

class RestaurantHttp {
  final _baseApi = new BaseApi();

  Future<List<Restaurant>> fetchRestaurants(
      Location location, String query, bool withCoordinate) async {
    final results = await _baseApi.request(path: 'search', parameters: {
      'entity_id': location.id.toString(),
      'entity_type': location.type,
      'lat': withCoordinate ? location.latitude.toString() : '',
      'lon': withCoordinate ? location.longtitude.toString() : '',
      'q': query,
      'count': '20'
    });

    final restaurants = results['restaurants']
        .map<Restaurant>((json) => Restaurant.fromJson(json['restaurant']))
        .toList(growable: false);

    return restaurants;
  }
}
