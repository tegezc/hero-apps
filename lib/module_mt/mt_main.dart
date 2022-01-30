import 'package:flutter/material.dart';
import 'package:hero/login/login_new.dart';
import 'package:hero/model/profile.dart';
import 'package:hero/modul_sales/sf_main.dart';
import 'package:hero/modulapp/camera/loadingview.dart';
import 'package:hero/hore_route.dart';
import 'package:hero/module_mt/domain/usecase/back_checking/back_checking_use_case.dart';
import 'package:hero/module_mt/presentation/menu_mt.dart';
import 'package:hero/util/constapp/accountcontroller.dart';
import 'package:hero/util/uiutil.dart';

import '../configuration.dart';
import 'domain/entity/back_checking.dart';

class MTHomeControllpage extends StatefulWidget {
  static const routeName = '/';
  const MTHomeControllpage({Key? key, required this.statelogin})
      : super(key: key);
  final HomeControllpageParam? statelogin;

  @override
  _MTHomeControllpageState createState() => _MTHomeControllpageState();
}

class _MTHomeControllpageState extends State<MTHomeControllpage> {
  EnumStateLogin? _stateLogin;
  String? _iduser = '';
  final BackCheckingUseCase _backCheckingUseCase = BackCheckingUseCase();
  @override
  void initState() {
    super.initState();
    _stateLogin = widget.statelogin!.enumStateLogin;
    _cekLogin();
  }

  void _cekLogin() {
    _isAlreadyLogin().then((value) {
      if (value) {
        _stateLogin = EnumStateLogin.loginsuccess;
      } else {
        _stateLogin = EnumStateLogin.loginonprogress;
      }
      setState(() {});
    });
  }

  Future<bool> _isAlreadyLogin() async {
    BackChecking? bc = await _backCheckingUseCase.getBackChecking();
    if (bc == null) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    if (_stateLogin == EnumStateLogin.loading) {
      return const LoadingNunggu("Mempersiapkan data\n mohon menunggu");
    } else if (_stateLogin == EnumStateLogin.loginonprogress) {
      return LoginPage(_callbackSuccessLogin);
    } else if (_stateLogin == EnumStateLogin.loginsuccess) {
      return const MenuMt();
    } else {
      return Container();
    }
  }

  void _callbackSuccessLogin() {
    _setupLoginSUccess().then((value) {
      setState(() {
        _stateLogin = EnumStateLogin.loginsuccess;
      });
    });
  }

  Future<bool> _setupLoginSUccess() async {
    Profile p = await AccountHore.getProfile();
    _iduser = p.id;
    ph('ID USER LOGIN SUKSES$_iduser');
    return true;
  }
}

class MTRootApp extends StatelessWidget {
  MTRootApp({Key? key}) : super(key: key);
  final HoreRoute _route = HoreRoute();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hore Mobile Apps',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MTHomeControllpage(
        statelogin: HomeControllpageParam(EnumStateLogin.loading),
      ),
      navigatorObservers: <NavigatorObserver>[
        SwipeBackObserver(),
      ],
      routes: const <String, WidgetBuilder>{},
      onGenerateRoute: (settings) {
        return _route.getRoute(settings);
      },
    );
  }
}
