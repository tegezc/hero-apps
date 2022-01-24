import 'package:flutter/material.dart';
import 'package:hero/model/enumapp.dart';
import 'package:hero/model/sf/itemsearchoutlet.dart';
import 'package:hero/modulapp/blocpagetabds.dart';
import 'package:hero/modulapp/coverage/faktur/fakturbelanjads.dart';
//import 'package:hero/modulapp/marketaudit/sf/hphistorysurvey.dart';
import 'package:hero/modulapp/promotion/hpviewpromotion.dart';
import 'package:hero/util/component/button/component_button.dart';
import 'package:hero/util/component/label/component_label.dart';
import 'package:hero/util/component/widget/horeboxdecoration.dart';
import 'package:hero/util/component/widget/widgetpencariankosong.dart';
import 'package:hero/util/constapp/consstring.dart';
import 'package:hero/util/uiutil.dart';

import 'marketaudit/ds/marketauditdsview.dart';
import 'merchandising/homeviewmerchandising.dart';

class PageDistribusiDs extends StatelessWidget {
  const PageDistribusiDs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const PageTabDs(EnumTab.distribution);
  }
}

class PageMerchandisingDs extends StatelessWidget {
  const PageMerchandisingDs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const PageTabDs(EnumTab.merchandising);
  }
}

class PagePromotionDs extends StatelessWidget {
  const PagePromotionDs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const PageTabDs(EnumTab.promotion);
  }
}

class PageMarketAudit extends StatelessWidget {
  const PageMarketAudit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const PageTabDs(EnumTab.marketaudit);
  }
}

class PageTabDs extends StatefulWidget {
  final EnumTab enumTab;
  const PageTabDs(this.enumTab, {Key? key}) : super(key: key);
  @override
  _PageTabDsState createState() => _PageTabDsState();
}

class _PageTabDsState extends State<PageTabDs> {
  final TextEditingController _controller = TextEditingController();

  late BlocPageTabDs _blocPageTabDs;
  late bool _isbtnfiltershow;
  int _counterBuild = 0;
  final HoreBoxDecoration _horeBoxDecoration = HoreBoxDecoration();
  @override
  void initState() {
    _isbtnfiltershow = false;
    _blocPageTabDs = BlocPageTabDs();

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _blocPageTabDs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String? title;
    switch (widget.enumTab) {
      case EnumTab.distribution:
        title = 'Distribusi';
        break;
      case EnumTab.merchandising:
        title = 'Merchandising';
        break;
      case EnumTab.promotion:
        title = 'Promotion';
        break;
      case EnumTab.marketaudit:
        title = 'Market Audit';
        break;
      case EnumTab.mt:
        // TODO: Handle this case.
        break;
    }

    if (_counterBuild == 0) {
      _blocPageTabDs.firstTime();
      _counterBuild++;
    }

    Size s = MediaQuery.of(context).size;
    return StreamBuilder<UIPageTabDs?>(
        stream: _blocPageTabDs.uihpretur,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }
          UIPageTabDs item = snapshot.data!;

          return SingleChildScrollView(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  //image: AssetImage('assets/image/coverage/BG.png'),
                  image: AssetImage('assets/image/new/BG.png'),
                  fit: BoxFit.cover,
                ),
              ),
              height: s.height,
              width: s.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 8, right: 8, top: 50),
                    height: s.height,
                    width: s.width,
                    child: Column(
                      children: [
                        const SizedBox(
                          //untuk jarak atas ke tulisan judul
                          height: 30,
                        ),
                        LabelBlack.size1(title, bold: true),
                        const SizedBox(
                          height: 12,
                        ),
                        _isbtnfiltershow
                            ? SizedBox(
                                width: s.width - 12,
                                child: ButtonAppSolid('Edit Filter', onTap: () {
                                  setState(() {
                                    _isbtnfiltershow = false;
                                  });
                                }),
                              )
                            : _serchFilter(item),
                        Expanded(
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    gradient: _horeBoxDecoration
                                        .gradientBackgroundApp()),
                                margin: const EdgeInsets.only(
                                    top: 10.0, left: 0, right: 0),
                                padding: const EdgeInsets.all(5.0),
                                child: Card(
                                  elevation: 0,
                                  color: Colors.transparent,
                                  child: Column(
                                    children: [
                                      _headerPencarian(),
                                      SizedBox(
                                          height: s.height - 400,
                                          child:
                                              _controllContentPencarian(item)),
                                      // _content(item),
                                    ],
                                  ),
                                ))),
                        const SizedBox(
                          height: 70,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget _headerPencarian() {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LabelWhite.size1("Berikut Daftar Pencarian : "),
          const Divider(
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget _controllContentPencarian(UIPageTabDs item) {
    if (item.getCountList() == 0) {
      if (_controller.text.isNotEmpty) {
        return const WidgetPencarianKosong(
            text: 'Pencarian dengan kriteria tersebut \nTIDAK DITEMUKAN.');
      } else {
        return const WidgetPencarianKosong(
            text:
                'Silahkan masukkan kata kunci \nuntuk mendapatkan hasil pencarian');
      }
    } else {
      return _content(item);
    }
  }

  Widget _content(UIPageTabDs uiPageTabDs) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 20),
      shrinkWrap: true,
      itemCount: uiPageTabDs.getCountList(),
      itemBuilder: (context, index) {
        return ListTile(
          title: _cellController(uiPageTabDs, index),
        );
      },
    );
  }

  Widget _btnShowMore() {
    return RaisedButton(
        child: const Text('show more'),
        color: Colors.green,
        onPressed: () {
          _blocPageTabDs.showmore(widget.enumTab);
        });
  }

  Widget _spasi() {
    return const SizedBox(
      height: 4,
    );
  }

  Widget _cellController(UIPageTabDs uiPageTabDs, int index) {
    int tmp = uiPageTabDs.getCountList() - 1;
    if (tmp == index) {
      if (uiPageTabDs.isShowmoreVisible()) {
        return _btnShowMore();
      }
    }
    LokasiSearch item = uiPageTabDs.lLokasi![index];
    return widget.enumTab != EnumTab.distribution
        ? _cellOutlet(item)
        : _cellOutletDistibusi(item);
  }

  Widget _cellOutlet(LokasiSearch item) {
    return GestureDetector(
      onTap: () {
        //_controllerTap(item);
      },
      child: Column(
        children: [
          const Divider(),
          Padding(
            padding: const EdgeInsets.only(
                left: 8.0, right: 8.0, top: 1.0, bottom: 1.0),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.playlist_add_check,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // LabelBlack.size2(item.iddigipos),
                          // _spasi(),
                          LabelBlack.size3(item.namapembeli),
                          _spasi(),
                          LabelBlack.size3('tgl: ${item.getStrTgl()}'),
                        ],
                      ),
                    ),
                    ButtonApp.blue('View Detail', () {
                      _controllerTap(item);
                    }),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _cellOutletDistibusi(LokasiSearch item) {
    String? nama = item.namapembeli;
    if (item.namapembeli!.length > 17) {
      nama = item.namapembeli!.substring(0, 17);
    }
    return Column(
      children: [
        const Divider(),
        Padding(
          padding: const EdgeInsets.only(
              left: 8.0, right: 8.0, top: 1.0, bottom: 1.0),
          child: Column(
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.playlist_add_check,
                    color: Colors.green,
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // LabelBlack.size2(item.iddigipos),
                        // _spasi(),
                        LabelBlack.size3(nama),
                        _spasi(),
                        LabelBlack.size3('tgl: ${item.getStrTgl()}'),
                      ],
                    ),
                  ),
                  ButtonApp.blue(item.nonota, () {
                    _tapNota(item.nonota);
                  }),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _tapNota(String? nota) {
    CommonUi.openPage(context, FakturPembayaranDs(nota, true));
  }

  void _controllerTap(LokasiSearch item) {
    switch (widget.enumTab) {
      case EnumTab.distribution:
        break;
      case EnumTab.merchandising:
        CommonUi.openPage(context, HomeViewMerchandising(item));

        break;
      case EnumTab.promotion:
        CommonUi.openPage(context, HomePageViewPromotion(item));
        break;
      case EnumTab.marketaudit:
        {
          CommonUi.openPage(context, MarketAuditDsView(lokasiSearch: item));
        }
        break;
      case EnumTab.mt:
        // TODO: Handle this case.
        break;
    }
  }

  void _datePicker(bool isawal, UIPageTabDs item) async {
    DateTime? dtawal = DateTime(DateTime.now().year - 5);
    DateTime dtakhir = DateTime(DateTime.now().year + 5);
    DateTime initialDt = DateTime.now();
    if (!isawal) {
      if (item.tglAwal != null) {
        dtawal = item.tglAwal;
        initialDt = dtawal!.add(const Duration(days: 1));
      }
    }
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDt,
      firstDate: dtawal,
      lastDate: dtakhir,
    );

    if (picked != null) {
      if (isawal) {
        _blocPageTabDs.pickComboAwal(picked);
      } else {
        _blocPageTabDs.pickComboAkhir(picked);
      }
    }
  }

  Widget _serchFilter(UIPageTabDs item) {
    double w = MediaQuery.of(context).size.width;
    return Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ButtonApp.blue(item.getStrAwal(), () {
                    _datePicker(true, item);
                  }),
                ),
                ButtonApp.blue(item.getStrAkhir(), () {
                  _datePicker(false, item);
                }),
                IconButton(
                    icon: const Icon(
                      Icons.play_arrow_outlined,
                      size: 40,
                    ),
                    onPressed: () {
                      FocusScope.of(context).unfocus();

                      _controller.text = '';
                      _blocPageTabDs.searchRangeTanggal(widget.enumTab);
                    }),
              ],
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 4.0, bottom: 8, right: 4, top: 8),
              child: Row(
                children: [
                  SizedBox(
                    width: w - 80,
                    child: TextField(
                      keyboardType: TextInputType.text,
                      controller: _controller,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                          ),
                          // suffixIcon:
                          //     new Icon(Icons.search, color: Colors.black),
                          hintText: ConstString.hintSearchDs,
                          hintStyle: const TextStyle(color: Colors.black)),
                      onChanged: (v) {},
                    ),
                  ),
                  IconButton(
                      icon: const Icon(Icons.search, size: 30),
                      onPressed: () {
                        FocusScope.of(context).unfocus();

                        _blocPageTabDs.searchByQuery(
                            widget.enumTab, _controller.text);
                      })
                ],
              ),
            ),
          ],
        ));
  }
}
