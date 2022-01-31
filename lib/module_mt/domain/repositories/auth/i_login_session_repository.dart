import 'package:hero/module_mt/domain/entity/auth/account.dart';

abstract class ILoginSessionRepository {
  Account? getAccount();
  Future<bool> setAccount(Account account);
}
