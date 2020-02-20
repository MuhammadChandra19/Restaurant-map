import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:restaurant_map/domains/location/model/location_model.dart';
// import 'package:restaurant_map/util/utilityFunctions/debouncer.dart';

class GeolocationUtils {
  Future<LatLng> getLatitudeAndLongtitude() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    return LatLng(position.latitude, position.longitude);
  }

  LatLng updateCenterLocation(CameraPosition position) {
    return position.target;
  }
}
