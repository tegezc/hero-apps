//import 'package:geolocator/geolocator.dart';
import 'package:hero/core/domain/entities/tgzlocation.dart';
import 'package:location/location.dart';

import '../../../../config/configuration_sf.dart';

abstract class TgzLocationDataSource {
  Future<TgzLocationData?> getCurrentLocationOrNull();
}

class TgzLocationDataSourceImpl implements TgzLocationDataSource {
  final Location location = Location();
  @override
  Future<TgzLocationData?> getCurrentLocationOrNull() async {
    bool ispermisstion = await _setupPermissionlocation();
    if (ispermisstion) {
      ph('Permisi di setujui');
      try {
        LocationData _locationResult = await location.getLocation();
        if (_locationResult.longitude == null ||
            _locationResult.latitude == null) {
          return null;
        }
        return TgzLocationData(
            longitude: _locationResult.longitude!,
            latitude: _locationResult.latitude!);
      } catch (e) {
        return null;
      }
    }
    ph('Permisi tidak di setujui');
    return null;
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
          isAccepted = await _requestIjinLokasi();
        }
        break;
      case PermissionStatus.deniedForever:
        {
          ph('DENIED');
          isAccepted = await _requestIjinLokasi();
        }
        break;
    }

    return isAccepted;
  }

  Future<bool> _requestIjinLokasi() async {
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
