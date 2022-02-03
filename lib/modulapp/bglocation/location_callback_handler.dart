import 'dart:async';

import 'package:background_locator/location_dto.dart';
import 'package:hero/core/log/printlog.dart';

import '../../config/configuration_sf.dart';
import 'location_service_repository.dart';

class LocationCallbackHandler {
  static Future<void> initCallback(Map<dynamic, dynamic> params) async {
    LocationServiceRepository myLocationCallbackRepository =
        LocationServiceRepository();
    await myLocationCallbackRepository.init(params);
  }

  static Future<void> disposeCallback() async {
    LocationServiceRepository myLocationCallbackRepository =
        LocationServiceRepository();
    await myLocationCallbackRepository.dispose();
  }

  static Future<void> callback(LocationDto locationDto) async {
    LocationServiceRepository myLocationCallbackRepository =
        LocationServiceRepository();
    await myLocationCallbackRepository.callback(locationDto);
  }

  static Future<void> notificationCallback() async {
    ph('***notificationCallback');
  }
}
