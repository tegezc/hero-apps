import 'package:flutter/material.dart';
import 'package:hero/model/distribusi/datapembeli.dart';
import 'package:hero/model/pjp.dart';
import 'package:hero/modulapp/coverage/distribution/blocdaftarproduct.dart';
import 'package:hero/modulapp/coverage/distribution/pembayaran/pembayarandistribusi.dart';
import 'package:hero/modulapp/coverage/distribution/pembelianitem/pembelian_item.dart';
import 'package:hero/util/component/button/component_button.dart';
import 'package:hero/util/component/label/component_label.dart';
import 'package:hero/util/component/widget/component_widget.dart';

class DaftarProductDistribusi extends StatefulWidget {
  static const routeName = '/daftarproductdistribusi';
  final Pjp? pjp;
  DaftarProductDistribusi(this.pjp, {Key? key}) : super(key: key);

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
            title: 'Distribusi',
            body: Stack(
              children: [
                SizedBox(
                  height: size.height,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: LabelBlack.size1('Daftar Product'),
                        ),
                        _content(item.litemtrx!),
                        // SizedBox(
                        //   height: 150,
                        // ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: SizedBox(
                    width: size.width - 2,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: ButtonStrectWidth(
                        text: 'KERANJANG BELANJA (${item.jmlkeranjang})',
                        buttonColor: Colors.red,
                        isenable: item.jmlkeranjang != 0,
                        onTap: () {
                          ParamPembayaran params =
                              ParamPembayaran(item.litemtrx, widget.pjp);

                          Navigator.pushNamed(
                                  context, PembayaranDistribusi.routeName,
                                  arguments: params)
                              .then((value) {
                            _blocDaftarProduct.reloadDaftarProduct();
                          });
                        },
                      ),
                    ),
                    // OutlinedButton(
                    //     style: OutlinedButton.styleFrom(
                    //         backgroundColor: Colors.red[600]),
                    //     // color: Color(0xFFFF7F50),
                    //     child: Padding(
                    //       padding:
                    //           const EdgeInsets.only(top: 15.0, bottom: 15.0),
                    //       child: Text(
                    //         'KERANJANG BELANJA (${item.jmlkeranjang})',
                    //         style: const TextStyle(color: Colors.white),
                    //       ),
                    //     ),
                    //     onPressed: item.jmlkeranjang == 0
                    //         ? null
                    //         : () {
                    //             ParamPembayaran params =
                    //                 ParamPembayaran(item.litemtrx, widget.pjp);
                    //
                    //             Navigator.pushNamed(
                    //                     context, PembayaranDistribusi.routeName,
                    //                     arguments: params)
                    //                 .then((value) {
                    //               _blocDaftarProduct.reloadDaftarProduct();
                    //             });
                    //           }),
                  ),
                ),
              ],
            ),
          );
        });
  }

  // Widget _content(List<ItemTransaksi> ltrx) {
  //   List<Widget> lw = [];
  //   lw.add(SizedBox(
  //     height: 4,
  //   ));
  //   ltrx.forEach((element) {
  //     lw.add(_cell(element));
  //   });
  //   return Padding(
  //     padding: const EdgeInsets.all(8.0),
  //     child: Card(
  //       child: Column(
  //         children: lw,
  //       ),
  //     ),
  //   );
  // }

  Widget _content(List<ItemTransaksi> ltrx) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Colors.white, //Colors.red[600],
        child: ListView.separated(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: ltrx.length,
          itemBuilder: (ctx, index) {
            return Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: TextButton(
                style: const ButtonStyle(alignment: Alignment.centerLeft),
                onPressed: () async {
                  // var result = await CommonUi.openPage(context, PembelianItem(trx));
                  var result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PembelianItem(ltrx[index])));
                  if (result == null) {
                    _blocDaftarProduct.reloadDaftarProduct();
                  }
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LabelBlack.size2(ltrx[index].product!.nama),
                    const SizedBox(
                      height: 4,
                    ),
                    LabelBlack.size3(
                        'Stock : ${ltrx[index].product!.stock} pcs'),
                    const SizedBox(
                      height: 4,
                    ),
                    LabelBlack.size3('Keranjang : ${ltrx[index].jumlah} pcs'),
                    const Divider(
                      thickness: 2,
                    ),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (ctx, index) => const Padding(
            padding: EdgeInsets.only(left: 8.0, right: 8.0),
            child: Divider(
              thickness: 2,
              color: Colors.white60,
            ),
          ),
        ),
      ),
    );
  }

  // Widget _cell(ItemTransaksi trx) {
  //   return TextButton(
  //     onPressed: () async {
  //       // var result = await CommonUi.openPage(context, PembelianItem(trx));
  //       var result = await Navigator.push(context,
  //           MaterialPageRoute(builder: (context) => PembelianItem(trx)));
  //       if (result == null) {
  //         _blocDaftarProduct.reloadDaftarProduct();
  //       }
  //     },
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         SizedBox(
  //           height: 4,
  //         ),
  //         LabelBlack.size2(trx.product!.nama),
  //         SizedBox(
  //           height: 4,
  //         ),
  //         LabelBlack.size3('Stock : ${trx.product!.stock} pcs'),
  //         SizedBox(
  //           height: 4,
  //         ),
  //         LabelBlack.size3('Keranjang : ${trx.jumlah} pcs'),
  //         Divider(
  //           thickness: 2,
  //         ),
  //       ],
  //     ),
  //   );
  // }

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
