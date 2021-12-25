import 'package:flutter/material.dart';
import 'package:hero/http/coverage/httpdashboard.dart';
import 'package:hero/model/enumapp.dart';
import 'package:hero/model/menu.dart';
import 'package:hero/model/pjp.dart';
import 'package:hero/modulapp/coverage/distribution/homepembeliandistribusi.dart';
import 'package:hero/modulapp/coverage/marketaudit/sf/hpsurvey.dart';
import 'package:hero/modulapp/coverage/merchandising/homemerchandising.dart';
import 'package:hero/modulapp/coverage/promotion/hppromotion.dart';
import 'package:hero/util/component/component_button.dart';
import 'package:hero/util/component/component_widget.dart';
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

  @override
  void initState() {
    super.initState();
  }

  void _setup() {
    print('masuk');
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
        width: size.width,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Column(
            children: [
              SizedBox(
                height: 12,
              ),
              Divider(),
              _controllMenu(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _controllMenu() {
    if (_enumAccount == EnumAccount.ds) {
      if (widget.pjp!.idjenilokasi == ConstApp.keyPOI) {
        return _openDsPoi();
      }
      return _openDS();
    }

    return _openSf();
  }

  _showDialogConfirmClockOut() {
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
                  child: ButtonApp.black('Clock Out', () {
                    _clockOut().then((value) {
                      if (value) {
                        Navigator.popUntil(context, ModalRoute.withName('/'));
                      }
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

  Future<bool> _clockOut() async {
    HttpDashboard httpDashboard = new HttpDashboard();
    bool result = await httpDashboard.clockout();
    return result;
  }

  Widget _openSf() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ButtonMenu(Icons.shopping_cart, 'DISTRIBUTION', () {
              _tapMenu(EnumTab.distribution);
            }, enable: _menu!.isDistEnable),
            ButtonMenu(
              Icons.work,
              'MERCHANDISING',
              () {
                _tapMenu(EnumTab.merchandising);
              },
              enable: _menu!.isMerchEnable,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ButtonMenu(
              Icons.campaign,
              'PROMOTION',
              () {
                _tapMenu(EnumTab.promotion);
              },
              enable: _menu!.isPromEnable,
            ),
            ButtonMenu(
              Icons.widgets,
              'MARKET AUDIT',
              () {
                _tapMenu(EnumTab.survey);
              },
              enable: _menu!.isMarketEnable,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ButtonMenu(Icons.location_off, 'Clock Out', () {
              _showDialogConfirmClockOut();
            }),
            Container(),
          ],
        ),
      ],
    );
  }

  Widget _openDsPoi() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ButtonMenu(Icons.shopping_cart, 'DISTRIBUTION', () {
              _tapMenu(EnumTab.distribution);
            }, enable: _menu!.isDistEnable),
            ButtonMenu(
              Icons.campaign,
              'PROMOTION',
              () {
                _tapMenu(EnumTab.promotion);
              },
              enable: _menu!.isPromEnable,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ButtonMenu(Icons.location_off, 'Clock Out', () {
              _showDialogConfirmClockOut();
            }),
            Container(),
          ],
        ),
      ],
    );
  }

  Widget _openDS() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ButtonMenu(Icons.shopping_cart, 'DISTRIBUTION', () {
              _tapMenu(EnumTab.distribution);
            }, enable: _menu!.isDistEnable),
            ButtonMenu(
              Icons.work,
              'MERCHANDISING',
              () {
                _tapMenu(EnumTab.merchandising);
              },
              enable: _menu!.isMerchEnable,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ButtonMenu(
              Icons.campaign,
              'PROMOTION',
              () {
                _tapMenu(EnumTab.promotion);
              },
              enable: _menu!.isPromEnable,
            ),
            ButtonMenu(Icons.file_copy, 'Market Audit', () {
              _tapMenu(EnumTab.survey);
            }),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ButtonMenu(Icons.location_off, 'Clock Out', () {
              _showDialogConfirmClockOut();
            }),
            Container(),
          ],
        ),
      ],
    );
  }

  void _tapMenu(EnumTab enumTab) {
    HttpDashboard httpDashboard = new HttpDashboard();
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
            // if (_enumAccount == EnumAccount.sf) {
            //   await Navigator.pushNamed(context, HomeMerchandising.routeName,
            //       arguments: widget.pjp);
            // } else {
            //   await Navigator.pushNamed(context, HomeMerchandisingDs.routeName);
            // }
            await Navigator.pushNamed(context, HomeMerchandising.routeName,
                arguments: widget.pjp);
            break;
          case EnumTab.promotion:
            await Navigator.pushNamed(context, HomePagePromotion.routeName,
                arguments: widget.pjp);

            break;
          case EnumTab.survey:
            await Navigator.pushNamed(context, HomeSurvey.routeName,
                arguments: widget.pjp);

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
