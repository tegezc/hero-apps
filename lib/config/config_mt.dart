import 'package:camera/camera.dart';

class ConfigurationMT {
  final bool _isProduction = false;
  bool isSF = false;
  String host() {
    if (_isProduction) {
      return 'sihore.com';
    }
    return 'https://simplifytechno.com/apimt/index.php';
  }

  ResolutionPreset vidResolution() {
    return ResolutionPreset.low;
  }

  ResolutionPreset photoResolution() {
    return ResolutionPreset.medium;
  }

  String versionApp() {
    return '1.0.0';
  }
}
