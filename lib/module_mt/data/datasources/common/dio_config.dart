import 'package:dio/dio.dart';
import 'package:hero/config/config_mt.dart';
import 'package:hero/module_mt/data/datasources/datasources/auth/get_local_session_login.dart';
import 'package:hero/module_mt/data/repositories/auth/login_session_repository.dart';
import 'package:hero/module_mt/domain/entity/auth/account.dart';
import 'package:hero/module_mt/domain/repositories/auth/i_login_session_repository.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'interceptor.dart';

class GetDio {
  final ConfigurationMT configurationMT = ConfigurationMT();
  late ILoginSessionRepository loginSessionRepository;

  Future<Dio> dio() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    GetLocalSessionLoginSharedPref getLocalSessionLoginSharedPref =
        GetLocalSessionLoginSharedPref(sharedPreferences: sharedPreferences);
    loginSessionRepository = LoginSessionRepositoryImpl(
        getLocalSessionLoginSharedPref: getLocalSessionLoginSharedPref);
    String email = '';
    String token = '';
    String level = '';
    String idDivisi = '';
    String nama = '';
    Account? account = loginSessionRepository.getAccount();
    if (account != null && account.isValid()) {
      email = account.email;
      token = account.token;
      level = account.level;
      idDivisi = account.idDidvisi;
      nama = account.nama;
    }
    var options = BaseOptions(
        baseUrl: configurationMT.host(),
        connectTimeout: 30000,
        receiveTimeout: 30000,
        headers: {
          "Auth-Key": "restapihore",
          "Client-Service": "frontendclienthore",
          "User-ID": email,
          "Auth-session": token,
          "Id-Level": level,
          "Id-Divisi": idDivisi,
          "Nama": nama,
        });

    Dio dioInstance = Dio(options);
    dioInstance.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 110));
    dioInstance.interceptors.add(AppInterceptors());
    return Dio(options);
  }

  Dio dioLogin() {
    var optionsLogin = BaseOptions(
        baseUrl: configurationMT.host(),
        connectTimeout: 10000,
        receiveTimeout: 5000,
        contentType: Headers.formUrlEncodedContentType,
        headers: {
          "Auth-Key": "restapihore",
          "Client-Service": "frontendclienthore"
        });

    return Dio(optionsLogin);
  }
}
