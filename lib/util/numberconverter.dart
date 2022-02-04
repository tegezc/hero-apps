import 'package:intl/intl.dart';

class ConverterNumber {
  static double? stringToDouble(String? str) {
    if (str != null) {
      double? tmp = double.tryParse(str) ?? 0.0;
      return tmp;
    }
    return 0.0;
  }

  static int? stringToIntOrZero(String? str) {
    if (str != null) {
      List<String> ls = str.split('.');
      String svalue = str;
      if (ls.isNotEmpty) {
        svalue = ls[0];
      }
      int? tmp = int.tryParse(svalue) ?? 0;
      return tmp;
    }
    return 0;
  }

  static int? stringToIntOrNull(String? str) {
    if (str != null) {
      List<String> ls = str.split('.');
      String svalue = str;
      if (ls.isNotEmpty) {
        svalue = ls[0];
      }
      int? tmp = int.tryParse(svalue);
      return tmp;
    }
    return null;
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
