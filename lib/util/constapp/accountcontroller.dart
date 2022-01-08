import 'package:hero/model/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String keyJeniAccount = 'roleakun';
const String keyid = 'idprofile';
const String keyNamaSales = 'namasales';
const String keyidtap = 'idtap';
const String keyNmTap = 'namatap';
const String keyIdcluster = 'idcluster';
const String keyNmCluster = 'namacluster';
const String keyToken = 'token';
const String keylokasi = 'keylokasi';
const String keyCurrentIdHistoryPjp = 'idhistorypjp';

class AccountHore {
  static Future<EnumAccount> getAccount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? role = prefs.getString(keyJeniAccount);

    /// 0 = SF, 1=DS
    if (role == '5' || role == '6' || role == '8') {
      return EnumAccount.sf;
    } else if (role == '7') {
      return EnumAccount.ds;
    }
    return EnumAccount.sf;
  }

  static Future<String?> getIdHistoryPjp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? idhistorypjp = prefs.getString(keyCurrentIdHistoryPjp);
    return idhistorypjp;
  }

  static Future<bool> setIdHistoryPjp(String idhistorypjp) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(keyCurrentIdHistoryPjp, idhistorypjp);
    return true;
  }

  static Future<Profile> getProfile() async {
    // keyJeniAccount = 'roleakun';
    // keyid = 'idprofile';
    // keyNamaSales = 'namasales';
    // keyidtap = 'idtap';
    // keyNmTap = 'namatap';
    // keyIdcluster = 'idcluster';
    // keyNmCluster = 'namacluster';
    // keyToken = 'token';

    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? id = prefs.getString(keyid);
    String? role = prefs.getString(keyJeniAccount);
    String? namasales = prefs.getString(keyNamaSales);
    String? idtap = prefs.getString(keyidtap);
    String? nmtap = prefs.getString(keyNmTap);
    String? idcluster = prefs.getString(keyIdcluster);
    String? nmcluster = prefs.getString(keyNmCluster);
    String? token = prefs.getString(keyToken);

    Profile profile = Profile.lengkap(
        id: id,
        role: role,
        namaCluster: nmcluster,
        token: token,
        idcluster: idcluster,
        namaTap: nmtap,
        idtap: idtap,
        namaSales: namasales);

    return profile;
  }

  static Future<bool> setProfile(Profile profile) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(keyid, profile.id!);
    await prefs.setString(keyNamaSales, profile.namaSales!);
    await prefs.setString(keyidtap, profile.idtap!);
    await prefs.setString(keyNmTap, profile.namaTap!);
    await prefs.setString(keyIdcluster, profile.idcluster!);
    await prefs.setString(keyNmCluster, profile.namaCluster!);
    await prefs.setString(keyToken, profile.token!);
    await prefs.setString(keyJeniAccount, profile.role!);

    return true;
  }

  // id berupa tanggal exp: 1616047591756
  static Future<bool> setIdLocasi(String idtgl) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(keylokasi, idtgl);
    return true;
  }

  static Future<String?> getIdlokasi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? idlokasi = prefs.getString(keylokasi);
    return idlokasi;
  }
}

enum EnumAccount { sf, ds, cs, mt }
