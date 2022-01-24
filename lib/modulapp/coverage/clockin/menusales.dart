import 'package:flutter/material.dart';
import 'package:hero/http/coverage/httpdashboard.dart';
import 'package:hero/model/enumapp.dart';
import 'package:hero/model/menu.dart';
import 'package:hero/model/pjp.dart';
import 'package:hero/modulapp/coverage/clockin/clcokinclockoutcontroller.dart';
import 'package:hero/modulapp/coverage/distribution/homepembeliandistribusi.dart';
import 'package:hero/modulapp/coverage/marketaudit/ds/uidsmarketaudit.dart';
import 'package:hero/modulapp/coverage/marketaudit/sf/hpsurvey.dart';
import 'package:hero/modulapp/coverage/merchandising/homemerchandising.dart';
import 'package:hero/modulapp/coverage/promotion/hppromotion.dart';
import 'package:hero/util/component/button/component_button.dart';
import 'package:hero/util/component/image/component_image_new.dart';
import 'package:hero/util/component/label/component_label.dart';
import 'package:hero/util/component/widget/component_widget.dart';
import 'package:hero/util/constapp/accountcontroller.dart';
import 'package:hero/util/constapp/constapp.dart';

class MenuSales extends StatefulWidget {
  static const routeName = '/menusales';
  final Pjp? pjp;
  MenuSales(this.pjp);

  @override
  _MenuSalesState createState() => _MenuSalesState();
}

class _MenuSalesState extends State<MenuSales> {
  Menu? _menu;
  EnumAccount? _enumAccount;
  int _counterBuild = 0;
  late ClockInClockOutController _clockInClockOutController;

  @override
  void initState() {
    _clockInClockOutController = ClockInClockOutController();
    super.initState();
  }

  void _setup() {
    _reloadData().then((value) {
      setState(() {});
    });
  }

  Future<bool> _reloadData() async {
    HttpDashboard httpDashboard = HttpDashboard();
    _menu = await httpDashboard.getMenu();
    _enumAccount = await AccountHore.getAccount();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    if (_counterBuild == 0) {
      _setup();
      _counterBuild++;
    }
    Size size = MediaQuery.of(context).size;
    if (_enumAccount == null || _menu == null) {
      return CustomScaffold(body: Container(), title: '');
    }
    return CustomScaffold(
      title: 'Clock In',
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            //image: AssetImage('assets/image/coverage/BG.png'),
            image: AssetImage('assets/image/new/BG.png'),
            fit: BoxFit.cover,
          ),
        ),
        width: size.width,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              const Image(
                  image: AssetImage('assets/image/new/big_logo.png'),
                  height: 90),
              const SizedBox(
                height: 20,
              ),
              _controllMenu(),
            ],
          ),
        ),
      ),
    );
  }

  _showDialogConfirmClockOut() {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => SimpleDialog(
              title: const Text('Confirm'),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      right: 16.0, left: 16.0, bottom: 3.0),
                  child: LabelBlack.size2("Apakah anda yakin akan clockout?"),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      right: 16.0, left: 16.0, bottom: 3.0),
                  child: ButtonApp.black('Ya', () {
                    _clockInClockOutController.clockOut().then((value) {
                      if (value) {
                        Navigator.popUntil(context, ModalRoute.withName('/'));
                      }
                    });
                  }),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      right: 16.0, left: 16.0, bottom: 3.0),
                  child: ButtonApp.black('Tidak', () {
                    Navigator.of(context).pop();
                  }),
                ),
              ],
            ));
  }

  Widget _controllMenu() {
    if (_enumAccount == EnumAccount.sf) {
      return _openSf();
    }
    if (widget.pjp!.idjenilokasi == ConstApp.keyPOI) {
      return _openDsPoi();
    }
    return _openDS();
  }

  Widget _openSf() {
    bool isComplete = _menu!.isSfComplete();

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ClockInImageIcon(
              onTap: () {
                _tapMenu(EnumTab.distribution);
              },
              image: 'assets/image/icon/clockin/enable/ic_en_distribution.png',
              disableImage:
                  'assets/image/icon/clockin/disable/ic_ds_distribution.png',
              completeImage:
                  'assets/image/icon/clockin/complete/ic_ck_distribution.png',
              enable: _menu!.isDistEnable!,
            ),
            ClockInImageIcon(
              onTap: () {
                _tapMenu(EnumTab.merchandising);
              },
              image: 'assets/image/icon/clockin/enable/ic_en_merchandising.png',
              disableImage:
                  'assets/image/icon/clockin/disable/ic_ds_merchandising.png',
              completeImage:
                  'assets/image/icon/clockin/complete/ic_ck_merchandising.png',
              enable: _menu!.isMerchEnable!,
            )
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ClockInImageIcon(
              onTap: () {
                _tapMenu(EnumTab.promotion);
              },
              image: 'assets/image/icon/clockin/enable/ic_en_promotion.png',
              disableImage:
                  'assets/image/icon/clockin/disable/ic_ds_promotion.png',
              completeImage:
                  'assets/image/icon/clockin/complete/ic_ck_promotion.png',
              enable: _menu!.isPromEnable!,
            ),
            ClockInImageIcon(
              onTap: () {
                _tapMenu(EnumTab.marketaudit);
              },
              image: 'assets/image/icon/clockin/enable/ic_en_market_audit.png',
              disableImage:
                  'assets/image/icon/clockin/disable/ic_ds_market_audit.png',
              completeImage:
                  'assets/image/icon/clockin/complete/ic_ck_market_audit.png',
              enable: _menu!.isMarketEnable!,
            )
          ],
        ),
        const SizedBox(height: 10),
        _buttonClockOut(isComplete),
      ],
    );
  }

  Widget _openDsPoi() {
    bool isComplete = _menu!.isPoiComplete();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ClockInImageIcon(
              onTap: () {
                _tapMenu(EnumTab.distribution);
              },
              image: 'assets/image/icon/clockin/enable/ic_en_distribution.png',
              disableImage:
                  'assets/image/icon/clockin/disable/ic_ds_distribution.png',
              completeImage:
                  'assets/image/icon/clockin/complete/ic_ck_distribution.png',
              enable: _menu!.isDistEnable!,
            ),
            ClockInImageIcon(
              onTap: () {
                _tapMenu(EnumTab.promotion);
              },
              image: 'assets/image/icon/clockin/enable/ic_en_promotion.png',
              disableImage:
                  'assets/image/icon/clockin/disable/ic_ds_promotion.png',
              completeImage:
                  'assets/image/icon/clockin/complete/ic_ck_promotion.png',
              enable: _menu!.isPromEnable!,
            ),
          ],
        ),
        _buttonClockOut(isComplete),
      ],
    );
  }

  Widget _openDS() {
    bool isComplete = _menu!.isDsComplete();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ClockInImageIcon(
              onTap: () {
                _tapMenu(EnumTab.distribution);
              },
              image: 'assets/image/icon/clockin/enable/ic_en_distribution.png',
              disableImage:
                  'assets/image/icon/clockin/disable/ic_ds_distribution.png',
              completeImage:
                  'assets/image/icon/clockin/complete/ic_ck_distribution.png',
              enable: _menu!.isDistEnable!,
            ),
            ClockInImageIcon(
              onTap: () {
                _tapMenu(EnumTab.merchandising);
              },
              image: 'assets/image/icon/clockin/enable/ic_en_merchandising.png',
              disableImage:
                  'assets/image/icon/clockin/disable/ic_ds_merchandising.png',
              completeImage:
                  'assets/image/icon/clockin/complete/ic_ck_merchandising.png',
              enable: _menu!.isMerchEnable!,
            )
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ClockInImageIcon(
              onTap: () {
                _tapMenu(EnumTab.promotion);
              },
              image: 'assets/image/icon/clockin/enable/ic_en_promotion.png',
              disableImage:
                  'assets/image/icon/clockin/disable/ic_ds_promotion.png',
              completeImage:
                  'assets/image/icon/clockin/complete/ic_ck_promotion.png',
              enable: _menu!.isPromEnable!,
            ),
            ClockInImageIcon(
              onTap: () {
                _tapMenu(EnumTab.marketaudit);
              },
              image: 'assets/image/icon/clockin/enable/ic_en_market_audit.png',
              disableImage:
                  'assets/image/icon/clockin/disable/ic_ds_market_audit.png',
              completeImage:
                  'assets/image/icon/clockin/complete/ic_ck_market_audit.png',
              enable: _menu!.isMarketEnable!,
            )
          ],
        ),
        const SizedBox(height: 10),
        _buttonClockOut(isComplete),
      ],
    );
  }

  Widget _buttonClockOut(bool iscomplete) {
    return ButtonStrectWidth(
      text: "Clock Out",
      onTap: () {
        _showDialogConfirmClockOut();
      },
      buttonColor: Colors.red,
      isenable: iscomplete ? true : false,
    );
  }

  void _tapMenu(EnumTab enumTab) {
    HttpDashboard httpDashboard = HttpDashboard();
    httpDashboard.startMenu(enumTab).then((value) async {
      if (value) {
        switch (enumTab) {
          case EnumTab.distribution:
            await Navigator.pushNamed(
              context,
              HomePembelianDistribusi.routeName,
              arguments: widget.pjp,
            );
            break;
          case EnumTab.merchandising:
            await Navigator.pushNamed(context, HomeMerchandising.routeName,
                arguments: widget.pjp);
            break;
          case EnumTab.promotion:
            await Navigator.pushNamed(context, HomePagePromotion.routeName,
                arguments: widget.pjp);

            break;
          case EnumTab.marketaudit:
            if (_enumAccount == EnumAccount.sf) {
              await Navigator.pushNamed(context, HomeSurvey.routeName,
                  arguments: widget.pjp);
            } else {
              await Navigator.pushNamed(context, CoverageMarketAudit.routeName);
            }

            break;
          case EnumTab.mt:
            // ignore: todo
            // TODO: Handle this case.
            break;
        }
        _setup();
      } else {}
    });
  }
}
