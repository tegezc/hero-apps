import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'config/configuration.dart';
import 'config/configuration_sf.dart';
import 'core/log/printlog.dart';
import 'modul_sales/sf_main.dart';
import 'module_mt/mt_main.dart';

Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();

    MainConfiguration configuration = MainConfiguration();
    if (!configuration.isSf()) {
      //await dimt.init();
    }
  } on CameraException catch (e) {
    ph(e.code);
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    MainConfiguration configuration = MainConfiguration();
    if (configuration.isSf()) {
      return SFRootApp();
    } else {
      return MTRootApp();
    }
  }
}
