import 'package:hero/model/enumapp.dart';

class Menu {
  EnumStatusTempat? enumStatusTempat;
  EnumBtnMenuState? isDistEnable;
  EnumBtnMenuState? isMerchEnable;
  EnumBtnMenuState? isPromEnable;
  EnumBtnMenuState? isMarketEnable;
  EnumBtnMenuState? isReportMtEnable;

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

  EnumBtnMenuState _olahtag(String? str) {
    if (str == null) {
      return EnumBtnMenuState.disable;
    }

    if (str == 'ENABLED' || str == 'START') {
      return EnumBtnMenuState.enable;
    } else if (str == "DISABLED") {
      return EnumBtnMenuState.disable;
    } else if (str == "FINISH") {
      return EnumBtnMenuState.complete;
    }
    return EnumBtnMenuState.disable;
    // return str == 'ENABLED' || str == 'START';
    // return true; // for development, enable all
  }

  bool isSfComplete() {
    if (isDistEnable == EnumBtnMenuState.complete &&
        isMerchEnable == EnumBtnMenuState.complete &&
        isPromEnable == EnumBtnMenuState.complete &&
        isMarketEnable == EnumBtnMenuState.complete) {
      return true;
    }
    return false;
  }

  bool isDsComplete() {
    if (isDistEnable == EnumBtnMenuState.complete &&
        isMerchEnable == EnumBtnMenuState.complete &&
        isPromEnable == EnumBtnMenuState.complete &&
        isMarketEnable == EnumBtnMenuState.complete) {
      return true;
    }
    return false;
  }

  bool isPoiComplete() {
    if (isDistEnable == EnumBtnMenuState.complete &&
        isPromEnable == EnumBtnMenuState.complete) {
      return true;
    }
    return false;
  }
}
