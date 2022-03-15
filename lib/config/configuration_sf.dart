import 'package:camera/camera.dart';

class ConfigurationSf {
  // static final Configuration _configuration = Configuration._internal();
  //
  // factory Configuration() {
  //   return _configuration;
  // }
  //
  // Configuration._internal();
  final bool _isProduction = true;
  String host() {
    return 'sihore.com';
  }

  String domain() => 'https://${host()}/apihore/index.php';

  Uri uri(String path) => Uri.https(host(), '/apihore/index.php$path');

  bool radiusClockin({required int? maxradius, required double? actualradius}) {
    if (maxradius == null || actualradius == null) {
      return false;
    }
    if (_isProduction) {
      return actualradius <= maxradius;
    }
    return true;
  }

  ResolutionPreset resulusiVid() {
    return ResolutionPreset.low;
  }

  ResolutionPreset resultPhoto() {
    return ResolutionPreset.medium;
  }

  // SF : 1.8.0
  // MT: 1.0.0
  String versionApp() {
    return '1.9.0';
  }
}
