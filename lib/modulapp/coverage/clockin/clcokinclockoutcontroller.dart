import 'package:hero/core/data/datasources/database/daoserial.dart';
import 'package:hero/core/log/printlog.dart';
import 'package:hero/http/coverage/httpdashboard.dart';
import 'package:hero/model/enumapp.dart';
import 'package:hero/model/pjp.dart';
import 'package:hero/util/constapp/accountcontroller.dart';

import '../../../config/configuration_sf.dart';

class ClockInClockOutController {
  Future<bool> clockin(EnumStatusTempat enumStatusTempat, Pjp pjp) async {
    HttpDashboard httpdashboard = HttpDashboard();
    String? idhistorypjp = await httpdashboard.clockin(pjp, enumStatusTempat);
    ph(idhistorypjp);
    if (idhistorypjp != null) {
      await AccountHore.setIdHistoryPjp(idhistorypjp);
      _deleteAllSerial();
      return true;
    }

    return false;
  }

  Future<bool> clockOut() async {
    HttpDashboard httpDashboard = HttpDashboard();
    bool result = await httpDashboard.clockout();
    return result;
  }

  Future<void> _deleteAllSerial() async {
    DaoSerial daoSerial = DaoSerial();
    int res = await daoSerial.deleteAllSerial();
    if (res > 0) {}
  }
}
