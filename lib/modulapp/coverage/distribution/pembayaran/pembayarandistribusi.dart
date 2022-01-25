import 'package:flutter/material.dart';
import 'package:hero/model/distribusi/datapembeli.dart';
import 'package:hero/model/pjp.dart';
import 'package:hero/modulapp/coverage/distribution/homepembeliandistribusi.dart';
import 'package:hero/modulapp/coverage/distribution/pembayaran/blocpembayaran.dart';
import 'package:hero/modulapp/coverage/pagesuccess.dart';
import 'package:hero/util/component/button/component_button.dart';
import 'package:hero/util/component/label/component_label.dart';
import 'package:hero/util/component/textfield/component_textfield.dart';
import 'package:hero/util/component/tgzdialog.dart';
import 'package:hero/util/component/widget/component_widget.dart';
import 'package:hero/util/constapp/accountcontroller.dart';
import 'package:hero/util/constapp/consstring.dart';
import 'package:hero/util/numberconverter.dart';

class PembayaranDistribusi extends StatefulWidget {
  static const routeName = '/pembayarandistribusi';
  final ParamPembayaran? paramPembayaran;

  PembayaranDistribusi(this.paramPembayaran);

  @override
  _PembayaranDistribusiState createState() => _PembayaranDistribusiState();
}

class _PembayaranDistribusiState extends State<PembayaranDistribusi> {
  // EnumCaraBayar _carabayar = EnumCaraBayar.lunas;

  TextEditingController _controller1 = new TextEditingController();
  TextEditingController _controller2 = new TextEditingController();
  late BlocPembayaran _blocPembayaran;
  int _counterBuild = 0;

  @override
  void initState() {
    _blocPembayaran = BlocPembayaran();
    super.initState();
  }

  @override
  void dispose() {
    _blocPembayaran.dispose();
    _controller1.dispose();
    _controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (_counterBuild == 0) {
      _blocPembayaran.firstime(
          widget.paramPembayaran!.ltrx, widget.paramPembayaran!.pjp!);
      _counterBuild++;
    }
    return StreamBuilder<UIPembayaran>(
        stream: _blocPembayaran.uipembayaran,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CustomScaffold(body: Container(), title: 'Pembayaran');
          }
          UIPembayaran item = snapshot.data!;
          return CustomScaffold(
            title: 'Pembayaran',
            body: Stack(
              children: [
                SizedBox(
                  width: size.width,
                  height: size.height,
                  child: SingleChildScrollView(
                    child: Center(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 12,
                          ),
                          _content(item),
                          const SizedBox(
                            height: 12,
                          ),
                          _perhitungan(item),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    color: Colors.white,
                    width: size.width - 2,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: ButtonStrectWidth(
                        text: 'BAYAR',
                        isenable: item.isvalid(),
                        buttonColor: Colors.red,
                        onTap: () {
                          bool isproses = true;
                          if (item.enumAccount == EnumAccount.ds) {
                            if (_controller2.text.trim().isEmpty) {
                              isproses = false;
                              _confirmNohpKosong();
                            }
                          }
                          if (isproses) {
                            TgzDialog.loadingDialog(context);
                            _blocPembayaran.bayar().then((value) {
                              Navigator.of(context).pop();
                              if (value) {
                                Navigator.pushNamed(
                                    context, PageSuccess.routeName,
                                    arguments: PageSuccessParam(
                                        HomePembelianDistribusi.routeName,
                                        ConstString.textDistribusi,
                                        'Transaksi Anda Berhasil',
                                        ''));
                              } else {
                                _confirmPembayaranGagal();
                              }
                            });
                          }
                        },
                      ),
                    ),
                    // RaisedButton(
                    //     color: Colors.green,
                    //     child: Text(
                    //       'BAYAR',
                    //       style: TextStyle(color: Colors.white),
                    //     ),
                    //     onPressed: item.isvalid()
                    //         ? () {
                    //             bool isproses = true;
                    //             if (item.enumAccount == EnumAccount.ds) {
                    //               if (_controller2.text.trim().length == 0) {
                    //                 isproses = false;
                    //                 _confirmNohpKosong();
                    //               }
                    //             }
                    //             if (isproses) {
                    //               TgzDialog.loadingDialog(context);
                    //               _blocPembayaran.bayar().then((value) {
                    //                 Navigator.of(context).pop();
                    //                 Navigator.pushNamed(
                    //                     context, PageSuccess.routeName,
                    //                     arguments: PageSuccessParam(
                    //                         HomePembelianDistribusi.routeName,
                    //                         ConstString.textDistribusi,
                    //                         'Transaksi Anda Berhasil',
                    //                         ''));
                    //               });
                    //             }
                    //           }
                    //         : null),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Widget _spasi() {
    return SizedBox(
      height: 4,
    );
  }

  Widget _content(UIPembayaran item) {
    List<Widget> lw = [];
    if (item.enumAccount == EnumAccount.sf) {
      lw.add(_infoPembeli(item.dataPembeli));
    } else {
      lw.add(_infoPembeliDs(item.dataPembeli));
    }

    for (int i = 0; i < item.lpembayaran!.length; i++) {
      ItemPembayaran trx = item.lpembayaran![i];
      if (item.enumAccount == EnumAccount.sf) {
        lw.add(_contentTransaksi(trx, i));
      } else {
        lw.add(_contentTransaksiDs(trx, i));
      }
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: lw,
    );
  }

  Widget _infoPembeli(DataPembeli dp) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              LabelBlack.size1('Data Pembeli'),
              SizedBox(
                height: 8,
              ),
              _cellInfoPembeli('NAMA PEMBELI', dp.namapembeli),
              SizedBox(
                height: 5,
              ),
              _cellInfoPembeli('NO HP PEMBELI', dp.nohppembeli),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoPembeliDs(DataPembeli dp) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              LabelBlack.size1('Data Pembeli'),
              SizedBox(
                height: 8,
              ),
              _cellInfoPembeli('NAMA PEMBELI', dp.namapembeli),
              SizedBox(
                height: 12,
              ),
              TextFieldNumberOnly(
                'NO HP PEMBELI',
                _controller2,
                onChanged: (str) {
                  _blocPembayaran.setNohpPembeli(str);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _contentTransaksi(ItemPembayaran item, int index) {
    Size size = MediaQuery.of(context).size;
    return Card(
      child: Container(
        width: size.width - 32,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  LabelBlack.size1(item.trx.product!.nama),
                  IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        _confirmDelete(index);
                      }),
                ],
              ),
              Divider(),
              _spasi(),
              Row(
                children: [
                  SizedBox(
                    width: 110,
                    child: LabelBlack.size2('Qty'),
                  ),
                  LabelBlack.size2(': '),
                  LabelBlack.size2('${item.trx.jumlah} pcs'),
                ],
              ),
              _spasi(),
              Row(
                children: [
                  SizedBox(
                    width: 110,
                    child: LabelBlack.size2('Harga Per Item'),
                  ),
                  LabelBlack.size2(': '),
                  LabelBlack.size2(
                      'Rp ${ConverterNumber.getCurrentcy(item.trx.product!.hargajual)}'),
                ],
              ),
              _spasi(),
              Row(
                children: [
                  SizedBox(
                    width: 110,
                    child: LabelBlack.size2('Total'),
                  ),
                  LabelBlack.size2(': '),
                  LabelBlack.size2(
                      'Rp ${ConverterNumber.getCurrentcy(item.trx.jumlah! * item.trx.product!.hargajual!)}'),
                ],
              ),
              _spasi(),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        LabelBlack.size2('Pembayaran'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _cellRadio(EnumCaraBayar.lunas, index, 'Lunas',
                            item.groupRadio),
                        _cellRadio(EnumCaraBayar.konsinyasi, index,
                            'Konsinyasi', item.groupRadio),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _contentTransaksiDs(ItemPembayaran item, int index) {
    Size size = MediaQuery.of(context).size;
    return Card(
      child: Container(
        width: size.width - 32,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  LabelBlack.size1(item.trx.product!.nama),
                  IconButton(icon: Icon(Icons.delete), onPressed: () {}),
                ],
              ),
              Divider(),
              _spasi(),
              Row(
                children: [
                  SizedBox(
                    width: 110,
                    child: LabelBlack.size2('Qty'),
                  ),
                  LabelBlack.size2(': '),
                  LabelBlack.size2('${item.trx.jumlah} pcs'),
                ],
              ),
              _spasi(),
              Row(
                children: [
                  SizedBox(
                    width: 110,
                    child: LabelBlack.size2('Harga Per Item'),
                  ),
                  LabelBlack.size2(': '),
                  LabelBlack.size2('Rp ${item.trx.product!.hargajual}'),
                ],
              ),
              _spasi(),
              Row(
                children: [
                  SizedBox(
                    width: 110,
                    child: LabelBlack.size2('Total'),
                  ),
                  LabelBlack.size2(': '),
                  LabelBlack.size2(
                      'Rp ${item.trx.jumlah! * item.trx.product!.hargajual!}'),
                ],
              ),
              _spasi(),
              Row(
                children: [
                  SizedBox(
                    width: 110,
                    child: LabelBlack.size2('Pembayaran'),
                  ),
                  LabelBlack.size2(': '),
                  LabelBlack.size2('Lunas'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _cellInfoPembeli(String text, String? value) {
    String ts = text;
    String sv = value == null ? '' : value;
    return Row(
      children: [
        SizedBox(width: 120, child: LabelBlack.size2(ts)),
        LabelBlack.size2(': '),
        LabelBlack.size2(sv),
      ],
    );
  }

  Widget _perhitungan(UIPembayaran item) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: Label2rowv1('Top Up Link Aja (L)',
                      'Sisa Limit (Rp ${ConverterNumber.getCurrentcy(item.maxlinkaja)})'),
                ),
                _cellTextfield(_controller1),
              ],
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  LabelBlack.size2('Sub Total Lunas'),
                  LabelBlack.size2(
                      'Rp ${ConverterNumber.getCurrentcy(item.getTotalLunas())}'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  LabelBlack.size2('Sub Total Konsinyasi'),
                  LabelBlack.size2(
                      'Rp ${ConverterNumber.getCurrentcy(item.getTotalKonsinyasi())}'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  LabelBlack.size2('Total'),
                  LabelBlack.size2(
                      'Rp ${ConverterNumber.getCurrentcy(item.getTotalPembayaran())}'),
                ],
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            const Divider(),
            const SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }

  Widget _cellTextfield(TextEditingController controller) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0, top: 18.0),
          child: LabelBlack.size2('Rp'),
        ),
        SizedBox(
          width: 160,
          child: TextFieldNumberOnly(
            '',
            controller,
            onChanged: (str) {
              _blocPembayaran.onChagedText(str);
            },
          ),
        )
      ],
    );
  }

  Widget _cellRadio(EnumCaraBayar enumCaraBayar, int index, String text,
      EnumCaraBayar? group) {
    return Row(
      children: [
        Radio(
          value: enumCaraBayar,
          groupValue: group,
          onChanged: (EnumCaraBayar? value) {
            _blocPembayaran.changeRadio(index, value);
          },
        ),
        LabelBlack.size2(text),
      ],
    );
  }

  _confirmDelete(int index) {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => SimpleDialog(
              title: LabelApp.size1(
                'Confirm',
                color: Colors.green,
              ),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      right: 16.0, left: 16.0, bottom: 3.0),
                  child: LabelBlack.size2(
                      'Anda yakin akan menghapus item transaksi ini?'),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      right: 16.0, left: 16.0, bottom: 3.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ButtonApp.black('Ya', () {
                        Navigator.of(context).pop();
                        _prosesHapus(index);
                      }),
                      ButtonApp.black('Tidak', () {
                        Navigator.of(context).pop();
                      }),
                    ],
                  ),
                ),
              ],
            ));
  }

  _prosesHapus(int index) {
    _blocPembayaran.deleteITem(index).then((value) {
      switch (value) {
        case EnumDelete.gagal:
          _confirmGagal();
          break;
        case EnumDelete.sukseshabis:
          _confirmSuksesHabis();
          break;
        case EnumDelete.suksessisa:
          _confirmSuksesSisa();
          break;
      }
    });
  }

  _confirmPembayaranGagal() {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => SimpleDialog(
              title: LabelApp.size1(
                'Confirm',
                color: Colors.red,
              ),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      right: 16.0, left: 16.0, bottom: 3.0),
                  child: LabelBlack.size2(
                      'Proses pembayaran mengalami gangguan. Silahkan coba lagi.'),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      right: 16.0, left: 16.0, bottom: 3.0),
                  child: ButtonApp.black('Ok', () {
                    Navigator.of(context).pop();
                  }),
                ),
              ],
            ));
  }

  _confirmSuksesSisa() {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => SimpleDialog(
              title: LabelApp.size1(
                'Confirm',
                color: Colors.green,
              ),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      right: 16.0, left: 16.0, bottom: 3.0),
                  child: LabelBlack.size2('Item Transaksi berhasil dihapus.'),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      right: 16.0, left: 16.0, bottom: 3.0),
                  child: ButtonApp.black('Ok', () {
                    Navigator.of(context).pop();
                    _blocPembayaran.refresh();
                  }),
                ),
              ],
            ));
  }

  _confirmSuksesHabis() {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => SimpleDialog(
              title: LabelApp.size1(
                'Confirm',
                color: Colors.green,
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      right: 16.0, left: 16.0, bottom: 3.0),
                  child: LabelBlack.size2(
                      'Item Transaksi berhasil dihapus. Keranjang belanja kosong.'),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      right: 16.0, left: 16.0, bottom: 3.0),
                  child: ButtonApp.black('Ok', () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  }),
                ),
              ],
            ));
  }

  _confirmGagal() {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => SimpleDialog(
              title: LabelApp.size1(
                'Confirm',
                color: Colors.red,
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      right: 16.0, left: 16.0, bottom: 3.0),
                  child:
                      LabelBlack.size2('Proses delete item transaksi gagal.'),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      right: 16.0, left: 16.0, bottom: 3.0),
                  child: ButtonApp.black('Ok', () {
                    Navigator.of(context).pop();
                  }),
                ),
              ],
            ));
  }

  _confirmNohpKosong() {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => SimpleDialog(
              title: LabelApp.size1(
                'Confirm',
                color: Colors.red,
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      right: 16.0, left: 16.0, bottom: 3.0),
                  child:
                      LabelBlack.size2('Nomor hp pembeli tidak boleh kosong.'),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      right: 16.0, left: 16.0, bottom: 3.0),
                  child: ButtonApp.black('Ok', () {
                    Navigator.of(context).pop();
                  }),
                ),
              ],
            ));
  }
}

enum EnumCaraBayar { lunas, konsinyasi }

class ItemPembayaran {
  ItemTransaksi trx;
  EnumCaraBayar? groupRadio;

  ItemPembayaran(this.trx, this.groupRadio);
}

class ParamPembayaran {
  List<ItemTransaksi>? ltrx;
  Pjp? pjp;

  ParamPembayaran(this.ltrx, this.pjp);
}
