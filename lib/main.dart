import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hero/http/coverage/httpdashboard.dart';
import 'package:hero/http/login/httplogin.dart';
import 'package:hero/login/inputcodeverification.dart';
// ! Ubah path login {
import 'package:hero/login/login_new.dart';
// ! Ubah path Login }
import 'package:hero/login/resetpassword.dart';
import 'package:hero/model/pjp.dart';
import 'package:hero/model/promotion/promotion.dart';
import 'package:hero/modulapp/camera/previewvideo.dart';
import 'package:hero/modulapp/coverage/clockin/mapcloclin.dart';
import 'package:hero/modulapp/coverage/clockin/menusales.dart';
// ! Ubah path coverage / beranda {
import 'package:hero/modulapp/coverage/coveragehome_new.dart';
// ! Ubah path coverage / beranda }
import 'package:hero/modulapp/coverage/distribution/daftarproductdistribusi.dart';
import 'package:hero/modulapp/coverage/distribution/homepembeliandistribusi.dart';
import 'package:hero/modulapp/coverage/distribution/pembayaran/pembayarandistribusi.dart';
import 'package:hero/modulapp/coverage/distribution/pembelianitem/pembelian_item.dart';
import 'package:hero/modulapp/coverage/location/editoroutlet.dart';
import 'package:hero/modulapp/coverage/merchandising/homemerchandising.dart';
import 'package:hero/modulapp/coverage/pagesuccess.dart';
import 'package:hero/modulapp/coverage/promotion/hppromotion.dart';
import 'package:hero/modulapp/coverage/retur/hpretur.dart';
import 'package:hero/modulapp/coverage/retur/retureditor.dart';
import 'package:hero/modulapp/pagetab.dart';
import 'package:hero/modulapp/pagetabds.dart';
import 'package:hero/util/component/button/component_button.dart';
import 'package:hero/util/component/label/component_label.dart';
import 'package:hero/util/constapp/accountcontroller.dart';
import 'package:hero/util/uiutil.dart';

import 'configuration.dart';
import 'model/distribusi/datapembeli.dart';
import 'model/profile.dart';
import 'modulapp/camera/loadingview.dart';
import 'modulapp/camera/pagerecordvideo.dart';
import 'modulapp/camera/pagetakephoto.dart';
import 'modulapp/camera/previewphoto.dart';
import 'modulapp/camera/previewphotoupload.dart';
import 'modulapp/coverage/marketaudit/ds/uidsmarketaudit.dart';
import 'modulapp/coverage/marketaudit/sf/hpsurvey.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    return MaterialApp(
      title: 'Hore Mobile Apps',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeControllpage(
        statelogin: HomeControllpageParam(EnumStateLogin.loading),
      ),
      navigatorObservers: <NavigatorObserver>[
        SwipeBackObserver(),
      ],
      routes: const <String, WidgetBuilder>{},
      onGenerateRoute: (settings) {
        return _getRoute(settings);
      },
    );
  }

  Route? _getRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomeControllpage.routeName:
        {
          final HomeControllpageParam? args =
              settings.arguments as HomeControllpageParam?;
          return _buildRoute(
              settings,
              HomeControllpage(
                statelogin: args,
              ));
        }
      case ResetPassword.routeName:
        return _buildRoute(settings, const ResetPassword());
      case InputCodeVerification.routeName:
        return _buildRoute(settings, const InputCodeVerification());
      case MapClockIn.routeName:
        final Pjp? args = settings.arguments as Pjp?;
        return _buildRoute(settings, MapClockIn(args));
      case MenuSales.routeName:
        final Pjp? args = settings.arguments as Pjp?;
        return _buildRoute(settings, MenuSales(args));
      case DaftarProductDistribusi.routeName:
        final Pjp? item = settings.arguments as Pjp?;
        return _buildRoute(settings, DaftarProductDistribusi(item));
      case PembelianItem.routeName:
        {
          final ItemTransaksi? args = settings.arguments as ItemTransaksi?;
          return _buildRoute(settings, PembelianItem(args));
        }
      case PembayaranDistribusi.routeName:
        {
          final ParamPembayaran? paramPembayaran =
              settings.arguments as ParamPembayaran?;
          return _buildRoute(settings, PembayaranDistribusi(paramPembayaran));
        }
      case PageSuccess.routeName:
        {
          final param = settings.arguments;
          return _buildRoute(settings, PageSuccess(param as PageSuccessParam?));
        }
      case HomePembelianDistribusi.routeName:
        {
          final Pjp? item = settings.arguments as Pjp?;
          return _buildRoute(settings, HomePembelianDistribusi(item));
        }
      case HomeMerchandising.routeName:
        {
          final Pjp? item = settings.arguments as Pjp?;
          return _buildRoute(settings, HomeMerchandising(item));
        }
      case HomePagePromotion.routeName:
        {
          final Pjp? item = settings.arguments as Pjp?;
          return _buildRoute(settings, HomePagePromotion(item));
        }
      case HomePageRetur.routeName:
        {
          return _buildRoute(settings, const HomePageRetur());
        }
      case ReturEditor.routeName:
        {
          return _buildRoute(settings, ReturEditor());
        }
      case EditorOutlet.routeName:
        {
          final String? item = settings.arguments as String?;
          return _buildRoute(settings, EditorOutlet(item));
        }
      case CameraView.routeName:
        {
          final ParamPreviewPhoto? item =
              settings.arguments as ParamPreviewPhoto?;
          return _buildRoute(settings, CameraView(item));
        }
      case PreviewPhotoWithUpload.routeName:
        {
          final ParamPreviewPhoto? item =
              settings.arguments as ParamPreviewPhoto?;
          return _buildRoute(settings, PreviewPhotoWithUpload(item));
        }

      case PreviewPhoto.routeName:
        {
          final ParamPreviewPhoto? item =
              settings.arguments as ParamPreviewPhoto?;
          return _buildRoute(settings, PreviewPhoto(item));
        }
      case HomeSurvey.routeName:
        {
          final Pjp? item = settings.arguments as Pjp?;
          return _buildRoute(settings, HomeSurvey(item));
        }
      case CoverageMarketAudit.routeName:
        {
          //final Pjp? item = settings.arguments as Pjp?;
          return _buildRoute(settings, const CoverageMarketAudit());
        }
      case PageTakeVideo.routeName:
        {
          final Promotion? item = settings.arguments as Promotion?;
          return _buildRoute(settings, PageTakeVideo(item));
        }
      case PreviewVideoUpload.routeName:
        {
          final ParamPreviewVideo? item =
              settings.arguments as ParamPreviewVideo?;
          return _buildRoute(settings, PreviewVideoUpload(item));
        }
      default:
        return null;
    }
  }

  MaterialPageRoute _buildRoute(RouteSettings settings, Widget builder) {
    return MaterialPageRoute(
      settings: settings,
      builder: (BuildContext context) => builder,
    );
  }
}

class HomeControllpage extends StatefulWidget {
  static const routeName = '/';
  const HomeControllpage({Key? key, required this.statelogin})
      : super(key: key);
  final HomeControllpageParam? statelogin;

  @override
  _HomeControllpageState createState() => _HomeControllpageState();
}

class _HomeControllpageState extends State<HomeControllpage> {
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
    return true;
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
      return LoadingNunggu("Mempersiapkan data\n mohon menunggu");
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
    _enumAccount = await AccountHore.getAccount();
    Profile p = await AccountHore.getProfile();
    _iduser = p.id;
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

enum EnumStateLogin { loading, loginonprogress, loginsuccess }

class HomeControllpageParam {
  EnumStateLogin enumStateLogin;
  HomeControllpageParam(this.enumStateLogin);
}
