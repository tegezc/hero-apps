import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import 'package:hero/modulapp/coverage/penilaian/uipenilaian.dart';
import 'package:hero/modulapp/coverage/promotion/hppromotion.dart';
import 'package:hero/modulapp/coverage/retur/hpretur.dart';
import 'package:hero/modulapp/coverage/retur/retureditor.dart';
import 'package:hero/modulapp/pagetab.dart';
import 'package:hero/modulapp/pagetabds.dart';
import 'package:hero/util/component/button/component_button.dart';
import 'package:hero/util/component/label/component_label.dart';
import 'package:hero/util/constapp/accountcontroller.dart';
import 'package:hero/util/loadingpage/loadinglogin.dart';
import 'package:hero/util/uiutil.dart';

import 'model/distribusi/datapembeli.dart';
import 'model/profile.dart';
import 'modulapp/camera/pagerecordvideo.dart';
import 'modulapp/camera/pagetakephoto.dart';
import 'modulapp/camera/previewphoto.dart';
import 'modulapp/camera/previewphotoupload.dart';
import 'modulapp/coverage/marketaudit/sf/hpsurvey.dart';

void main() {
  runApp(MyApp());
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
      //home: LoadingLoginPage(),
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
        return _buildRoute(settings, ResetPassword());
      case InputCodeVerification.routeName:
        return _buildRoute(settings, InputCodeVerification());
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
          return _buildRoute(settings, HomePageRetur());
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
  late List<BottomNavigationBarItem> _btmMenu;

  /// test only
  final bool _test = false;

  @override
  void initState() {
    _stateLogin = widget.statelogin!.enumStateLogin;
    if (_stateLogin == EnumStateLogin.loading) {
      _stateLogin = EnumStateLogin.loginonprogress;
    }
    _selectedtab = 0;
    super.initState();
  }

  Widget _titleCoverage() {
    return Row(children: [
      Image(
        image: AssetImage('assets/image/coverage/ic_logo_hore.png'),
        height: 40,
      ),
      Spacer(),
      GestureDetector(
          onTap: () {
            _showDialogConfirmLogout();
          },
          child: Image(
            image: AssetImage('assets/image/coverage/logout.png'),
            height: 40,
          ))
    ]);
  }

  Widget _titleWidget(String id) {
    return Row(
      children: [
        Image(
          image: AssetImage('assets/image/logoappbar.png'),
          height: 40,
        ),
        SizedBox(
          width: 12,
        ),
        Text(
          id,
          style: TextStyle(color: Colors.black, fontSize: 14),
        ),
        Spacer(),
        GestureDetector(
            onTap: () {
              _showDialogConfirmLogout();
            },
            child: Image(
              image: AssetImage('assets/image/coverage/logout.png'),
              height: 40,
            )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_test) {
      return UIPenilaian();
    } else if (_stateLogin == EnumStateLogin.loading) {
      return LoadingLoginPage();
    } else if (_stateLogin == EnumStateLogin.loginonprogress) {
      return LoginPage(_callbackSuccessLogin);
    } else if (_stateLogin == EnumStateLogin.loginsuccess) {
      return Scaffold(
        extendBodyBehindAppBar: true, //_selectedtab == 0 ? true : false,
        extendBody: true, //_selectedtab == 0 ? true : false,
        appBar: AppBar(
          // backgroundColor: Colors.white,
          elevation: 0,
          backgroundColor: Colors.transparent,
          // _selectedtab != 0 ? Colors.red[600] : Colors.transparent,
          title: _selectedtab != 0 ? _titleWidget(_iduser!) : _titleCoverage(),
        ),
        body: _getSelectedWidget(_selectedtab),
        bottomNavigationBar: BottomNavigationBar(
          selectedFontSize: 10,
          unselectedFontSize: 10,
          elevation: 0,
          backgroundColor: Colors.transparent,
          // _selectedtab == 0 ? Colors.transparent : Colors.white,
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
                    ? AssetImage('assets/image/icon/new/ic_coverage.png')
                    : AssetImage('assets/image/icon/new/disable/coverage.png'),
                height: 50,
              ),
              label: '', // 'Coverage'
            ),
            BottomNavigationBarItem(
              // icon: Icon(Icons.location_on),
              icon: Image(
                image: _selectedtab == 1
                    ? AssetImage('assets/image/icon/new/ic_distribution.png')
                    : AssetImage(
                        'assets/image/icon/new/disable/distribution.png'),
                height: 50,
              ),
              label: '', // 'Coverage'
            ),
            BottomNavigationBarItem(
              // icon: Icon(Icons.location_on),
              icon: Image(
                image: _selectedtab == 2
                    ? AssetImage('assets/image/icon/new/ic_merchandising.png')
                    : AssetImage(
                        'assets/image/icon/new/disable/merchandising.png'),
                height: 50,
              ),
              label: '', // 'Coverage'
            ),
            BottomNavigationBarItem(
              // icon: Icon(Icons.location_on),
              icon: Image(
                image: _selectedtab == 3
                    ? AssetImage('assets/image/icon/new/ic_promotion.png')
                    : AssetImage('assets/image/icon/new/disable/promotion.png'),
                height: 50,
              ),
              label: '', // 'Coverage'
            ),
            if (_enumAccount == EnumAccount.sf)
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
          return CoverageHome();
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
              ? PageMerchandising()
              : PageMerchandisingDs();
        }
      case 3:
        {
          return _enumAccount == EnumAccount.sf
              ? PagePromotion()
              : PagePromotionDs();
        }
      case 4:
        {
          if (_enumAccount == EnumAccount.sf) {
            return PageSurvey();
          }
        }
    }
    return Container();
  }

  _showDialogConfirmLogout() {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => SimpleDialog(
              title: Text('Confirm'),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      right: 16.0, left: 16.0, bottom: 3.0),
                  child: LabelBlack.size2('Apakah anda yakin akan logout?'),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      right: 16.0, left: 16.0, bottom: 3.0),
                  child: ButtonApp.black('Logout', () {
                    HttpLogin httpLogin = HttpLogin();
                    httpLogin.logout().then((value) {
                      if (value) {
                        print('Log Out');
                      } else {
                        print('gagal log out');
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
