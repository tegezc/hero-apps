import 'package:flutter/material.dart';
import 'package:hero/http/coverage/httpdistibusi.dart';
import 'package:hero/model/distribusi/nota.dart';
import 'package:hero/model/distribusi/rekomendasi.dart';
import 'package:hero/model/pjp.dart';
import 'package:hero/modulapp/camera/pagetakephoto.dart';
import 'package:hero/modulapp/coverage/distribution/daftarproductdistribusi.dart';
import 'package:hero/modulapp/coverage/faktur/fakturbelanja.dart';
import 'package:hero/modulapp/coverage/faktur/fakturbelanjads.dart';

import 'package:hero/util/component/button/component_button.dart';
import 'package:hero/util/component/label/component_label.dart';
import 'package:hero/util/component/widget/component_widget.dart';
import 'package:hero/util/constapp/accountcontroller.dart';

class HomePembelianDistribusi extends StatefulWidget {
  static const String routeName = '/homepembeliandistribusi';
  final Pjp? pjp;

  const HomePembelianDistribusi(this.pjp, {Key? key}) : super(key: key);

  @override
  _HomePembelianDistribusiState createState() =>
      _HomePembelianDistribusiState();
}

class _HomePembelianDistribusiState extends State<HomePembelianDistribusi> {
  final TextEditingController _controller = TextEditingController();
  List<ItemRekomendasi>? _lsegel;
  List<ItemRekomendasi>? _lsa;
  List<ItemRekomendasi>? _lvoint;
  List<ItemRekomendasi>? _lvog;
  List<Nota>? _lnota;
  late HttpDIstribution _httpDIstribution;
  late bool _isrekomendasishowing;
  late bool _isloading;
  EnumAccount? _enumAccount;

  int _countBuild = 0;

  @override
  void initState() {
    _isloading = true;
    _httpDIstribution = HttpDIstribution();
    _isrekomendasishowing = false;
    _lsegel = [];
    _lsa = [];
    _lvoint = [];
    _lvog = [];
    // _lnota = [];
    super.initState();
  }

  void _setup() {
    _setupFirstime().then((value) {
      setState(() {
        _isloading = false;
      });
    });
  }

  Future<bool> _setupFirstime() async {
    _enumAccount = await AccountHore.getAccount();
    _lnota = await _httpDIstribution.getDaftarNota(widget.pjp!);
    if (_enumAccount == EnumAccount.sf) {
      _isrekomendasishowing = true;

      Rekomendasi? rekomendasi =
          await _httpDIstribution.getRekomendasi(widget.pjp!);
      if (rekomendasi != null) {
        _lsegel = rekomendasi.lsegel;
        _lsa = rekomendasi.lsa;
        _lvoint = rekomendasi.lvointernet;
        _lvog = rekomendasi.lvogames;
      }
    }
    return true;
  }

  Future<bool> _reloadNota() async {
    // if (_enumAccount == EnumAccount.sf) {
    _lnota = await _httpDIstribution.getDaftarNota(widget.pjp!);
    //  }
    return true;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_countBuild == 0) {
      _setup();
      _countBuild++;
    }
    if (_isloading) {
      return CustomScaffold(
        title: 'Loading...',
        body: Container(),
      );
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[600],
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: Row(
          children: [
            const Text(
              'Distribusi',
              style: TextStyle(color: Colors.white),
            ),
            const Spacer(),
            ButtonClockIn(
                borderColor: Colors.black,
                text: '+Entry',
                onTap: () async {
                  await Navigator.pushNamed(
                      context, DaftarProductDistribusi.routeName,
                      arguments: widget.pjp);
                  _reloadNota().then((value) {
                    setState(() {});
                  });
                }),
          ],
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ButtonStrectWidth(
                buttonColor: Colors.green,
                text: 'Ambil Foto',
                onTap: () {
                  _showDialogConfirmClockOut();
                },
                isenable: _lnota == null ? false : _lnota!.isNotEmpty,
              ),
            ),
            _contentStruk(_lnota),
            const Divider(),
            const SizedBox(
              height: 12,
            ),
            _enumAccount == EnumAccount.sf
                ? const Center(
                    child: LabelApp.size1(
                      'History Order',
                      bold: true,
                    ),
                  )
                : Container(),
            _dataTable(_lsegel!, 'SEGEL'),
            _dataTable(_lsa!, 'SA'),
            _dataTable(_lvoint!, 'VO Internet'),
            _dataTable(_lvog!, 'VO Games'),
            const SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }

  Widget _contentStruk(List<Nota>? lnota) {
    List<Widget> lw = [];
    lw.add(const Padding(
      padding: EdgeInsets.all(8.0),
      child: LabelWhite.size2('Daftar Nota'),
    ));

    if (lnota != null) {
      for (int i = 0; i < lnota.length; i++) {
        Nota nota = lnota[i];
        lw.add(_cellFaktur(nota));
      }
    }

    return Container(
        width: double.infinity,
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(3.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.red),
          borderRadius: BorderRadius.circular(4),
          color: lnota != null ? Colors.red[600] : Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: lw,
        ));
  }

  Widget _cellFaktur(Nota nota) {
    String ket;
    if (nota.pembayaran == 'LUNAS') {
      ket = 'Lunas';
    } else {
      ket = 'Konsinyasi';
    }

    return GestureDetector(
      onTap: () {
        AccountHore.getAccount().then((value) {
          if (value == EnumAccount.sf) {
            // CommonUi.openPage(
            //     context, FakturPembayaran(nota.noNota, false));
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        FakturPembayaran(nota.noNota, false)));
          } else {
            // CommonUi.openPage(
            //     context, FakturPembayaranDs(nota.noNota, false));
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        FakturPembayaranDs(nota.noNota, false)));
          }
        });
      },
      child: Column(
        children: [
          const Divider(color: Colors.white60),
          Padding(
            padding: const EdgeInsets.only(
                left: 8.0, right: 8.0, top: 2.0, bottom: 2.0),
            child: ListTile(
              leading: nota.isShared
                  ? const Icon(
                      Icons.check_circle_outline,
                      color: Colors.white,
                    )
                  : const SizedBox(
                      height: 24,
                      width: 24,
                    ),
              title: LabelWhite.size2('${nota.noNota} / $ket'),
              trailing:
                  const Icon(Icons.keyboard_arrow_right, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  _showDialogConfirmClockOut() {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => SimpleDialog(
              title: const Text('Confirm'),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      right: 16.0, left: 16.0, bottom: 8.0),
                  child: LabelBlack.size2(
                      'Setelah mengambil foto, anda tidak bisa melakukan transaksi '
                      'penjualan kembali. Apakah Anda yakin akan mengambil foto ?'),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      right: 16.0, left: 16.0, bottom: 3.0),
                  child: ButtonApp.black('Ya', () async {
                    ParamPreviewPhoto params = ParamPreviewPhoto(
                      EnumTakePhoto.distribusi,
                      pathPhoto: null,
                    );
                    // CommonUi.openPage(context, CameraView(params));
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CameraView(params)));
                    //  Navigator.of(context).pop();
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

  Widget _dataTable(List<ItemRekomendasi> lrek, String title) {
    List<DataRow> ldr = [];
    for (var element in lrek) {
      ldr.add(DataRow(
        cells: <DataCell>[
          DataCell(Text(element.nama!)),
          DataCell(Text(element.w1)),
          DataCell(Text(element.w2)),
          DataCell(Text(element.w3)),
          DataCell(Text(element.w4)),
          DataCell(Text('${element.rkmd}')),
        ],
      ));
    }
    if (!_isrekomendasishowing) {
      return Container();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: LabelApp.size1(
            title,
            bold: true,
          ),
        ),
        Card(
          child: FractionallySizedBox(
            widthFactor: 0.95,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const <DataColumn>[
                  DataColumn(
                    label: Text(
                      'Produk',
                      style: TextStyle(),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'W1',
                      style: TextStyle(),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'W2',
                      style: TextStyle(),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'W3',
                      style: TextStyle(),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'W4',
                      style: TextStyle(),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Rekomendasi',
                      style: TextStyle(),
                    ),
                  ),
                ],
                rows: ldr,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
