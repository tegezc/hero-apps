import 'package:flutter/material.dart';
import 'package:hero/model/enumapp.dart';
import 'package:hero/util/component/image/component_image_new.dart';
import 'package:hero/util/component/widget/component_widget.dart';

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
    Size size = MediaQuery.of(context).size;
    return ScaffoldMT(
      title: 'Menu',
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
              _openDsPoi(),
            ],
          ),
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
                _tapMenu(EnumTab.distribution);
              },
              image: 'assets/image/icon/clockin/enable/ic_en_distribution.png',
              disableImage:
                  'assets/image/icon/clockin/disable/ic_ds_distribution.png',
              completeImage:
                  'assets/image/icon/clockin/complete/ic_ck_distribution.png',
              enable: EnumBtnMenuState.enable,
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
              enable: EnumBtnMenuState.enable,
            ),
          ],
        ),
      ],
    );
  }

  void _tapMenu(EnumTab enumTab) {}
}
