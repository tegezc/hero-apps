import 'package:hero/model/enumapp.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../configuration.dart';

const String keyPhotoDist = 'photo_dist';
const String keyPhotoMarketAudit = 'photo_ma';

class StoredPathPhoto {
  static Future<String?> getPhotoDist() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(keyPhotoDist);
  }

  static Future<bool> setPhotoDist(String path) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(keyPhotoDist, path);
    return true;
  }

  static Future<String?> getPhotoMarketAudit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(keyPhotoMarketAudit);
  }

  static Future<bool> setPhotoMarketAudit(String path) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(keyPhotoMarketAudit, path);
    return true;
  }

  static Future<String?> getPhotoMerchandising(
      EnumMerchandising enumMerchandising, EnumNumber? enumNumber) async {
    String key = _getKeyMerch(enumMerchandising, enumNumber);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  static Future<bool> setPhotoMerchandising(EnumMerchandising enumMerchandising,
      EnumNumber? enumNumber, String path) async {
    String key = _getKeyMerch(enumMerchandising, enumNumber);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, path);
    ph('key: $key | path: $path | number: $enumNumber');
    return true;
  }

  static String _getKeyMerch(
      EnumMerchandising enumMerchandising, EnumNumber? photoke) {
    String p = 'MER';
    switch (enumMerchandising) {
      case EnumMerchandising.perdana:
        p = '${p}perdana';
        break;
      case EnumMerchandising.spanduk:
        p = '${p}spanduk';
        break;
      case EnumMerchandising.poster:
        p = '${p}poster';
        break;
      case EnumMerchandising.papan:
        p = '${p}papan';
        break;
      case EnumMerchandising.StikerScanQR:
        p = '${p}backdrop';
        break;
      case EnumMerchandising.voucherfisik:
        p = '${p}voucherfisik';
        break;
    }

    switch (photoke) {
      case EnumNumber.satu:
        p = '${p}1';
        break;
      case EnumNumber.dua:
        p = '${p}2';
        break;
      case EnumNumber.tiga:
        p = '${p}3';
        break;
      default:
        p = '';
    }
    return p;
  }

  static Future<bool> deletePhotodist() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(keyPhotoDist);
    return true;
  }

  static Future<bool> deletePhotoMa() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(keyPhotoMarketAudit);
    return true;
  }

  static Future<bool> deleteMerchAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    EnumMerchandising.values.forEach((element) {
      String key = _getKeyMerch(element, EnumNumber.satu);
      prefs.remove(key);
      key = _getKeyMerch(element, EnumNumber.dua);
      prefs.remove(key);
      key = _getKeyMerch(element, EnumNumber.dua);
      prefs.remove(key);
    });

    return true;
  }
}

enum EnumNumber { satu, dua, tiga }
