import 'package:hero/module_mt/data/datasources/datasources/auth/get_remote_login.dart';
import 'package:hero/module_mt/domain/entity/auth/account.dart';
import 'package:hero/module_mt/domain/repositories/auth/i_remote_login_repository.dart';

class RemoteLoginRepository implements IRemoteLoginRepository {
  final GetRemoteLogin getRemoteLogin;
  RemoteLoginRepository({required this.getRemoteLogin});
  @override
  Future<Account?> login(String id, String password) async {
    return await getRemoteLogin.login(id, password);
  }
}
