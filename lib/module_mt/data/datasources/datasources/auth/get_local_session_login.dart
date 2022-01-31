import 'package:hero/module_mt/data/model/account_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class GetLocalSessionLogin {
  Future<bool> setAccount(AccountModel accountModel);
  AccountModel? getAccount();
}

const keyAccountMt = 'account_mt';

class GetLocalSessionLoginSharedPref implements GetLocalSessionLogin {
  SharedPreferences sharedPreferences;
  GetLocalSessionLoginSharedPref({required this.sharedPreferences});

  @override
  AccountModel? getAccount() {
    List<String>? lString = sharedPreferences.getStringList(keyAccountMt);
    if (lString == null) {
      return null;
    } else {
      if (lString.length == 5) {
        return AccountModel.fromListString(lString);
      }
      return null;
    }
  }

  @override
  Future<bool> setAccount(AccountModel accountModel) async {
    return await sharedPreferences.setStringList(
        keyAccountMt, accountModel.toListString());
  }
}
