import 'package:flutter/material.dart';
import 'package:hero/http/coverage/marketaudit/httpmarketauditds.dart';
import 'package:hero/model/marketaudit/quisioner.dart';
import 'package:hero/model/sf/itemsearchoutlet.dart';
import 'package:hero/modulapp/camera/loadingview.dart';
import 'package:hero/util/component/label/component_label.dart';
import 'package:hero/util/component/widget/component_widget.dart';
import 'package:hero/util/numberconverter.dart';

class MarketAuditDsView extends StatefulWidget {
  static const routeName = '/dsmarketauditview';
  final LokasiSearch lokasiSearch;
  const MarketAuditDsView({Key? key, required this.lokasiSearch})
      : super(key: key);

  @override
  _MarketAuditDsViewState createState() => _MarketAuditDsViewState();
}

class _MarketAuditDsViewState extends State<MarketAuditDsView> {
  int _counterBuild = 0;

  bool _isloading = true;
  late LokasiSearch _lokasiSearch;
  Quisioner? q;

  @override
  void initState() {
    _lokasiSearch = widget.lokasiSearch;
    super.initState();
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
    // ph('${_lokasiSearch.idoutlet} || '
    //     '${_lokasiSearch.tgl} || '
    //     '${_lokasiSearch.idjnslokasi} || '
    //     '${_lokasiSearch.namapembeli} || '
    //     '${_lokasiSearch.nohppembeli}');
    HttpMarketAuditDs httpMarketAuditDs = HttpMarketAuditDs();
    q = await httpMarketAuditDs.getDetailQuisioner(
        jenislokasi: _lokasiSearch.idjnslokasi!,
        idloksi: _lokasiSearch.idoutlet!,
        tgl: _lokasiSearch.tgl!);
    // ph(q?.toJson());
    if (q != null) {
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
    if (_counterBuild == 0) {
      _setup();
      _counterBuild++;
    }

    if (_isloading) {
      return const LoadingNunggu("Mohon tunggu\nSedang loading data.");
    }

    if (q == null) {
      return const CustomScaffold(
        title: 'Market Audit',
        body: Center(
          child: LabelBlack.size1("Terjadi Kesalahan"),
        ),
      );
    }

    return CustomScaffold(
      title: 'Market Audit',
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              _spasi(),
              _labelKetValue("Nama Pelanggan ", q!.namaPelanggan!),
              _spasi(),
              _cardOperator(
                  label: "Operator Internet",
                  operator: q!.opTelp,
                  msisdn: q!.msisdnTelp),
              _spasi(),
              _cardOperator(
                  label: "Operator Internet",
                  operator: q!.opInternet,
                  msisdn: q!.msisdnInternet),
              _spasi(),
              _cardOperator(
                  label: "Operator Digital (Game dan Video)",
                  operator: q!.opDigital,
                  msisdn: q!.msisdnDigital),
              _spasi(),
              _labelAtasBawah("Frekuensi membeli paket ", q!.frekBeliPaket),
              _spasi(),
              _labelAtasBawah(
                  "Kebutuhan quota 1 bulan ", '${q!.kuotaPerBulan} GB'),
              _spasi(),
              _labelAtasBawah("Berapa Rupiah kebutuhan Pulsa 1 bulan ",
                  'Rp ${ConverterNumber.getCurrentcyOrNol(q!.pulsaPerbulan)},-'),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _cardOperator(
      {required String label,
      required String? operator,
      required String? msisdn}) {
    String textOp = "";
    String textMsisdn = "";
    if (operator != null) {
      textOp = operator;
    }
    if (msisdn != null) {
      textMsisdn = msisdn;
    }
    return Card(
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: LabelApp.size1(label),
          ),
          const Divider(),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: LabelApp.size2(textOp),
              ),
              const SizedBox(
                width: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: LabelBlack.size2(textMsisdn),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _labelKetValue(String ket, String? value) {
    String textvalue = "";
    if (value != null) {
      textvalue = value;
    }
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            LabelApp.size2(ket),
            const SizedBox(
              width: 30,
              child: LabelBlack.size2(":"),
            ),
            LabelApp.size2(textvalue),
          ],
        ),
      ),
    );
  }

  Widget _labelAtasBawah(String ket, String? value) {
    String textvalue = "";
    if (value != null) {
      textvalue = value;
    }
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LabelApp.size2(ket),
            const Divider(),
            LabelApp.size2(
              textvalue,
              bold: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _spasi() {
    return const SizedBox(
      height: 16,
    );
  }
}
