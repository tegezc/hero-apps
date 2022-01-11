import 'package:flutter/cupertino.dart';

import '../../colorutil.dart';

class HoreBoxDecoration {
  Gradient gradientBackgroundApp() {
    return LinearGradient(
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
        colors: [HexColor('#cb2d3e'), HexColor("#ef473a")]);
  }
}
