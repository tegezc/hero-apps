import 'package:hero/util/dateutil.dart';
import 'package:hive_flutter/adapters.dart';

const keyhive = 'mt';

class HiveMT {
  //['penilaiansf','availability','visibility','advokat','vor']
  static const availability = 0;
  static const visibility = 1;
  static const advokat = 2;
  static const vor = 3;

  late Box<List<bool>> boxMt;
  late String keyBox;

  HiveMT.tandem(String idOutlet, String idSales) {
    boxMt = Hive.box(keyhive);
    keyBox = _createKey('$idSales-$idOutlet');
  }

  HiveMT.backchecking(String idOutlet) {
    boxMt = Hive.box(keyhive);
    keyBox = _createKey('B-$idOutlet');
  }

  HiveMT.penilaiansf(String idSales) {
    boxMt = Hive.box(keyhive);
    keyBox = _createKey(idSales);
  }

  String _createKey(String criteria) {
    return '$criteria-${DateUtility.dateToStringYYYYMMDD(DateTime.now())}';
  }

  void setPenilaianSf() {
    boxMt.put(keyBox, [true]);
  }

  void setAvailability() {
    _setValue(availability);
  }

  void setVisibility() {
    _setValue(visibility);
  }

  void setAdvokat() {
    _setValue(advokat);
  }

  void setVOR() {
    _setValue(vor);
  }

  bool getPenilaianSf() {
    return _getValue(0);
  }

  bool getAvailability() {
    return _getValue(availability);
  }

  bool getVisibility() {
    return _getValue(visibility);
  }

  bool getAdvokat() {
    return _getValue(advokat);
  }

  bool getVOR() {
    return _getValue(vor);
  }

  bool _getValue(int index) {
    List<bool>? lb = _getExistingBoxOrNull();
    if (lb == null) {
      return false;
    }
    return lb[index];
  }

  void _setValue(int index) {
    List<bool>? lb = _getExistingBoxOrNull();
    if (lb == null) {
      lb = _setupEmptyList();
      lb[index] = true;
      boxMt.put(keyBox, lb);
    } else {
      lb[index] = true;
      boxMt.put(keyBox, lb);
    }
  }

  List<bool>? _getExistingBoxOrNull() {
    return boxMt.get(keyBox);
  }

  List<bool> _setupEmptyList() {
    return [false, false, false, false, false];
  }
}
