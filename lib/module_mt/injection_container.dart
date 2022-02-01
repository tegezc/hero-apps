import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/datasources/auth/get_local_session_login.dart';
import 'data/datasources/auth/get_remote_login.dart';
import 'data/repositories/auth/login_session_repository.dart';
import 'data/repositories/auth/remote_login_repository.dart';
import 'domain/repositories/auth/i_login_session_repository.dart';
import 'domain/repositories/auth/i_remote_login_repository.dart';
import 'domain/usecase/auth/cek_session_login.dart';
import 'domain/usecase/auth/request_login.dart';

final sll = GetIt.instance;

Future<void> init() async {
  // Bloc
  // sll.registerFactory(
  //   () => AuthCubit(cekSessionLogin: sll(), requestLoginAndProsesLogin: sll()),
  // );

  //usecase
  sll.registerLazySingleton(() => CekSessionLogin(loginSession: sll()));

  sll.registerLazySingleton(() => RequestLoginAndProsesLogin(
      loginSession: sll(), remoteLoginRepository: sll()));

  //repository
  sll.registerLazySingleton<ILoginSessionRepository>(
      () => LoginSessionRepositoryImpl(getLocalSessionLoginSharedPref: sll()));
  sll.registerLazySingleton<IRemoteLoginRepository>(
      () => RemoteLoginRepository(getRemoteLogin: sll()));

  // data source
  sll.registerLazySingleton<GetLocalSessionLogin>(
      () => GetLocalSessionLoginSharedPref(sharedPreferences: sll()));
  sll.registerLazySingleton<GetRemoteLogin>(() => GetRemoteLoginImpl());

  //! External

  SharedPreferences sharedPref = await SharedPreferences.getInstance();
  sll.registerSingleton<SharedPreferences>(sharedPref);
  // sl.registerLazySingleton(() => http.Client());
  // sl.registerLazySingleton(() => DataConnectionChecker());
}
