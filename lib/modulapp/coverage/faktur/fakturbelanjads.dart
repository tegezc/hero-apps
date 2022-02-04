import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hero/http/coverage/httpdistibusi.dart';
import 'package:hero/model/distribusi/datapembeli.dart';
import 'package:hero/model/distribusi/nota.dart';
import 'package:hero/model/profile.dart';
import 'package:hero/util/component/button/component_button.dart';
import 'package:hero/util/component/label/component_label.dart';
import 'package:hero/util/component/widget/component_widget.dart';
import 'package:hero/util/constapp/accountcontroller.dart';
import 'package:hero/util/constapp/consstring.dart';
import 'package:hero/util/numberconverter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';

class FakturPembayaranDs extends StatefulWidget {
  final String? nonota;
  final bool isHideShare;
  FakturPembayaranDs(this.nonota, this.isHideShare);
  @override
  _FakturPembayaranDsState createState() => _FakturPembayaranDsState();
}

class _FakturPembayaranDsState extends State<FakturPembayaranDs> {
  DetailNota? _nota;
  late Profile _profile;
  Uint8List? _imageFile;

  //Create an instance of ScreenshotController
  ScreenshotController screenshotController = ScreenshotController();
  @override
  void initState() {
    super.initState();
    _firsttime();
  }

  void _firsttime() {
    _setup().then((value) {
      if (value) {
        setState(() {});
      }
    });
  }

  Future<bool> _setup() async {
    await Future.delayed(const Duration(milliseconds: 500), () {});
    _profile = await AccountHore.getProfile();
    HttpDIstribution httpDIstribution = HttpDIstribution();
    _nota = await httpDIstribution.getDetailNota(widget.nonota);

    return true;
  }

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    if (_nota == null) {
      return CustomScaffold(
        body: Container(),
        title: 'Loading...',
      );
    }
    return Screenshot(
      controller: screenshotController,
      child: CustomScaffold(
        automaticallyImplyLeading: true,
        body: SizedBox(
          height: s.height,
          width: s.width,
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 12,
                  ),
                  _title(),
                  const SizedBox(
                    height: 18,
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20),
                    child: _resumePembeli(),
                  ),
                  const Divider(),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, left: 12.0, right: 12.0),
                    child: _contentTransaksi(_nota!.ltrax),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, left: 12.0, right: 12.0),
                    child: _cellTopUpLink(),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 40, left: 12.0, right: 12.0),
                    child: _cellTotal(),
                  ),
                  widget.isHideShare
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.only(
                              top: 40, left: 12.0, right: 12.0),
                          child: _buttonShare(),
                        ),
                  SizedBox(
                    height: 100,
                  )
                ],
              ),
            ),
          ),
        ),
        title: ConstString.textDistribusi,
      ),
    );
  }

  Widget _spasi() {
    return const SizedBox(
      height: 4,
    );
  }

  Widget _title() {
    return Column(
      children: [
        LabelBlack.size2(_nota!.mitra),
        _spasi(),
        const LabelBlack.size2('NOTA PEMBAYARAN'),
        _spasi(),
        LabelBlack.size2(_profile.id),
      ],
    );
  }

  Widget _resumePembeli() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _rowResume('Nama Petugas', '${_nota!.namasales}'),
        _spasi(),
        _rowResume('Tanggal', '${_nota!.tgl}'),
        _spasi(),
        _rowResume('Lokasi', '${_nota!.namapembeli}'),
        _spasi(),
        _rowResume('Nama Pembeli', ''),
        _spasi(),
        _rowResume('Telp Pembeli', '${_nota!.nohppembeli}'),
        _spasi(),
        _rowResume('STATUS', 'LUNAS'),
      ],
    );
  }

  Widget _rowResume(String nama, String ket) {
    return Row(
      children: [
        SizedBox(width: 130, child: LabelBlack.size2(nama)),
        LabelBlack.size2(ket),
      ],
    );
  }

  Widget _contentTransaksi(List<ItemTransaksi>? ltrx) {
    List<Widget> lw = [];
    if (ltrx != null) {
      for (var element in ltrx) {
        lw.add(_cellTransaksi(element.product!.nama,
            element.product!.hargajual!, element.jumlah!));
      }
    }

    return Column(
      children: lw,
    );
  }

  Widget _cellTransaksi(String? nama, int harga, int jumlah) {
    int total = harga * jumlah;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            LabelBlack.size2(nama),
          ],
        ),
        _spasi(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            LabelBlack.size3('$harga x $jumlah'),
            LabelBlack.size2('Rp $total'),
          ],
        ),
        const SizedBox(
          height: 30,
        )
      ],
    );
  }

  Widget _cellTopUpLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const LabelBlack.size2('Top Up Link Aja (L)'),
        LabelBlack.size2('Rp ${ConverterNumber.getCurrentcy(_nota!.linkaja)}'),
      ],
    );
  }

  Widget _cellTotal() {
    int total = 0;
    for (var element in _nota!.ltrax!) {
      total = total + (element.jumlah! * element.product!.hargajual!);
    }

    int link = _nota!.linkaja == null ? 0 : _nota!.linkaja!;
    total = total + link;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        LabelBlack.size2('Total'),
        LabelBlack.size2('Rp ${ConverterNumber.getCurrentcy(total)}'),
      ],
    );
  }

  Widget _buttonShare() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(),
        ButtonApp.blue('Share', () async {
          _takeScreenshotandShare();
        }),
      ],
    );
  }

  _takeScreenshotandShare() async {
    _imageFile = null;
    screenshotController
        .capture(delay: const Duration(milliseconds: 10))
        .then((Uint8List? image) async {
      _imageFile = image;
      final tempDir = await getTemporaryDirectory();
      final file = await File('${tempDir.path}/screenshot.png').create();
      await file.writeAsBytes(_imageFile!);
      _onShare(context, '${tempDir.path}/screenshot.png', 'Faktur');
      showDialog(
        context: context,
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: const Text("CAPURED SCREENSHOT"),
          ),
          body: Center(
              child: Column(
            children: [
              _imageFile != null ? Image.memory(_imageFile!) : Container(),
            ],
          )),
        ),
      );
    }).catchError((onError) {});
  }

  _onShare(BuildContext context, String pathimage, String text) async {
    // A builder is used to retrieve the context immediately
    // surrounding the ElevatedButton.
    //
    // The context's `findRenderObject` returns the first
    // RenderObject in its descendent tree when it's not
    // a RenderObjectWidget. The ElevatedButton's RenderObject
    // has its position and size after it's built.
    final RenderBox box = context.findRenderObject() as RenderBox;
    List<String> imagePaths = [pathimage];

    await Share.shareFiles(imagePaths,
        text: text,
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }
}
