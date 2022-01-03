import 'package:flutter/material.dart';
import 'package:hero/model/distribusi/datapembeli.dart';
import 'package:hero/model/serialnumber.dart';
import 'package:hero/util/component/component_button.dart';
import 'package:hero/util/component/component_label.dart';
import 'package:hero/util/component/component_textfield.dart';
import 'package:hero/util/component/component_widget.dart';

import 'blocpembelian.dart';

class PembelianItem extends StatefulWidget {
  static const routeName = '/pembelianitem';
  final ItemTransaksi? trx;

  PembelianItem(this.trx);

  @override
  _PembelianItemState createState() => _PembelianItemState();
}

class _PembelianItemState extends State<PembelianItem> {
  TextEditingController _textController1 = new TextEditingController();
  TextEditingController _textController2 = new TextEditingController();
  late BlocPembelian _blocPembelian;
  int _counterBuild = 0;
  late bool _isRange;

  @override
  void initState() {
    _blocPembelian = BlocPembelian();
    _isRange = false;

    // // dev only
    // _isRange = true;
    // _textController1.text = '9000000000000003';
    // _textController2.text = '9000000000000100';
    print("id produk: ${widget.trx}");
    super.initState();
  }

  @override
  void dispose() {
    _blocPembelian.dispose();
    _textController1.dispose();
    _textController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (_counterBuild == 0) {
      _blocPembelian.firstTime(widget.trx);
      _blocPembelian.semuaSerial();
      _counterBuild++;
    }

    return StreamBuilder<UIPembelian>(
        stream: _blocPembelian.uiPembelian,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CustomScaffold(
              title: 'Loading...',
              body: Container(),
            );
          }

          UIPembelian item = snapshot.data!;
          return CustomScaffold(
            title: 'Pembelian',
            body: Stack(
              children: [
                SizedBox(
                  width: size.width,
                  height: size.height,
                  child: SingleChildScrollView(
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 12,
                          ),
                          _contentTransaksi(item.trx!),
                          SizedBox(
                            height: 12,
                          ),
                          _contentSeri(item),
                          SizedBox(
                            height: 50,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: SizedBox(
                    width: size.width - 2,
                    child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              item.isSafetosubmit()
                                  ? Colors.green
                                  : Colors.grey),
                        ),
                        child: Text(
                          'BELI',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: item.isSafetosubmit()
                            ? () {
                                _blocPembelian.beli().then((value) {
                                  if (value) {
                                    _confirmSuccessSimpan();
                                  } else {
                                    _confirmGagalMenyimpan();
                                  }
                                });
                              }
                            : null),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Widget _contentTransaksi(ItemTransaksi trx) {
    String txtbtn = _isRange ? 'Hide' : 'Range';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 12,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: LabelBlack.size1(trx.product!.nama),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            color: Colors.red[600],
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                          width: 200, child: _inputNoSeri(_textController1)),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: ButtonApp.white(txtbtn, () {
                          setState(() {
                            print('click');
                            _isRange = !_isRange;
                          });
                        }),
                      ),
                    ],
                  ),
                ),
                _isRange
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                                width: 200,
                                child: _inputNoSeri(_textController2)),
                            Container(),
                          ],
                        ),
                      )
                    : Container(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ButtonApp.white('SEARCH', () {
                        FocusScope.of(context).unfocus();
                        String snawal = _textController1.text;
                        String snakhir = _textController2.text;
                        if (snawal == "" && snakhir == "") {
                          _blocPembelian.semuaSerial();
                        } else {
                          setState(() {
                          _blocPembelian.cariSerial(snawal, snakhir);
                          });
                        }
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _inputNoSeri(TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 4.0),
          child: Text(
            "Nomor Seri",
            style: TextStyle(color: Colors.white),
          ),
        ),
        TextFormField(
          controller: controller,
          cursorColor: Colors.white,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            fillColor: Colors.white,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                color: Colors.yellow,
                width: 2.0,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                color: Colors.white,
              ),
            ),
            isDense: true,
          ),
        ),
      ],
    );
  }

  Widget _contentSeri(UIPembelian item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 12,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              LabelBlack.size1('Serial Number'),
              LabelBlack.size1('Jumlah:${item.getTotal()}'),
            ],
          ),
        ),
        _contentListSeri(item.lserial),
      ],
    );
  }

  Widget _contentListSeri(List<SerialNumber> lseri) {
    List<Widget> lw = [];
    lw.add(SizedBox(
      height: 4,
    ));
    for (int i = 0; i < lseri.length; i++) {
      SerialNumber item = lseri[i];
      lw.add(_cell(item, i));
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Column(
          children: lw,
        ),
      ),
    );
  }

  Widget _cell(SerialNumber seri, int index) {
    print("check: $seri.ischecked");
    return ListTile(
      leading: Checkbox(
        onChanged: (bool? value) {
          _blocPembelian.changeRadio(index, value!);
        },
        value: seri.ischecked,
      ),
      title: Text(seri.serial!),
    );
  }

  _confirmSuccessSimpan() {
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
                      'Transaksi berhasil di tambahkan ke keranjang belanja.'),
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

  _confirmGagalMenyimpan() {
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
                  child: LabelBlack.size2(
                      'Transaksi gagal di tambahkan ke keranjang belanja.'),
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

// class ItemSeri {
//   bool value;
//   String seri;
//
//   ItemSeri(this.value, this.seri);
// }
