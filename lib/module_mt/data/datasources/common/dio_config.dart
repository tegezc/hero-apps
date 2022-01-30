import 'package:dio/dio.dart';
import 'package:hero/module_mt/config_mt.dart';

class GetDio {
  final ConfigurationMT configurationMT = ConfigurationMT();
  Future<Dio> dio() async {
    String email = '';
    String token = '';
    String level = '';
    String idDivisi = '';
    String nama = '';
    var options = BaseOptions(
        baseUrl: configurationMT.host(),
        connectTimeout: 10000,
        receiveTimeout: 5000,
        headers: {
          "Auth-Key": "restapihore",
          "Client-Service": "frontendclienthore",
          "User-ID": email,
          "Auth-session": token,
          "Id-Level": level,
          "Id-Divisi": idDivisi,
          "Nama": nama,
        });
    return Dio(options);
  }

  Dio dioLogin() {
    var optionsLogin = BaseOptions(
        baseUrl: configurationMT.host(),
        connectTimeout: 10000,
        receiveTimeout: 5000,
        headers: {
          "Auth-Key": "restapihore",
          "Client-Service": "frontendclienthore"
        });
    return Dio(optionsLogin);
  }
}
