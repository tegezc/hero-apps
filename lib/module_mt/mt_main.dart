import 'package:flutter/material.dart';
import 'package:hero/http/login/httplogin.dart';
import 'package:hero/login/login_new.dart';
import 'package:hero/model/profile.dart';
import 'package:hero/modul_sales/sf_main.dart';
import 'package:hero/modulapp/camera/loadingview.dart';
import 'package:hero/modulapp/coverage/coveragehome_new.dart';
import 'package:hero/modulapp/pagetab.dart';
import 'package:hero/modulapp/pagetabds.dart';
import 'package:hero/hore_route.dart';
import 'package:hero/module_mt/presentation/menu_mt.dart';
import 'package:hero/util/component/button/component_button.dart';
import 'package:hero/util/component/label/component_label.dart';
import 'package:hero/util/constapp/accountcontroller.dart';
import 'package:hero/util/uiutil.dart';

import '../configuration.dart';

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
  EnumAccount? _enumAccount;
  String? _iduser = '';

  @override
  void initState() {
    _stateLogin = widget.statelogin!.enumStateLogin;
    super.initState();
  }

  Future<EnumAccount> _getAccount() async {
    return await AccountHore.getAccount();
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
    _enumAccount = await _getAccount();
    Profile p = await AccountHore.getProfile();
    _iduser = p.id;
    ph('ID USER LOGIN SUKSES$_iduser');
    return true;
  }

  _showDialogConfirmLogout() {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => SimpleDialog(
              title: const Text('Confirm'),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              children: <Widget>[
                const Padding(
                  padding:
                      EdgeInsets.only(right: 16.0, left: 16.0, bottom: 3.0),
                  child: LabelBlack.size2('Apakah anda yakin akan logout?'),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      right: 16.0, left: 16.0, bottom: 3.0),
                  child: ButtonApp.black('Logout', () {
                    HttpLogin httpLogin = HttpLogin();
                    httpLogin.logout().then((value) {
                      if (value) {
                        ph('Log Out');
                      } else {
                        ph('gagal log out');
                      }
                    });
                    Navigator.of(context).pop();
                    setState(() {
                      _stateLogin = EnumStateLogin.loginonprogress;
                    });
                  }),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      right: 16.0, left: 16.0, bottom: 3.0),
                  child: ButtonApp.black('Cancel', () {
                    Navigator.of(context).pop();
                  }),
                ),
              ],
            ));
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
