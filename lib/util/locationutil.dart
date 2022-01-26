import 'package:location/location.dart';

class LocationUtil {
  Future<LocationData> getCurrentLocation() async {
    Location location = Location();
    LocationData _locationResult = await location.getLocation();
    return _locationResult;
  }
}
