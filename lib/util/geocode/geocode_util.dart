import 'package:geolocator/geolocator.dart';

class GeolocationUtils {
  Future<Position> getLatitudeAndLongtitude() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    return position;
  }
}
