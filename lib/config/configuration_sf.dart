import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';

class ConfigurationSf {
  // static final Configuration _configuration = Configuration._internal();
  //
  // factory Configuration() {
  //   return _configuration;
  // }
  //
  // Configuration._internal();
  final bool _isProduction = true;
  bool isSF = false;
  String host() {
    if (_isProduction) {
      return 'sihore.com';
    }
    return 'horedev.com';
  }

  String domain() => 'https://${host()}/apihore/index.php';

  Uri uri(String path) => Uri.https(host(), '/apihore/index.php$path');

  bool radiusClockin({required int? maxradius, required double? actualradius}) {
    if (maxradius == null || actualradius == null) {
      return false;
    }
    // if (_isProduction) {
    //   return actualradius <= maxradius;
    // }
    return true;
  }

  ResolutionPreset resulusiVid() {
    return ResolutionPreset.low;
  }

  ResolutionPreset resultPhoto() {
    return ResolutionPreset.medium;
  }

  // SF : 1.7.0
  // MT: 1.0.0
  String versionApp() {
    return '1.7.0';
  }
}

void ph(Object? o) {
  if (kDebugMode) {
    print(o);
  }
}
