import 'package:flutter/material.dart';
import 'package:hero/module_mt/domain/entity/common/outlet_mt.dart';
import 'package:hero/module_mt/presentation/common/check_longlat/check_long_lat.dart';
import 'package:hero/module_mt/presentation/common/e_kegiatan_mt.dart';
import 'package:hero/module_mt/presentation/common/penilaian_outlet/state_parent/page_state_penilaian.dart';
import 'package:hero/module_mt/presentation/common/voice_of_reseller/hp_voice_of_retailer.dart';
import 'package:hero/util/component/button/component_button.dart';
import 'package:hero/util/component/widget/component_widget.dart';
import 'package:hero/util/uiutil.dart';

import 'widget_info_outlet.dart';

class DetailOutlet extends StatefulWidget {
  final OutletMT outletMT;
  final String? tap;
  final String? cluster;
  final EKegitatanMt eKegitatanMt;
  const DetailOutlet(
      {Key? key,
      required this.outletMT,
      required this.cluster,
      required this.tap,
      required this.eKegitatanMt})
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
              padding: const EdgeInsets.all(8.0),
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
                        ParentStatePenilaian(
                            outletMT: widget.outletMT,
                            eKegiatanMt: widget.eKegitatanMt));
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
                          eKegitatanMt: widget.eKegitatanMt,
                        ));
                  },
                  isenable: true),
            ),
          ],
        )),
        title: 'Detail Outlet');
  }
}