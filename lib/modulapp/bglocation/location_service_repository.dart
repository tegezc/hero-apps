import 'dart:async';
import 'dart:isolate';
import 'dart:ui';

import 'package:background_locator/location_dto.dart';
import 'package:hero/core/log/printlog.dart';

import '../../config/configuration_sf.dart';
import '../../util/filesystem/file_manager.dart';

class LocationServiceRepository {
  static LocationServiceRepository _instance = LocationServiceRepository._();

  LocationServiceRepository._();

  factory LocationServiceRepository() {
    return _instance;
  }

  static const String isolateName = 'LocatorIsolate';

  int _count = -1;

  Future<void> init(Map<dynamic, dynamic> params) async {
    ph("***********Init callback handler");
    if (params.containsKey('countInit')) {
      dynamic tmpCount = params['countInit'];
      if (tmpCount is double) {
        _count = tmpCount.toInt();
      } else if (tmpCount is String) {
        _count = int.parse(tmpCount);
      } else if (tmpCount is int) {
        _count = tmpCount;
      } else {
        _count = -2;
      }
    } else {
      _count = 0;
    }
    ph("$_count");
    await setLogLabel("start");
    final SendPort? send = IsolateNameServer.lookupPortByName(isolateName);
    send?.send(null);
  }

  Future<void> dispose() async {
    ph("***********Dispose callback handler");
    ph("$_count");
    await setLogLabel("end");
    final SendPort? send = IsolateNameServer.lookupPortByName(isolateName);
    send?.send(null);
  }

  Future<void> callback(LocationDto locationDto) async {
    ph('$_count location in dart: ${locationDto.toString()}');
    await setLogPosition(_count, locationDto);
    final SendPort? send = IsolateNameServer.lookupPortByName(isolateName);
    send?.send(locationDto);
    _count++;
  }

  static Future<void> setLogLabel(String label) async {
    final date = DateTime.now();
    await FileManager.writeToLogFile(
        '------------\n$label: ${formatDateLog(date)}\n------------\n');
  }

  static Future<void> setLogPosition(int count, LocationDto data) async {
    final date = DateTime.now();
    await FileManager.writeToLogFile(
        '${formatDateLog(date)}=${formatLog(data)}=isMocked: ${data.isMocked}\n');
  }

  // static double dp(double val, int places) {
  //   double mod = pow(10.0, places);
  //   return ((val * mod).round().toDouble() / mod);
  // }

  static String formatDateLog(DateTime date) {
    // return date.hour.toString() +
    //     ":" +
    //     date.minute.toString() +
    //     ":" +
    //     date.second.toString();
    return '${date.millisecondsSinceEpoch}';
  }

  static String formatLog(LocationDto locationDto) {
    // return dp(locationDto.latitude, 4).toString() +
    //     " " +
    //     dp(locationDto.longitude, 4).toString();
    return '${locationDto.latitude}|${locationDto.longitude}';
  }
}
