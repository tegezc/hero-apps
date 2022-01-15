import 'package:intl/intl.dart';

class ConverterNumber {
  static double? stringToDouble(String? str) {
    if (str != null) {
      double? tmp = double.tryParse(str) == null ? 0.0 : double.tryParse(str);
      return tmp;
    }
    return 0.0;
  }

  static int? stringToInt(String? str) {
    if (str != null) {
      List<String> ls = str.split('.');
      String svalue = str;
      if (ls.length > 0) {
        svalue = ls[0];
      }
      int? tmp = int.tryParse(svalue) == null ? 0 : int.tryParse(svalue);
      return tmp;
    }
    return 0;
  }

  static String getCurrentcy(int? value) {
    int d = 0;
    if (value != null) {
      d = value;
    }

    final currencyFormatter = NumberFormat("#,##0", "id");
    return currencyFormatter.format(d); // IDR100.286.020.524,17
  }

  static String getCurrentcyOrNol(String? value) {
    int d = 0;
    if (value != null) {
      int? makeint = int.tryParse(value);
      if (makeint != null) {
        d = makeint;
      }
    }

    final currencyFormatter = NumberFormat("#,##0", "id");
    return currencyFormatter.format(d); // IDR100.286.020.524,17
  }
}
