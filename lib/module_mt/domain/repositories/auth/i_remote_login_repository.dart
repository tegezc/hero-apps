import 'package:hero/module_mt/domain/entity/auth/account.dart';

abstract class IRemoteLoginRepository {
  Future<Account?> login(String id, String password);
}
