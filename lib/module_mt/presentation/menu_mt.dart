import 'package:flutter/material.dart';
import 'package:hero/model/enumapp.dart';
import 'package:hero/module_mt/presentation/back_checking/homepage_back_checking.dart';
import 'package:hero/module_mt/presentation/history_outlet/enum_history.dart';
import 'package:hero/module_mt/presentation/tandem_selling/homepage/homepage_tandem_selling.dart';
import 'package:hero/util/component/image/component_image_new.dart';
import 'package:hero/util/component/widget/component_widget.dart';
import 'package:hero/util/uiutil.dart';

import 'history_outlet/hp_history.dart';

class MenuMt extends StatefulWidget {
  static const routeName = '/menumt';

  const MenuMt({Key? key}) : super(key: key);

  @override
  _MenuMtState createState() => _MenuMtState();
}

class _MenuMtState extends State<MenuMt> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMT(
      title: 'Menu',
      body: _menuPage(),
    );
  }

  Widget _menuPage() {
    Size size = MediaQuery.of(context).size;
    return Container(
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
                image: AssetImage('assets/image/new/big_logo.png'), height: 90),
            const SizedBox(
              height: 20,
            ),
            _openDsPoi(),
          ],
        ),
      ),
    );
  }

  Widget _openDsPoi() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ClockInImageIcon(
              onTap: () {
                _tapMenu(EnumMenuMT.tandemSelling);
              },
              image: 'assets/image/mt/ic_tandem_menu.png',
              disableImage: 'assets/image/mt/ic_tandem_menu.png',
              completeImage: 'assets/image/mt/ic_tandem_menu.png',
              enable: EnumBtnMenuState.enable,
            ),
            ClockInImageIcon(
              onTap: () {
                _tapMenu(EnumMenuMT.backChecking);
              },
              image: 'assets/image/mt/ic_back_chek_menu.png',
              disableImage: 'assets/image/mt/ic_back_chek_menu.png',
              completeImage: 'assets/image/mt/ic_back_chek_menu.png',
              enable: EnumBtnMenuState.enable,
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ClockInImageIcon(
              onTap: () {
                _tapMenu(EnumMenuMT.historyOutlet);
              },
              image: 'assets/image/mt/ic_history_outlet.png',
              disableImage: 'assets/image/mt/ic_history_outlet.png',
              completeImage: 'assets/image/mt/ic_history_outlet.png',
              enable: EnumBtnMenuState.enable,
            ),
            ClockInImageIcon(
              onTap: () {
                _tapMenu(EnumMenuMT.historySales);
              },
              image: 'assets/image/mt/ic_history_sales.png',
              disableImage: 'assets/image/mt/ic_history_sales.png',
              completeImage: 'assets/image/mt/ic_history_sales.png',
              enable: EnumBtnMenuState.enable,
            ),
          ],
        ),
      ],
    );
  }

  void _tapMenu(EnumMenuMT enumTab) {
    switch (enumTab) {
      case EnumMenuMT.backChecking:
        CommonUi().openPage(context, const HPBackChecking());
        break;
      case EnumMenuMT.tandemSelling:
        CommonUi().openPage(context, const HomePageTandemSelling());
        break;
      case EnumMenuMT.historyOutlet:
        CommonUi().openPage(context, const HistorySearchPage(EHistory.outlet));
        break;
      case EnumMenuMT.historySales:
        CommonUi().openPage(context, const HistorySearchPage(EHistory.sales));
        break;
    }
  }
}
