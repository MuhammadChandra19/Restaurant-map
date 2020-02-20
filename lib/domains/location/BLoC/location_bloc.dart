import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:restaurant_map/BLoC/bloc.dart';
import 'package:restaurant_map/domains/location/httpClient/location_http.dart';
import 'package:restaurant_map/domains/location/model/location_model.dart';
import 'package:restaurant_map/util/geocode/geocode_util.dart';

class LocationBloc implements Bloc {
  Location _location;
  Location get selectedLocation => _location;

  final _client = LocationHttp();
  final _geolocation = GeolocationUtils();

  final _locationController = StreamController<Location>();

  Stream<Location> get locationStream {
    // selectLocationByGeoCode();
    return _locationController.stream;
  }

  Future<Location> get getAsyncLocation async {
    return selectLocationByGeoCode();
  }

  void selectLocation(Location location) {
    _location = location;
    _locationController.sink.add(location);
  }

  Future<Location> selectLocationByGeoCode() async {
    Position position = await _geolocation.getLatitudeAndLongtitude();
    final results = await _client.fetchLocationsByGeoCode(
        position.latitude, position.longitude);
    _locationController.sink.add(results);
    return results;
  }

  @override
  void dispose() {
    _locationController.close();
  }
}
