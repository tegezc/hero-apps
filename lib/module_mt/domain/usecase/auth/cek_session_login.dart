import 'package:hero/module_mt/domain/entity/auth/account.dart';
import 'package:hero/module_mt/domain/entity/common/cluster.dart';
import 'package:hero/module_mt/domain/repositories/auth/i_login_session_repository.dart';
import 'package:hero/module_mt/domain/repositories/common/i_combo_box_repository.dart';

class CekSessionLogin {
  ILoginSessionRepository loginSession;
  CekSessionLogin(
      {required this.loginSession, required this.comboboxRepository});
  IComboboxRepository comboboxRepository;

  bool isLoggedIn() {
    Account? account = loginSession.getAccount();
    if (account == null) {
      return false;
    } else {
      return true;
    }
  }

  Future<bool> getListCluster() async {
    try {
      List<Cluster>? lCluster = await comboboxRepository.getComoboboxCluster();
      if (lCluster == null) {
        return false;
      }

      if (lCluster.isEmpty) {
        return false;
      }
      return true;
    } catch (e) {
      return false;
    }
  }
}
