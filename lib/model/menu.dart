import 'package:hero/model/enumapp.dart';

class Menu {
  EnumStatusTempat? enumStatusTempat;
  bool? isDistEnable;
  bool? isMerchEnable;
  bool? isPromEnable;
  bool? isMarketEnable;
  bool? isReportMtEnable;

  // "status": "OPEN",
  // "clockin_distribusi": "ENABLED",
  // "clockin_merchandising": "DISABLED",
  // "clockin_promotion": "ENABLED",
  // "clockin_marketaudit": "ENABLED",
  // "clockin_report_mt": "ENABLED"

  Menu.fromJson(Map<String, dynamic> map) {
    isDistEnable = this._olahtag(map['clockin_distribusi']);
    isMerchEnable = this._olahtag(map['clockin_merchandising']);
    isPromEnable = this._olahtag(map['clockin_promotion']);
    isMarketEnable = this._olahtag(map['clockin_marketaudit']);
    isReportMtEnable = this._olahtag(map['clockin_report_mt']);

    if (map['status'] != null) {
      if (map['status'] == 'OPEN') {
        enumStatusTempat = EnumStatusTempat.open;
      } else if (map['status'] == 'CLOSE') {
        enumStatusTempat = EnumStatusTempat.close;
      }
    }
  }

  bool? _olahtag(String? str) {
    if (str == null) {
      return null;
    }
    return str == 'ENABLED' || str == 'START';
    // return true; // for development, enable all
  }
}
