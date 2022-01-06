import 'accountcontroller.dart';

class ConstString {
  static String textCoverage = 'Coverage';
  static String textDistribusi = 'Distribusi';
  static String textMerchandising = 'Merchandising';
  static String textSurvey = 'Market Audit';
  static String textPromotion = 'Promotion';
  static String hintSearch = 'Search by id, nama, rs . . .';
  static String hintSearchDs = 'nama . . .';
  static String failedValidasi =
      'Field yang bertanda bintang (*) Wajib di isi. dan mungkin perlu '
      'diperiksa field alamat minimal 10 karakter.';

  static String titleSearchLocation(EnumAccount? enumAccount) {
    return enumAccount == EnumAccount.sf ? 'Cari Outlet' : 'Cari Lokasi';
  }

  static String titleTambahLocation(EnumAccount? enumAccount) {
    return enumAccount == EnumAccount.sf ? 'Tambah Outlet' : 'Tambah Lokasi';
  }

  static String titleLocationOpen(EnumAccount enumAccount) {
    return enumAccount == EnumAccount.sf ? 'Outlet Open' : 'Lokasi Open';
  }
  //
  // static String titleHistoryPjp(EnumAccount enumAccount) {
  //   return enumAccount == EnumAccount.sf
  //       ? 'Daftar PJP Outlet Ponsel A'
  //       : 'Daftar PJP Mall A';
  // }
}
