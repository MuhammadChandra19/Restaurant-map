import 'dart:math';

class GeoLocation {
  double _radLat; // latitude in radians
  double _radLon; // longitude in radians

  double _degLat; // latitude in degrees
  double _degLon; // longitude in degrees

  static const double MIN_LAT = -90 * (pi / 180); // -PI/2
  static const double MAX_LAT = 90 * (pi / 180); //  PI/2
  static const double MIN_LON = -180 * (pi / 180); // -PI
  static const double MAX_LON = 180 * (pi / 180); //  PI

  GeoLocation();

  double toDegres(double value) => value * 180 / 3.14;

  static GeoLocation fromRadians(double latitude, double longitude) {
    GeoLocation result = new GeoLocation();
    result._radLat = latitude;
    result._radLon = longitude;
    result._degLat = latitude * (pi / 180);
    result._degLon = longitude * (pi / 180);
    result._checkBounds();
    return result;
  }

  void _checkBounds() {
    if (_radLat < MIN_LAT ||
        _radLat > MAX_LAT ||
        _radLon < MIN_LON ||
        _radLon > MAX_LON) throw new Error();
  }

  double getLatitudeInDegrees() {
    return _degLat;
  }

  double getLongitudeInDegrees() {
    return _degLon;
  }

  /**
	 * @return the latitude, in radians.
	 */
  double getLatitudeInRadians() {
    return _radLat;
  }

  /**
	 * @return the longitude, in radians.
	 */
  double getLongitudeInRadians() {
    return _radLon;
  }

  String toString() =>
      "(" +
      _degLat.toString() +
      "\u00B0, " +
      _degLon.toString() +
      "\u00B0) = (" +
      _radLat.toString() +
      " rad, " +
      _radLon.toString() +
      " rad)";

  /**
	 * Computes the great circle distance between this GeoLocation instance
	 * and the location argument.
	 * @param radius the radius of the sphere, e.g. the average radius for a
	 * spherical approximation of the figure of the Earth is approximately
	 * 6371.01 kilometers.
	 * @return the distance, measured in the same unit as the radius
	 * argument.
	 */

  double distanceTo(GeoLocation location, double radius) {
    return acos(sin(_radLat) * sin(location._radLat) +
            cos(_radLat) *
                cos(location._radLat) *
                cos(_radLon - location._radLon)) *
        radius;
  }

  List<GeoLocation> boundingCoordinates(double distance, double radius) {
    if (radius < 0 || distance < 0) throw new Error();

    // angular distance in radians on a great circle
    double radDist = distance / radius;

    double minLat = _radLat - radDist;
    double maxLat = _radLat + radDist;

    double minLon, maxLon;
    if (minLat > MIN_LAT && maxLat < MAX_LAT) {
      double deltaLon = asin(sin(radDist) / cos(_radLat));
      minLon = _radLon - deltaLon;
      if (minLon < MIN_LON) minLon += 2 * pi;
      maxLon = _radLon + deltaLon;
      if (maxLon > MAX_LON) maxLon -= 2 * pi;
    } else {
      // a pole is within the distance
      minLat = max(minLat, MIN_LAT);
      maxLat = min(maxLat, MAX_LAT);
      minLon = MIN_LON;
      maxLon = MAX_LON;
    }

    return [fromRadians(minLat, minLon), fromRadians(maxLat, maxLon)];
  }
}
