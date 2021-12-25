import 'package:flutter/material.dart';
import 'package:hero/model/distribusi/datapembeli.dart';
import 'package:hero/model/pjp.dart';
import 'package:hero/modulapp/coverage/distribution/blocdaftarproduct.dart';
import 'package:hero/modulapp/coverage/distribution/pembayaran/pembayarandistribusi.dart';
import 'package:hero/modulapp/coverage/distribution/pembelianitem/pembelian_item.dart';
import 'package:hero/util/component/component_label.dart';
import 'package:hero/util/component/component_widget.dart';
import 'package:hero/util/uiutil.dart';

class DaftarProductDistribusi extends StatefulWidget {
  static const routeName = '/daftarproductdistribusi';
  final Pjp? pjp;
  DaftarProductDistribusi(this.pjp);

  @override
  _DaftarProductDistribusiState createState() =>
      _DaftarProductDistribusiState();
}

class _DaftarProductDistribusiState extends State<DaftarProductDistribusi> {
  late BlocDaftarProduct _blocDaftarProduct;
  int _counterBuild = 0;
  @override
  void initState() {
    _blocDaftarProduct = BlocDaftarProduct();
    super.initState();
  }

  @override
  void dispose() {
    _blocDaftarProduct.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_counterBuild == 0) {
      _blocDaftarProduct.loadData();
      _counterBuild++;
    }
    Size size = MediaQuery.of(context).size;

    return StreamBuilder<UIDaftarProduct>(
        stream: _blocDaftarProduct.uiproduct,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CustomScaffold(
              title: 'Loading...',
              body: Container(),
            );
          }

          UIDaftarProduct item = snapshot.data!;
          return CustomScaffold(
            title: 'Distibusi',
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: size.width,
                    height: size.height - 123,
                    child: SingleChildScrollView(
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: LabelBlack.size1('Daftar Product'),
                            ),
                            _content(item.litemtrx!),
                            SizedBox(
                              height: 150,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width - 2,
                    child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            backgroundColor: Color(
                          0xFFFF7F50,
                        )),
                        // color: Color(0xFFFF7F50),
                        child: Text(
                          'KERANJANG BELANJA (${item.jmlkeranjang})',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: item.jmlkeranjang == 0
                            ? null
                            : () {
                                ParamPembayaran params =
                                    ParamPembayaran(item.litemtrx, widget.pjp);

                                Navigator.pushNamed(
                                        context, PembayaranDistribusi.routeName,
                                        arguments: params)
                                    .then((value) {
                                  _blocDaftarProduct.reloadDaftarProduct();
                                });
                              }),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget _content(List<ItemTransaksi> ltrx) {
    List<Widget> lw = [];
    lw.add(SizedBox(
      height: 4,
    ));
    ltrx.forEach((element) {
      lw.add(_cell(element));
    });
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Column(
          children: lw,
        ),
      ),
    );
  }

  Widget _cell(ItemTransaksi trx) {
    return TextButton(
      onPressed: () async {
        var result = await CommonUi.openPage(context, PembelianItem(trx));
        if (result == null) {
          _blocDaftarProduct.reloadDaftarProduct();
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 4,
          ),
          LabelBlack.size2(trx.product!.nama),
          SizedBox(
            height: 4,
          ),
          LabelBlack.size3('Stock : ${trx.product!.stock} pcs'),
          SizedBox(
            height: 4,
          ),
          LabelBlack.size3('Keranjang : ${trx.jumlah} pcs'),
          Divider(
            thickness: 2,
          ),
        ],
      ),
    );
  }

  // Widget _cellRekomendasi(String text, int pcs) {
  //   return Row(
  //     children: [
  //       SizedBox(width: 70, child: LabelBlack.size2(text)),
  //       LabelBlack.size2(': '),
  //       LabelBlack.size2('$pcs pcs'),
  //     ],
  //   );
  // }
}
