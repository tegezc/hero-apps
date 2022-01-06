import 'dart:async';
import 'dart:isolate';
import 'dart:ui';

import 'package:background_locator/background_locator.dart';
import 'package:background_locator/location_dto.dart';
import 'package:background_locator/settings/android_settings.dart';
import 'package:background_locator/settings/ios_settings.dart';
import 'package:background_locator/settings/locator_settings.dart';
import 'package:flutter/material.dart';
import 'package:hero/http/coverage/httpdashboard.dart';
import 'package:hero/model/profile.dart';
import 'package:hero/model/tgzlocation.dart';
import 'package:hero/util/locationutil.dart';
import 'package:location/location.dart' as loc;
import 'package:location_permissions/location_permissions.dart';

import '../../util/constapp/accountcontroller.dart';
import 'file_manager.dart';
import 'location_callback_handler.dart';
import 'location_service_repository.dart';

class BackgroundLocationUi extends StatefulWidget {
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
    print('1');
    HttpDashboard httpDashboard = HttpDashboard();
    String? flagtimeint = await AccountHore.getIdlokasi();
    Profile? profile = await AccountHore.getProfile();
    //  print('key: $flagtimeint');
    int? flagint = 0;
    if (flagtimeint != null) {
      flagint = int.tryParse(flagtimeint);
      if (flagint == null) {
        flagint = 0;
      }
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
              //        print('send loc $tmp');
              TgzLocation tgzLocation =
                  TgzLocation(latitute: loc[0], longitute: loc[1]);
              bool value =
                  await httpDashboard.trackingSales(profile.id!, tgzLocation);
              //        print(value);
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
    print('Initializing...');
    await BackgroundLocator.initialize();

    print('Initialization done');
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
    // start jika jam > 06:00
    Profile? profile = await AccountHore.getProfile();
    DateTime dt = DateTime.now();
    DateTime dt6 = DateTime(dt.year, dt.month, dt.day, 6, dt.minute, dt.second);
    DateTime dt18 = DateTime(dt.year, dt.month, dt.day, 18, 0, 0);
    if (dt.isAfter(dt6) && dt.isBefore(dt18)) {
      loc.LocationData locationData = await LocationUtil.getCurrentLocation();
      TgzLocation tgzLocation = TgzLocation(
          latitute: '${locationData.latitude}',
          longitute: '${locationData.longitude}');
      HttpDashboard httpDashboard = HttpDashboard();
      await httpDashboard.trackingSales(profile.id!, tgzLocation);
      _onStart();
    }
  }

  @override
  Widget build(BuildContext context) {
    print('is running build: $isRunning');
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
        iosSettings: IOSSettings(
            accuracy: LocationAccuracy.NAVIGATION, distanceFilter: 0),
        autoStop: false,
        androidSettings: AndroidSettings(
            accuracy: LocationAccuracy.NAVIGATION,
            interval: 10,
            distanceFilter: 0,
            wakeLockTime: 10,
            client: LocationClient.google,
            androidNotificationSettings: AndroidNotificationSettings(
                notificationChannelName: 'Location tracking',
                notificationTitle: 'Start Location Tracking',
                notificationMsg: 'Track location in background',
                notificationBigMsg:
                    'Background location is on to keep the app up-tp-date with your location. This is required for main features to work properly when the app is not running.',
                notificationIcon: '',
                notificationIconColor: Colors.grey,
                notificationTapCallback:
                    LocationCallbackHandler.notificationCallback)));
  }
}

class BackgroundLocationUi1 extends StatefulWidget {
  @override
  _BackgroundLocationUi1State createState() => _BackgroundLocationUi1State();
}

class _BackgroundLocationUi1State extends State<BackgroundLocationUi1> {
  ReceivePort port = ReceivePort();

  String logStr = '';
  bool? isRunning;
  LocationDto? lastLocation;
  DateTime? lastTimeLocation;

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

    await _updateNotificationText(data);

    setState(() {
      if (data != null) {
        lastLocation = data;
        lastTimeLocation = DateTime.now();
      }
      logStr = log;
    });
  }

  Future<void> _updateNotificationText(LocationDto? data) async {
    if (data == null) {
      return;
    }

    await BackgroundLocator.updateNotificationText(
        title: "new location received",
        msg: "${DateTime.now()}",
        bigMsg: "${data.latitude}, ${data.longitude}");
  }

  Future<void> initPlatformState() async {
    print('Initializing...');
    await BackgroundLocator.initialize();
    logStr = await FileManager.readLogFile();
    print('Initialization done');
    final _isRunning = await BackgroundLocator.isServiceRunning();
    setState(() {
      isRunning = _isRunning;
    });
    print('Running ${isRunning.toString()}');
  }

  @override
  Widget build(BuildContext context) {
    final start = SizedBox(
      width: double.maxFinite,
      child: ElevatedButton(
        child: Text('Start'),
        onPressed: () {
          _onStart();
        },
      ),
    );
    final stop = SizedBox(
      width: double.maxFinite,
      child: ElevatedButton(
        child: Text('Stop'),
        onPressed: () {
          onStop();
        },
      ),
    );
    final clear = SizedBox(
      width: double.maxFinite,
      child: ElevatedButton(
        child: Text('Clear Log'),
        onPressed: () {
          FileManager.clearLogFile();
          setState(() {
            logStr = '';
          });
        },
      ),
    );
    String msgStatus = "-";
    if (isRunning != null) {
      if (isRunning!) {
        msgStatus = 'Is running';
      } else {
        msgStatus = 'Is not running';
      }
    }
    final status = Text("Status: $msgStatus");

    String lastRunTxt = "-";
    if (isRunning != null) {
      if (isRunning!) {
        if (lastTimeLocation == null || lastLocation == null) {
          lastRunTxt = "?";
        } else {
          lastRunTxt =
              LocationServiceRepository.formatDateLog(lastTimeLocation!) +
                  "-" +
                  LocationServiceRepository.formatLog(lastLocation!);
        }
      }
    }
    final lastRun = Text(
      "Last run: $lastRunTxt",
    );

    final log = Text(
      logStr,
    );

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter background Locator'),
        ),
        body: Container(
          width: double.maxFinite,
          padding: const EdgeInsets.all(22),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[start, stop, clear, status, lastRun, log],
            ),
          ),
        ),
      ),
    );
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
        lastTimeLocation = null;
        lastLocation = null;
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
        iosSettings: IOSSettings(
            accuracy: LocationAccuracy.NAVIGATION, distanceFilter: 0),
        autoStop: false,
        androidSettings: AndroidSettings(
            accuracy: LocationAccuracy.NAVIGATION,
            interval: 5,
            distanceFilter: 0,
            client: LocationClient.google,
            androidNotificationSettings: AndroidNotificationSettings(
                notificationChannelName: 'Location tracking',
                notificationTitle: 'Start Location Tracking',
                notificationMsg: 'Track location in background',
                notificationBigMsg:
                    'Background location is on to keep the app up-tp-date with your location. This is required for main features to work properly when the app is not running.',
                notificationIcon: '',
                notificationIconColor: Colors.grey,
                notificationTapCallback:
                    LocationCallbackHandler.notificationCallback)));
  }
}
