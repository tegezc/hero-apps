import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';

class Configuration {
  static final Configuration _configuration = Configuration._internal();

  factory Configuration() {
    return _configuration;
  }

  Configuration._internal();
  final bool _isProduction = true;
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
}

void ph(Object? o) {
  if (kDebugMode) {
    print(o);
  }
}

enum EResulusiVid {
  low,

  /// 480p (640x480 on iOS, 720x480 on Android and Web)
  medium,

  /// 720p (1280x720)
  high,

  /// 1080p (1920x1080)
  veryHigh,

  /// 2160p (3840x2160 on Android and iOS, 4096x2160 on Web)
  ultraHigh,

  /// The highest resolution available.
  max,
}
