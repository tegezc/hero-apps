import 'package:flutter/material.dart';
import 'package:hero/module_mt/domain/entity/common/outlet_mt.dart';
import 'package:hero/module_mt/presentation/common/check_longlat/check_long_lat.dart';
import 'package:hero/module_mt/presentation/tandem_selling/detail_outlet/widget_info_outlet.dart';
import 'package:hero/module_mt/presentation/tandem_selling/penilaian_outlet/parent_tab/parent_tab.dart';
import 'package:hero/module_mt/presentation/tandem_selling/voice_of_reseller/hp_voice_of_retailer.dart';
import 'package:hero/util/component/button/component_button.dart';
import 'package:hero/util/component/widget/component_widget.dart';
import 'package:hero/util/uiutil.dart';

class DetailOutlet extends StatefulWidget {
  final OutletMT outletMT;
  final String tap;
  final String cluster;
  const DetailOutlet(
      {Key? key,
      required this.outletMT,
      required this.cluster,
      required this.tap})
      : super(key: key);

  @override
  _DetailOutletState createState() => _DetailOutletState();
}

class _DetailOutletState extends State<DetailOutlet> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldMT(
        body: SingleChildScrollView(
            child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: InfoOutlet(
                  outletMT: widget.outletMT,
                  cluster: widget.cluster,
                  tap: widget.tap),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ButtonStrectWidth(
                  buttonColor: Colors.green,
                  text: 'Check Long Lat',
                  onTap: () {
                    CommonUi().openPage(context, CheckLongLat(widget.outletMT));
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
                          outletMT: widget.outletMT,
                        ));
                  },
                  isenable: true),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ButtonStrectWidth(
                  buttonColor: Colors.green,
                  text: 'Voice of Retailer',
                  onTap: () {
                    CommonUi().openPage(
                        context,
                        HPVoiceOfRetailer(
                          outletMT: widget.outletMT,
                        ));
                  },
                  isenable: true),
            ),
          ],
        )),
        title: 'Cell Bintang');
  }
}
