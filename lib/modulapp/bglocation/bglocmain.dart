import 'dart:async';
import 'dart:isolate';
import 'dart:ui';

import 'package:background_locator/background_locator.dart';
import 'package:background_locator/location_dto.dart';
import 'package:background_locator/settings/android_settings.dart';
import 'package:background_locator/settings/ios_settings.dart';
import 'package:background_locator/settings/locator_settings.dart';
import 'package:flutter/material.dart';
import 'package:hero/core/log/printlog.dart';
import 'package:hero/http/coverage/httpdashboard.dart';
import 'package:hero/model/profile.dart';
import 'package:hero/core/domain/entities/tgzlocation.dart';
import 'package:hero/util/dateutil.dart';
import 'package:hero/core/data/datasources/location/tgz_location.dart';
import 'package:location_permissions/location_permissions.dart';
import '../../util/constapp/accountcontroller.dart';
import '../../util/filesystem/file_manager.dart';
import 'location_callback_handler.dart';
import 'location_service_repository.dart';

class BackgroundLocationUi extends StatefulWidget {
  const BackgroundLocationUi({Key? key}) : super(key: key);

  @override
  _BackgroundLocationUiState createState() => _BackgroundLocationUiState();
}

class _BackgroundLocationUiState extends State<BackgroundLocationUi> {
  ReceivePort port = ReceivePort();

  String logStr = '';
  bool? isRunning;

  @override
  void initState() {
    super.initState();

    if (IsolateNameServer.lookupPortByName(
            LocationServiceRepository.isolateName) !=
        null) {
      IsolateNameServer.removePortNameMapping(
          LocationServiceRepository.isolateName);
    }

    IsolateNameServer.registerPortWithName(
        port.sendPort, LocationServiceRepository.isolateName);

    port.listen(
      (dynamic data) async {
        await updateUI(data);
      },
    );
    initPlatformState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> updateUI(LocationDto? data) async {
    final log = await FileManager.readLogFile();

    logStr = log;
    _olahLog(log);
  }

  //exp:1616047601802=-6.6191326|106.8161784=isMocked: false
  // untul loc format lat|long
  void _olahLog(String log) async {
    ph('1');
    HttpDashboard httpDashboard = HttpDashboard();
    String? flagtimeint = await AccountHore.getIdlokasi();
    Profile? profile = await AccountHore.getProfile();
    //  ph('key: $flagtimeint');
    int? flagint = 0;
    if (flagtimeint != null) {
      flagint = int.tryParse(flagtimeint);
      flagint ??= 0;
    }
    List<String> ls = log.split('\n');
    for (int i = 0; i < ls.length; i++) {
      String line = ls[i];
      List<String> lineloc = line.split('=');
      if (lineloc.length == 3) {
        String tmp = lineloc[0];
        int? timeint = int.tryParse(tmp);

        if (timeint != null) {
          if (timeint > flagint!) {
            List<String> loc = lineloc[1].split('|');
            if (loc.length == 2) {
              double? long = double.tryParse(loc[0]);
              double? lat = double.tryParse(loc[1]);
              if (long != null && lat != null) {
                TgzLocationData tgzLocation =
                    TgzLocationData(latitude: lat, longitude: long);
                String dateString =
                    DateUtility.dateToYYYYMMDDHHMMSS(DateTime.now());
                bool value = await httpDashboard.trackingSales(
                    profile.id!, tgzLocation, dateString);
                ph(value);
              }
            }

            flagint = timeint;
            if (i == ls.length - 2) {
              await AccountHore.setIdLocasi('$flagint');
            }
          }
        }
      }
    }
  }

  Future<void> initPlatformState() async {
    ph('Initializing...');
    await BackgroundLocator.initialize();

    ph('Initialization done');
    final _isRunning = await BackgroundLocator.isServiceRunning();
    isRunning = _isRunning;

    if (_isRunning) {
      await _conditionRunning();
    } else {
      await _conditionNotRunning();
    }
  }

  Future<void> _conditionRunning() async {
    logStr = await FileManager.readLogFile();
    _olahLog(logStr);
  }

  Future<void> _conditionNotRunning() async {
    // start jika jam > 06:00 && jam < 18:00
    Profile? profile = await AccountHore.getProfile();
    DateTime dt = DateTime.now();
    DateTime dt6 = DateTime(dt.year, dt.month, dt.day, 6, dt.minute, dt.second);
    DateTime dt18 = DateTime(dt.year, dt.month, dt.day, 18, 0, 0);
    if (dt.isAfter(dt6) && dt.isBefore(dt18)) {
      TgzLocationData? locationData =
          await TgzLocationDataSourceImpl().getCurrentLocationOrNull();
      if (locationData != null) {
        String dateString = DateUtility.dateToYYYYMMDDHHMMSS(DateTime.now());
        HttpDashboard httpDashboard = HttpDashboard();
        await httpDashboard.trackingSales(
            profile.id!, locationData, dateString);
        _onStart();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ph('is running build: $isRunning');
    return Container();
  }

  void onStop() async {
    BackgroundLocator.unRegisterLocationUpdate();
    final _isRunning = await BackgroundLocator.isServiceRunning();

    setState(() {
      isRunning = _isRunning;
//      lastTimeLocation = null;
//      lastLocation = null;
    });
  }

  void _onStart() async {
    if (await _checkLocationPermission()) {
      _startLocator();
      final _isRunning = await BackgroundLocator.isServiceRunning();

      setState(() {
        isRunning = _isRunning;
      });
    } else {
      // show error
    }
  }

  Future<bool> _checkLocationPermission() async {
    final access = await LocationPermissions().checkPermissionStatus();
    switch (access) {
      case PermissionStatus.unknown:
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
        final permission = await LocationPermissions().requestPermissions(
          permissionLevel: LocationPermissionLevel.locationAlways,
        );
        if (permission == PermissionStatus.granted) {
          return true;
        } else {
          return false;
        }
      case PermissionStatus.granted:
        return true;
      default:
        return false;
    }
  }

  void _startLocator() {
    Map<String, dynamic> data = {'countInit': 1};
    BackgroundLocator.registerLocationUpdate(LocationCallbackHandler.callback,
        initCallback: LocationCallbackHandler.initCallback,
        initDataCallback: data,
/*
        Comment initDataCallback, so service not set init variable,
        variable stay with value of last run after unRegisterLocationUpdate
 */
        disposeCallback: LocationCallbackHandler.disposeCallback,
        iosSettings: const IOSSettings(
            accuracy: LocationAccuracy.NAVIGATION, distanceFilter: 5),
        autoStop: false,
        androidSettings: const AndroidSettings(
            accuracy: LocationAccuracy.BALANCED,
            interval: 10,
            distanceFilter: 10,
            wakeLockTime: 30,
            client: LocationClient.google,
            androidNotificationSettings: AndroidNotificationSettings(
                notificationChannelName: 'Location tracking',
                notificationTitle: 'Start Location Tracking',
                notificationMsg: 'Track location in background',
                notificationBigMsg: 'Uptodate location',
                notificationIcon: '',
                notificationIconColor: Colors.grey,
                notificationTapCallback:
                    LocationCallbackHandler.notificationCallback)));
  }
}
