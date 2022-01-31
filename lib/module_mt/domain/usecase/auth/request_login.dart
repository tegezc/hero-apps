import 'package:hero/config/configuration_sf.dart';
import 'package:hero/module_mt/domain/entity/auth/account.dart';
import 'package:hero/module_mt/domain/repositories/auth/i_login_session_repository.dart';
import 'package:hero/module_mt/domain/repositories/auth/i_remote_login_repository.dart';

class RequestLoginAndProsesLogin {
  ILoginSessionRepository loginSession;
  IRemoteLoginRepository remoteLoginRepository;
  RequestLoginAndProsesLogin(
      {required this.loginSession, required this.remoteLoginRepository});

  Future<bool> requestAndProcessLogin(String id, String password) async {
    try {
      Account? account = await remoteLoginRepository.login(id, password);
      if (account == null) {
        return false;
      }
      await loginSession.setAccount(account);
      return true;
    } catch (e) {
      ph(e);
      return false;
    }
  }
}
