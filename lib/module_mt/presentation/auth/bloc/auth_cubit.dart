import 'package:bloc/bloc.dart';
import 'package:hero/module_mt/data/datasources/datasources/auth/get_local_session_login.dart';
import 'package:hero/module_mt/data/datasources/datasources/auth/get_remote_login.dart';
import 'package:hero/module_mt/data/repositories/auth/login_session_repository.dart';
import 'package:hero/module_mt/data/repositories/auth/remote_login_repository.dart';
import 'package:hero/module_mt/domain/usecase/auth/cek_session_login.dart';
import 'package:hero/module_mt/domain/usecase/auth/request_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  late RequestLoginAndProsesLogin requestLoginAndProsesLogin;
  late CekSessionLogin cekSessionLogin;
  AuthCubit() : super(AuthInitial());

  void setupData() {
    emit(AuthInitial());
    _setupData().then((value) {
      if (cekSessionLogin.isLoggedIn()) {
        emit(AuthAlreadyLoggedIn());
      } else {
        emit(AuthNotLoggedIn());
      }
    });
  }

  Future<void> _setupData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    GetLocalSessionLoginSharedPref getLocalSessionLoginSharedPref =
        GetLocalSessionLoginSharedPref(sharedPreferences: sharedPreferences);
    LoginSessionRepositoryImpl loginSession = LoginSessionRepositoryImpl(
        getLocalSessionLoginSharedPref: getLocalSessionLoginSharedPref);

    GetRemoteLoginImpl getRemoteLoginImpl = GetRemoteLoginImpl();
    RemoteLoginRepository remoteLoginRepository =
        RemoteLoginRepository(getRemoteLogin: getRemoteLoginImpl);
    requestLoginAndProsesLogin = RequestLoginAndProsesLogin(
        loginSession: loginSession,
        remoteLoginRepository: remoteLoginRepository);

    cekSessionLogin = CekSessionLogin(loginSession: loginSession);
  }

  void login(String id, String password) {
    requestLoginAndProsesLogin
        .requestAndProcessLogin(id, password)
        .then((value) {
      if (value) {
        emit(AuthAlreadyLoggedIn());
      } else {
        emit(AuthNotLoggedIn());
      }
    });
  }
}
