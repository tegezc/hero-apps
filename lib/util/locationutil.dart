import 'package:location/location.dart';

import '../configuration.dart';

class LocationUtil {
  final Location location = Location();
  Future<LocationData> getCurrentLocation() async {
    // bool ispermisstion = await _setupPermissionlocation();
    // if (ispermisstion) {
    LocationData _locationResult = await location.getLocation();
    return _locationResult;
    // }
    // return null;
  }

  Future<bool> _setupPermissionlocation() async {
    final PermissionStatus permissionGrantedResult =
        await location.hasPermission();
    bool isAccepted;
    switch (permissionGrantedResult) {
      case PermissionStatus.granted:
        isAccepted = true;
        break;
      case PermissionStatus.grantedLimited:
        isAccepted = false;
        break;
      case PermissionStatus.denied:
        {
          isAccepted = await requestIjinLokasi();
        }
        break;
      case PermissionStatus.deniedForever:
        {
          ph('DENIED');
          isAccepted = await requestIjinLokasi();
        }
        break;
    }

    return isAccepted;
  }

  Future<bool> requestIjinLokasi() async {
    final PermissionStatus permissionRequestedResult =
        await location.requestPermission();
    switch (permissionRequestedResult) {
      case PermissionStatus.granted:
        return true;
      case PermissionStatus.grantedLimited:
        // nothing (only ios)
        break;
      case PermissionStatus.denied:
        break;
      case PermissionStatus.deniedForever:
        break;
    }
    return false;
  }
}
