import 'package:hero/module_mt/domain/entity/auth/account.dart';
import 'package:hero/module_mt/domain/repositories/auth/i_login_session_repository.dart';

class CekSessionLogin {
  ILoginSessionRepository loginSession;
  CekSessionLogin({required this.loginSession});
  bool isLoggedIn() {
    Account? account = loginSession.getAccount();
    if (account == null) {
      return false;
    } else {
      return true;
    }
  }
}
