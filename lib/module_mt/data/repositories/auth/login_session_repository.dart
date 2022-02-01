import 'package:hero/module_mt/data/datasources/auth/get_local_session_login.dart';
import 'package:hero/module_mt/data/model/auth/account_model.dart';
import 'package:hero/module_mt/domain/entity/auth/account.dart';
import 'package:hero/module_mt/domain/repositories/auth/i_login_session_repository.dart';

class LoginSessionRepositoryImpl implements ILoginSessionRepository {
  final GetLocalSessionLoginSharedPref getLocalSessionLoginSharedPref;
  LoginSessionRepositoryImpl({
    required this.getLocalSessionLoginSharedPref,
  });
  @override
  Account? getAccount() {
    return getLocalSessionLoginSharedPref.getAccount();
  }

  @override
  Future<bool> setAccount(Account account) async {
    AccountModel accountModel = AccountModel.fromAccount(account);
    return await getLocalSessionLoginSharedPref.setAccount(accountModel);
  }
}
