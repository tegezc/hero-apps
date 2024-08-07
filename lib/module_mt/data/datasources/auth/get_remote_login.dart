import 'package:dio/dio.dart';
import 'package:hero/module_mt/data/datasources/core/dio_config.dart';
import 'package:hero/module_mt/data/model/auth/account_model.dart';

abstract class GetRemoteLogin {
  Future<AccountModel?> login(String id, String password);
}

class GetRemoteLoginImpl implements GetRemoteLogin {
  final GetDio getDio = GetDio();
  @override
  Future<AccountModel?> login(String id, String password) async {
    Dio dio = getDio.dioLogin();

    var response = await dio.post(
      '/auth/login',
      data: {'username': id, 'password': password},
    );
    return AccountModel.fromJson(response.data);
  }
}
