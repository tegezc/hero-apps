import 'package:hero/util/dateutil.dart';
import 'package:hero/util/numberconverter.dart';

class Retur {
  static const String approved = 'APPROVED';
  static const String waiting = 'WAITING APPROVAL';
  static const String rejected = 'REJECTED';
  static const String showmore = 'SHOWMORE';

  // "serial_number": "9000011113",
  // "tgl_retur": "2020-12-08",
  // "tgl_approval": "0000-00-00",
  // "status": "WAITING APPROVAL"

  String? serial;
  DateTime? tglretur;
  DateTime? tglApproval;
  String? status;

  Retur.showMore() {
    serial = null;
    tglretur = null;
    tglApproval = null;
    status = showmore;
  }
  Retur.fromJson(Map<String, dynamic> map) {
    serial = map['serial_number'] ?? '';

    tglretur = DateUtility.stringToDateTime(map['tgl_retur']);
    tglApproval = DateUtility.stringToDateTime(map['tgl_approval']);

    status = map['status'] ?? '';
  }

  String getStrRetur() {
    if (tglretur == null) {
      return '-';
    }
    return DateUtility.dateToStringDdMmYyyy(tglretur);
  }

  String getStrApproval() {
    if (tglApproval == null) {
      return '-';
    }
    return DateUtility.dateToStringDdMmYyyy(tglApproval);
  }

  // Map toJson() {
  //   return {
  //     tagidkel: idkel,
  //     tagiduniv: iduniv,
  //     tagidfakultas: idfak,
  //     tagnama: nama,
  //
  //   };
  // }

  EnumStatusRetur getStatus() {
    if (status == approved) {
      return EnumStatusRetur.approved;
    } else if (status == waiting) {
      return EnumStatusRetur.waiting;
    } else {
      return EnumStatusRetur.rejected;
    }
  }
}

enum EnumStatusRetur { approved, waiting, rejected }

class AlasanRetur {
  int? id;
  String? text;

  // "id_alasan": "2",
  // "nama_alasan": "Penumpukan Stok"

  AlasanRetur.fromJson(Map<String, dynamic> map) {
    id = ConverterNumber.stringToIntOrZero(map['id_alasan']);
    text = map['nama_alasan'] ?? '';
  }
  bool isvalid() {
    if (id! > 0 && text != null) {
      return true;
    }
    return false;
  }
}
