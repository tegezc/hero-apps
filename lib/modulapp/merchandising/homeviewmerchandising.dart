import 'package:flutter/material.dart';
import 'package:hero/http/coverage/httpmerch.dart';
import 'package:hero/model/enumapp.dart';
import 'package:hero/model/merchandising/merchandising.dart';
import 'package:hero/model/sf/itemsearchoutlet.dart';
import 'package:hero/modulapp/merchandising/viewmerchandisingitem.dart';
import 'package:hero/util/component/label/component_label.dart';
import 'package:hero/util/component/widget/component_widget.dart';
import 'package:hero/util/constapp/consstring.dart';

class HomeViewMerchandising extends StatefulWidget {
  final LokasiSearch itemOutlet;
  const HomeViewMerchandising(this.itemOutlet, {Key? key}) : super(key: key);
  @override
  _HomeViewMerchandisingState createState() => _HomeViewMerchandisingState();
}

class _HomeViewMerchandisingState extends State<HomeViewMerchandising> {
  Merchandising? _perdana;
  Merchandising? _voucherFisik;
  Merchandising? _mspanduk;
  Merchandising? _mposter;
  Merchandising? _mpapan;
  Merchandising? _stikerScanQR;

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
    HttpMerchandising httpm = HttpMerchandising();
    Map<String, Merchandising>? map = await httpm.getDetailMerch(
        widget.itemOutlet.idoutlet,
        widget.itemOutlet.tgl,
        widget.itemOutlet.getJenisLokasi());
    if (map != null) {
      _perdana = map[Merchandising.tagPerdana];
      _voucherFisik = map[Merchandising.tagVoucherFisik];
      _mspanduk = map[Merchandising.tagSpanduk];
      _mposter = map[Merchandising.tagPoster];
      _mpapan = map[Merchandising.tagPapan];
      _stikerScanQR = map[Merchandising.tagStikerScanQR];
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
      length: 6,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              isScrollable: true,
              tabs: [
                Tab(
                  child: LabelBlack.size2('Perdana'),
                ),
                Tab(
                  child: LabelBlack.size2('Voucher Fisik'),
                ),
                Tab(
                  child: LabelBlack.size2('Spanduk'),
                ),
                Tab(
                  child: LabelBlack.size2('Poster'),
                ),
                Tab(
                  child: LabelBlack.size2('Papan Nama Toko'),
                ),
                Tab(
                  child: LabelBlack.size2('Stiker Scan QR'),
                ),
              ],
            ),
            backgroundColor: Colors.white,
            iconTheme: const IconThemeData(
              color: Colors.black, //change your color here
            ),
            title: Text(
              ConstString.textMerchandising,
              style: const TextStyle(color: Colors.black),
            ),
            centerTitle: true,
          ),
          body: TabBarView(
            children: [
              ViewMerchandising(EnumMerchandising.perdana, _perdana),
              ViewMerchandising(EnumMerchandising.voucherfisik, _voucherFisik),
              ViewMerchandising(EnumMerchandising.spanduk, _mspanduk),
              ViewMerchandising(EnumMerchandising.poster, _mposter),
              ViewMerchandising(EnumMerchandising.papan, _mpapan),
              ViewMerchandising(EnumMerchandising.stikerScanQR, _stikerScanQR),
            ],
          ),
        ),
      ),
    );
  }
}
