import 'package:flutter/material.dart';
import 'package:hero/http/coverage/pjp/httppjp.dart';
import 'package:hero/model/enumapp.dart';
import 'package:hero/model/pjp.dart';
import 'package:hero/model/tempat.dart';
import 'package:hero/util/component/component_label.dart';
import 'package:hero/util/component/component_widget.dart';
import 'package:hero/util/constapp/accountcontroller.dart';
import 'package:hero/util/constapp/constapp.dart';
import 'package:hero/util/dateutil.dart';

import 'blocsearchlocation.dart';

class HistoryPJP extends StatefulWidget {
  // static const String routeName = '/historypjp';
  final LokasiSimple lokasi;
  HistoryPJP(this.lokasi);
  @override
  _HistoryPJPState createState() => _HistoryPJPState();
}

class _HistoryPJPState extends State<HistoryPJP> {
  List<Pjp>? _lpjp;
  int _page = 0;
  int? _totalrecord = 0;
  String _keyLok = '';
  HttpPjp _httpPjp = new HttpPjp();
  EnumAccount? _enumAccount;

  @override
  void initState() {
    _page = 1;
    _lpjp = [];

    super.initState();
    _setupdata();
  }

  List<Pjp> _dummylistpjp() {
    List<Pjp> lp = [];
    for (int i = 0; i < 50; i++) {
      int id = i + 2;
      Pjp p = Pjp(DateTime.now(), DateTime.now(), Tempat('$id', 'item ke $i'),
          EnumStatusTempat.open);
      p.status = 'OPEN';
      lp.add(p);
    }
    return lp;
  }

  void _setupdata() {
    _setupHttp().then((value) {
      setState(() {});
    });
  }

  int _countList() {
    if (isShowmoreVisible()) {
      return _lpjp!.length + 1;
    }
    return _lpjp!.length;
  }

  bool isShowmoreVisible() {
    if (_lpjp == null) {
      return false;
    }

    if (_lpjp!.length < _totalrecord!) {
      return true;
    }

    return false;
  }

  void _showMore() {
    _page++;
    // _httpPjp.getHistoryPJP(_keyLok, widget.lokasi.idutama, _page).then((value) {
    //   if(value!=null){
    //     _lpjp.addAll(value);
    //     setState(() {
    //
    //     });
    //   }
    // });

    /// test only
    _lpjp!.addAll(_dummylistpjp());
    setState(() {});
  }

  Future<bool> _setupHttp() async {
    _keyLok = ConstApp.keyOutlet;
    switch (widget.lokasi.enumJenisLokasi) {
      case EnumJenisLokasi.outlet:
        _keyLok = ConstApp.keyOutlet;
        break;
      case EnumJenisLokasi.poi:
        _keyLok = ConstApp.keyPOI;
        break;
      case EnumJenisLokasi.sekolah:
        _keyLok = ConstApp.keySekolah;
        break;
      case EnumJenisLokasi.kampus:
        _keyLok = ConstApp.keyKampus;
        break;
      case EnumJenisLokasi.fakultas:
        _keyLok = ConstApp.keyFakultas;
        break;
      default:
    }
    _totalrecord =
        await _httpPjp.getJmlHistoryPjp(widget.lokasi.idutama, _keyLok);

    List<Pjp>? lp =
        await _httpPjp.getHistoryPJP(_keyLok, widget.lokasi.idutama, _page);
    if (lp != null) {
      _lpjp = lp;
    }

    _enumAccount = await AccountHore.getAccount();

    /// test only
    _totalrecord = 100;
    _lpjp = _dummylistpjp();
    return true;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_enumAccount == null) {
      return CustomScaffold(body: Container(), title: '');
    }
    Size s = MediaQuery.of(context).size;
    return CustomScaffold(
        body: Container(
          height: s.height,
          width: s.width,
          child: Padding(
            padding: const EdgeInsets.only(left: 12.0, top: 12, right: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: LabelBlack.size1(widget.lokasi.text),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(),
                      LabelBlack.size1(
                        '$_totalrecord',
                        bold: true,
                      ),
                    ],
                  ),
                ),
                // SizedBox(
                //   height: 6,
                // ),
                _content(_lpjp, s),
              ],
            ),
          ),
        ),
        title: 'History PJP');
  }

  Widget _content(List<Pjp>? lpjp, Size s) {
    return SizedBox(
      width: s.width,
      height: s.height - 165,
      child: ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: _countList(),
        itemBuilder: (BuildContext context, int index) {
          return _controllCell(lpjp, index);
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
    );
  }

  Widget _controllCell(List<Pjp>? lpjp, int index) {
    int tmp = _countList() - 1;
    if (tmp == index) {
      if (isShowmoreVisible()) {
        return _btnShowMore();
      }
    }
    Pjp pjp = lpjp![index];
    return _cellPjp(pjp);
  }

  Widget _cellPjp(Pjp pjp) {
    String status = '';
    pjp.enumStatusTempat == EnumStatusTempat.close
        ? status = 'Close'
        : status = 'Open';
    int durasi = 0;
    if (pjp.clockout != null && pjp.clockin != null) {
      Duration difference = pjp.clockout!.difference(pjp.clockin!);
      durasi = difference.inMinutes;
    }

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _rowCell('Tanggal', DateUtility.dateToStringPanjang(pjp.clockin)),
          _rowCell('Clock In', DateUtility.dateToStringjam(pjp.clockin)),
          _rowCell('Clock Out', DateUtility.dateToStringjam(pjp.clockout)),
          _rowCell('Durasi', '$durasi menit'),
          _rowCell('Status', status)
        ],
      ),
    );
  }

  Widget _rowCell(String nama, String ket) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        children: [
          SizedBox(width: 100, child: LabelBlack.size2(nama)),
          LabelBlack.size2(': '),
          LabelBlack.size2(ket),
        ],
      ),
    );
  }

  Widget _btnShowMore() {
    return RaisedButton(
        child: Text('show more'),
        color: Colors.green,
        onPressed: () {
          this._showMore();
        });
  }
}
