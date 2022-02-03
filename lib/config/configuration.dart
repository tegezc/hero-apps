import 'package:camera/camera.dart';
import 'package:hero/config/config_mt.dart';
import 'package:hero/config/configuration_sf.dart';

class MainConfiguration {
  final ConfigurationMT confMT = ConfigurationMT();
  final ConfigurationSf confSF = ConfigurationSf();

  bool isSf() => false;

  ResolutionPreset vidResolution() {
    if (isSf()) {
      return confSF.resulusiVid();
    }
    return confMT.vidResolution();
  }

  ResolutionPreset photoResolution() {
    if (isSf()) {
      return confSF.resultPhoto();
    }
    return confMT.photoResolution();
  }
}
