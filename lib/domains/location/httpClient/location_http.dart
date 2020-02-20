import 'package:restaurant_map/api/base_api.dart';
import 'package:restaurant_map/domains/location/model/location_model.dart';

class LocationHttp {
  final _baseApi = new BaseApi();

  Future<Location> fetchLocationsByGeoCode(double lat, double lon) async {
    final result = await _baseApi.request(
        path: 'geocode',
        parameters: {'lat': lat.toString(), 'lon': lon.toString()});
    print(result);
    print(lat);
    print(lon);
    return Location.fromJson(result['location']);
  }

  Future<List<Location>> fetchLocations(String query) async {
    final result = await _baseApi.request(
        path: 'locations', parameters: {'query': query, 'count': '10'});

    final suggestions = result['location_suggestions'];
    return suggestions
        .map<Location>((json) => Location.fromJson(json))
        .toList(growable: false);
  }
}
