import 'package:flutter/material.dart';
import 'package:hero/core/domain/entities/tgzlocation.dart';
import 'package:hero/module_mt/domain/entity/outlet_mt.dart';
import 'package:hero/module_mt/presentation/common/check_longlat/check_long_lat.dart';
import 'package:hero/module_mt/presentation/tandem_selling/detail_outlet/widget_info_outlet.dart';
import 'package:hero/module_mt/presentation/tandem_selling/penilaian_outlet/parent_tab/parent_tab.dart';
import 'package:hero/util/component/button/component_button.dart';
import 'package:hero/util/component/widget/component_widget.dart';
import 'package:hero/util/uiutil.dart';

class DetailOutlet extends StatefulWidget {
  const DetailOutlet({Key? key}) : super(key: key);

  @override
  _DetailOutletState createState() => _DetailOutletState();
}

class _DetailOutletState extends State<DetailOutlet> {
  OutletMT _outletMt = OutletMT(
      idDigipos: "23",
      idOutlet: "72",
      location: TgzLocationData(latitude: -5.404024, longitude: 105.280614),
      namaOutlet: "9999",
      radiusClockIn: 100);
  @override
  Widget build(BuildContext context) {
    return ScaffoldMT(
        body: SingleChildScrollView(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InfoOutlet(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ButtonStrectWidth(
                  buttonColor: Colors.green,
                  text: 'Check Long Lat',
                  onTap: () {
                    CommonUi().openPage(context, CheckLongLat(_outletMt));
                  },
                  isenable: true),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ButtonStrectWidth(
                  buttonColor: Colors.green,
                  text: 'Penilain Outlet',
                  onTap: () {
                    CommonUi().openPage(
                        context,
                        ParentTabNilaiOutlet(
                          outletMT: _outletMt,
                        ));
                  },
                  isenable: true),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ButtonStrectWidth(
                  buttonColor: Colors.green,
                  text: 'Voice of Retailer',
                  onTap: () {},
                  isenable: true),
            ),
          ],
        )),
        title: 'Cell Bintang');
  }
}
