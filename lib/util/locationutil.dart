import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';

class LocationUtil {
  static Future<LocationData> getCurrentLocation() async {
    Location location = Location();
    LocationData _locationResult = await location.getLocation();
    return _locationResult;
  }
}
