import 'package:hero/database/daolonglat.dart';
import 'package:hero/http/coverage/httpdashboard.dart';
import 'package:hero/model/enumapp.dart';
import 'package:hero/model/pjp.dart';
import 'package:hero/util/constapp/accountcontroller.dart';

import '../../../configuration.dart';

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
