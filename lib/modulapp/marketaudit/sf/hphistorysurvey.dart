import 'package:flutter/material.dart';
import 'package:hero/http/coverage/marketaudit/httpmarketaudit.dart';
import 'package:hero/model/sf/itemsearchoutlet.dart';
import 'package:hero/modulapp/coverage/marketaudit/sf/blocsurvey.dart';
import 'package:hero/modulapp/marketaudit/sf/viewbelanjasurvey.dart';
import 'package:hero/util/component/label/component_label.dart';
import 'package:hero/util/component/widget/component_widget.dart';
import 'package:hero/util/constapp/consstring.dart';

import 'viewvouchersurvey.dart';

class HomeHistorySurvey extends StatefulWidget {
  static const routeName = '/homehistorysurvey';
  final LokasiSearch itemOutlet;

  const HomeHistorySurvey(this.itemOutlet, {Key? key}) : super(key: key);
  @override
  _HomeHistorySurveyState createState() => _HomeHistorySurveyState();
}

class _HomeHistorySurveyState extends State<HomeHistorySurvey> {
  UISurvey? _item;
  bool _isloading = true;
  @override
  void initState() {
    super.initState();
    _setup();
  }

  void _setup() {
    _loadDataInternet().then((value) {
      if (value) {
        setState(() {
          _isloading = false;
        });
      }
    });
  }

  Future<bool> _loadDataInternet() async {
    String? idtempat = widget.itemOutlet.idoutlet;
    DateTime? dt = widget.itemOutlet.tgl;
    HttpMarketAuditSF httpSurvey = HttpMarketAuditSF();
    _item = await httpSurvey.getDetailMarketAuditSF(
        EnumSurvey.belanja, idtempat, dt);
    UISurvey? uiSurvey = await httpSurvey.getDetailMarketAuditSF(
        EnumSurvey.broadband, idtempat, dt);
    _item!.lsurveyBroadband = uiSurvey!.lsurveyBroadband;
    uiSurvey =
        await httpSurvey.getDetailMarketAuditSF(EnumSurvey.fisik, idtempat, dt);
    _item!.lsurveyFisik = uiSurvey!.lsurveyFisik;
    if (_item != null) {
      return true;
    }
    return false;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isloading) {
      return CustomScaffold(
        title: 'Loading...',
        body: Container(),
      );
    }
    return DefaultTabController(
      length: 3,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              isScrollable: true,
              tabs: [
                // wallet share, sales broadband share, voucher fisik share
                Tab(
                  child: LabelBlack.size2('Belanja Share'),
                ),
                Tab(
                  child: LabelBlack.size2('Sales Broadband Share'),
                ),
                Tab(
                  child: LabelBlack.size2('Voucher Internet Share'),
                ),
              ],
            ),
            backgroundColor: Colors.white,
            iconTheme: const IconThemeData(
              color: Colors.black, //change your color here
            ),
            title: Text(
              ConstString.textSurvey,
              style: const TextStyle(color: Colors.black),
            ),
            centerTitle: true,
          ),
          body: TabBarView(
            children: [
              ViewBelanjaSurvey(_item),
              ViewVoucherSurvey(EnumSurvey.broadband, _item),
              ViewVoucherSurvey(EnumSurvey.fisik, _item),
            ],
          ),
        ),
      ),
    );
  }
}
