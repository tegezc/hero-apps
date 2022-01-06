class DateUtility {
  /*
  * ex: 21-Mar-2019
  * */
  static String dateToStringDdMmYyyy(DateTime? dateTime) {
    if (dateTime == null) {
      return '-';
    }
    String tanggal =
        '${dateTime.day < 10 ? '0' : ''}${dateTime.day}-${namaBulanPendek[dateTime.month]}-${dateTime.year}';
    return tanggal;
  }

  /*
  * ex: 2020-11-23
  * */
  static String dateToStringYYYYMMDD(DateTime? dateTime) {
    if (dateTime == null) {
      return '';
    }
    String tanggal =
        '${dateTime.year}-${dateTime.month}-${dateTime.day < 10 ? '0' : ''}${dateTime.day}';
    return tanggal;
  }

  /*
  * ex: 09:12:13
  * */
  static String dateToStringjam(DateTime? dateTime) {
    if (dateTime == null) {
      return '';
    }
    String jam = '${dateTime.hour}:${dateTime.minute}:${dateTime.second}';
    return jam;
  }

  /*
  * ex: 20201123
  * */
  static String dateToStringParam(DateTime? dateTime) {
    if (dateTime == null) {
      return '';
    }
    String bulan =
        dateTime.month < 10 ? '0${dateTime.month}' : '${dateTime.month}';
    String tanggal =
        '${dateTime.year}$bulan${dateTime.day < 10 ? '0' : ''}${dateTime.day}';
    return tanggal;
  }

  /*
  * ex: 2020-03-23
  * */
  static DateTime? stringToDateTime(String? str) {
    if (str == null) {
      return null;
    }

    List<String> ls = str.split('-');
    if (ls.length == 3) {
      try {
        int tahun = int.parse(ls[0]);
        int bulan = int.parse(ls[1]);
        int tanggal = int.parse(ls[2]);
        return DateTime(tahun, bulan, tanggal);
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /*
  * ex: 2020-11-24 09:07:44
  * */
  static DateTime? stringLongToDateTime(String? str) {
    if (str == null) {
      return null;
    }
    String strl;
    if (str.length > 11) {
      List<String> lstrl = str.split(' ');
      strl = lstrl[0];
      List<String> ls = strl.split('-');
      if (ls.length == 3) {
        try {
          int tahun = int.parse(ls[0]);
          int bulan = int.parse(ls[1]);
          int tanggal = int.parse(ls[2]);
          lstrl = str.split(' ');
          strl = lstrl[1];
          ls = strl.split(':');
          if (ls.length == 3) {
            int jam = int.parse(ls[0]);
            int menit = int.parse(ls[1]);
            int detik = int.parse(ls[2]);
            return DateTime(tahun, bulan, tanggal, jam, menit, detik);
          }
        } catch (e) {
          return null;
        }
      }
    } else {
      return null;
    }

    return null;
  }

  /*
  * ex: 09:07:44
  * */
  static DateTime? stringToJam(String? str, DateTime dt) {
    if (str == null) {
      return null;
    }

    List<String> ls = str.split(':');
    if (ls.length == 3) {
      try {
        int jam = int.parse(ls[0]);
        int menit = int.parse(ls[1]);
        int detik = int.parse(ls[2]);
        if (jam == 0 && menit == 0 && detik == 0) {
          return null;
        }
        return DateTime(dt.year, dt.month, dt.hour, jam, menit, detik);
      } catch (e) {
        return null;
      }
    }

    return null;
  }

  /*
  * ex: Kamis, 10-12-2020
  * */
  static String dateToStringPanjang(DateTime? dt) {
    if (dt == null) {
      return '';
    }
    String day = "";
    if (dt.day > 9) {
      day = "${dt.day}";
    } else {
      day = "0${dt.day}";
    }

    String month = "";
    if (dt.month > 9) {
      month = "${dt.month}";
    } else {
      month = "0${dt.month}";
    }

    return '${namaHariPanjang[dt.weekday]}, $day-$month-${dt.year}';
  }

  /*
  * ex: Kamis, 10-12-2020 09:00:00
  * */
  static String dateToStringLengkap(DateTime? dt) {
    if (dt == null) {
      return '';
    }
    String day = correntFormatToTwoDigit(dt.day);
    String month = correntFormatToTwoDigit(dt.month);
    String jam = correntFormatToTwoDigit(dt.hour);

    String menit = correntFormatToTwoDigit(dt.minute);
    String second = correntFormatToTwoDigit(dt.second);

    return '${namaHariPanjang[dt.weekday]}, $day-$month-${dt.year} $jam:'
        '$menit:$second';
  }

  static String correntFormatToTwoDigit(int satuOrDuadigit) {
    String duadigitstring;
    if (satuOrDuadigit < 10) {
      duadigitstring = '0$satuOrDuadigit';
    } else {
      duadigitstring = '$satuOrDuadigit';
    }
    return duadigitstring;
  }

  static const namaBulanPendek = [
    '',
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'Mei',
    'Jun',
    'Jul',
    'Ags',
    'Sept',
    'Okt',
    'Nov',
    'Des'
  ];

  static const namaHariPanjang = [
    '',
    'Senin',
    'Selasa',
    'Rabu',
    'Kamis',
    'Jum\'at',
    'Sabtu',
    'Minggu'
  ];
}
