import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'config/configuration.dart';
import 'core/log/printlog.dart';
import 'modul_sales/sf_main.dart';
import 'module_mt/mt_main.dart';

Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();

    MainConfiguration configuration = MainConfiguration();
    if (!configuration.isSf()) {
      //await dimt.init();
      await Hive.initFlutter();
      await Hive.openBox<List<bool>>('mt');
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
