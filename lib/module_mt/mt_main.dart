import 'package:flutter/material.dart';
import 'package:hero/http/coverage/httpdashboard.dart';
import 'package:hero/http/login/httplogin.dart';
import 'package:hero/login/login.dart';
import 'package:hero/model/profile.dart';
import 'package:hero/modul_sales/sf_main.dart';
import 'package:hero/modulapp/camera/loadingview.dart';
import 'package:hero/modulapp/coverage/coveragehome_new.dart';
import 'package:hero/modulapp/pagetab.dart';
import 'package:hero/modulapp/pagetabds.dart';
import 'package:hero/hore_route.dart';
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
  int? _selectedtab;
  EnumStateLogin? _stateLogin;
  EnumAccount? _enumAccount;
  String? _iduser = '';
  int _counterBuild = 0;

  @override
  void initState() {
    _stateLogin = widget.statelogin!.enumStateLogin;
    _selectedtab = 0;
    super.initState();
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
    HttpDashboard httpDashboard = HttpDashboard();
    var pjphariini = await httpDashboard.getPjpHariIni();
    if (pjphariini == null) {
      return false;
    }
    _enumAccount = await _getAccount();
    return true;
  }

  Future<EnumAccount> _getAccount() async {
    return await AccountHore.getAccount();
  }

  Widget _titleCoverage() {
    return Row(children: [
      const Image(
        image: AssetImage('assets/image/coverage/ic_logo_hore.png'),
        height: 40,
      ),
      const Spacer(),
      GestureDetector(
          onTap: () {
            _showDialogConfirmLogout();
          },
          child: const Image(
            image: AssetImage('assets/image/coverage/logout.png'),
            height: 40,
          ))
    ]);
  }

  Widget _titleWidget(String id) {
    return Row(
      children: [
        const Image(
          image: AssetImage('assets/image/logoappbar.png'),
          height: 40,
        ),
        const SizedBox(
          width: 12,
        ),
        Text(
          id,
          style: const TextStyle(color: Colors.black, fontSize: 14),
        ),
        const Spacer(),
        GestureDetector(
            onTap: () {
              _showDialogConfirmLogout();
            },
            child: const Image(
              image: AssetImage('assets/image/coverage/logout.png'),
              height: 40,
            )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_counterBuild == 0) {
      _counterBuild++;
      _cekLogin();
    }
    if (_stateLogin == EnumStateLogin.loading) {
      return const LoadingNunggu("Mempersiapkan data\n mohon menunggu");
    } else if (_stateLogin == EnumStateLogin.loginonprogress) {
      return LoginPage(_callbackSuccessLogin);
    } else if (_stateLogin == EnumStateLogin.loginsuccess) {
      return Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: _selectedtab != 0 ? _titleWidget(_iduser!) : _titleCoverage(),
        ),
        body: _getSelectedWidget(_selectedtab),
        bottomNavigationBar: BottomNavigationBar(
          selectedFontSize: 10,
          unselectedFontSize: 10,
          elevation: 0,
          backgroundColor: Colors.transparent,

          type: BottomNavigationBarType.fixed,
          onTap: (v) {
            setState(() {
              _selectedtab = v;
            });
          },
          // new
          currentIndex: _selectedtab!,
          // new
          // items: _btmMenu,
          items: [
            BottomNavigationBarItem(
              // icon: Icon(Icons.location_on),
              icon: Image(
                image: _selectedtab == 0
                    ? const AssetImage('assets/image/icon/new/ic_coverage.png')
                    : const AssetImage(
                        'assets/image/icon/new/disable/coverage.png'),
                height: 50,
              ),
              label: '', // 'Coverage'
            ),
            BottomNavigationBarItem(
              // icon: Icon(Icons.location_on),
              icon: Image(
                image: _selectedtab == 1
                    ? const AssetImage(
                        'assets/image/icon/new/ic_distribution.png')
                    : const AssetImage(
                        'assets/image/icon/new/disable/distribution.png'),
                height: 50,
              ),
              label: '', // 'Coverage'
            ),
            BottomNavigationBarItem(
              // icon: Icon(Icons.location_on),
              icon: Image(
                image: _selectedtab == 2
                    ? const AssetImage(
                        'assets/image/icon/new/ic_merchandising.png')
                    : const AssetImage(
                        'assets/image/icon/new/disable/merchandising.png'),
                height: 50,
              ),
              label: '', // 'Coverage'
            ),
            BottomNavigationBarItem(
              // icon: Icon(Icons.location_on),
              icon: Image(
                image: _selectedtab == 3
                    ? const AssetImage('assets/image/icon/new/ic_promotion.png')
                    : const AssetImage(
                        'assets/image/icon/new/disable/promotion.png'),
                height: 50,
              ),
              label: '', // 'Coverage'
            ),
            if (_enumAccount == EnumAccount.sf ||
                _enumAccount == EnumAccount.ds)
              BottomNavigationBarItem(
                // icon: Icon(Icons.location_on),
                icon: Image(
                  image: _selectedtab == 4
                      ? const AssetImage(
                          'assets/image/icon/new/ic_market_audit.png')
                      : const AssetImage(
                          'assets/image/icon/new/disable/market_audit.png'),
                  height: 50,
                ),
                label: '', // 'Coverage'
              ),
          ],
        ), // This trailing comma makes auto-formatting nicer for build methods.
      );
    } else {
      return Container();
    }
  }

  void _callbackSuccessLogin() {
    _setupLoginSUccess().then((value) {
      setState(() {
        _selectedtab = 0;
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

  Widget _getSelectedWidget(int? selectedtab) {
    switch (selectedtab) {
      case 0:
        {
          return const CoverageHome();
        }
      case 1:
        {
          return _enumAccount == EnumAccount.sf
              ? const PageDistribusi()
              : const PageDistribusiDs();
        }
      case 2:
        {
          return _enumAccount == EnumAccount.sf
              ? const PageMerchandising()
              : const PageMerchandisingDs();
        }
      case 3:
        {
          return _enumAccount == EnumAccount.sf
              ? const PagePromotion()
              : const PagePromotionDs();
        }
      case 4:
        {
          if (_enumAccount == EnumAccount.sf) {
            return const PageSurvey();
          } else if (_enumAccount == EnumAccount.ds) {
            return const PageMarketAudit();
          }
        }
    }
    return Container();
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
