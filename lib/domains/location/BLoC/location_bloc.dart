import 'dart:async';

// import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:restaurant_map/BLoC/bloc.dart';
import 'package:restaurant_map/domains/location/httpClient/location_http.dart';
import 'package:restaurant_map/domains/location/model/location_model.dart';
import 'package:restaurant_map/util/geocode/geocode_util.dart';

class LocationBloc implements Bloc {
  Location _location;

  bool _isSaveChangeLocation = false;
  Location get selectedLocation => _location;

  final _client = LocationHttp();
  final _geolocation = GeolocationUtils();

  final _locationController = StreamController<Location>();
  final _saveChangeLocationController = StreamController<bool>();

  Stream<Location> get locationStream {
    // selectLocationByGeoCode();
    return _locationController.stream;
  }

  bool get saveChangeLocation => _isSaveChangeLocation;

  void setSaveChangeLocation(bool isSave) {
    _isSaveChangeLocation = isSave;
    // _saveChangeLocationController.sink.add(isSave);
  }

  Future<Location> get getAsyncLocation async {
    return selectLocationByGeoCode();
  }

  void selectLocation(Location location) {
    _location = location;
    _locationController.sink.add(location);
  }

  Future<Location> selectLocationByGeoCode([LatLng argPosition]) async {
    LatLng position;
    if (argPosition == null) {
      position = await _geolocation.getLatitudeAndLongtitude();
    } else {
      position = argPosition;
    }

    final results = await _client.fetchLocationsByGeoCode(
        position.latitude, position.longitude);
    _locationController.sink.add(results);
    return results;
  }

  @override
  void dispose() {
    _locationController.close();
    _saveChangeLocationController.close();
  }
}
