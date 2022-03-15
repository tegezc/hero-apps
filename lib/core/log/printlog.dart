import 'dart:developer';

import 'package:flutter/foundation.dart';

void ph(Object? o) {
  if (kDebugMode) {
    log('$o');
  }
}
