import 'package:flutter/material.dart';
import 'package:hero/model/enumapp.dart';
import 'package:hero/model/sf/itemsearchoutlet.dart';
import 'package:hero/modulapp/blocpagetabsf.dart';
import 'package:hero/modulapp/coverage/faktur/fakturbelanja.dart';
import 'package:hero/modulapp/marketaudit/sf/hphistorysurvey.dart';
import 'package:hero/modulapp/merchandising/homeviewmerchandising.dart';
import 'package:hero/modulapp/promotion/hpviewpromotion.dart';
import 'package:hero/util/component/button/component_button.dart';
import 'package:hero/util/component/label/component_label.dart';
import 'package:hero/util/component/widget/horeboxdecoration.dart';
import 'package:hero/util/component/widget/widgetpencariankosong.dart';
import 'package:hero/util/constapp/consstring.dart';

class PageDistribusi extends StatelessWidget {
  const PageDistribusi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const PageTab(EnumTab.distribution);
  }
}

class PageMerchandising extends StatelessWidget {
  const PageMerchandising({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const PageTab(EnumTab.merchandising);
  }
}

class PagePromotion extends StatelessWidget {
  const PagePromotion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const PageTab(EnumTab.promotion);
  }
}

class PageSurvey extends StatelessWidget {
  const PageSurvey({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const PageTab(EnumTab.marketaudit);
  }
}

class PageTab extends StatefulWidget {
  final EnumTab enumTab;
  const PageTab(this.enumTab, {Key? key}) : super(key: key);
  @override
  _PageTabState createState() => _PageTabState();
}

class _PageTabState extends State<PageTab> {
  final TextEditingController _controller = TextEditingController();

  late BlocPageTabSf _blocPageTabSf;
  int _counterBuild = 0;
  final HoreBoxDecoration _boxDecoration = HoreBoxDecoration();

  @override
  void initState() {
    _blocPageTabSf = BlocPageTabSf();
    super.initState();
  }

  @override
  void dispose() {
    _blocPageTabSf.dispose();
    _controller.dispose();
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
      _blocPageTabSf.firstTime();
      _counterBuild++;
    }

    Size s = MediaQuery.of(context).size;

    return StreamBuilder<UIPageTabSf?>(
        stream: _blocPageTabSf.uihpretur,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }
          UIPageTabSf item = snapshot.data!;
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
                        SizedBox(
                          //untuk jarak atas ke tulisan judul
                          width: s.width,
                          height: 40,
                        ),
                        LabelBlack.size1(title, bold: true),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20.0, top: 0.0, bottom: 0.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
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
                                    _blocPageTabSf
                                        .searchRangeTanggal(widget.enumTab);
                                  }),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 20.0, right: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: 40,
                                  child: TextField(
                                    keyboardType: TextInputType.text,
                                    controller: _controller,
                                    style: const TextStyle(
                                      color: Colors.black45,
                                      fontSize: 12,
                                    ),
                                    decoration: InputDecoration(
                                        border: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                        ),
                                        hintText: ConstString.hintSearch,
                                        hintStyle: const TextStyle(
                                            color: Colors.black45)),
                                    onChanged: (v) {},
                                  ),
                                ),
                              ),
                              IconButton(
                                  icon: const Icon(Icons.search, size: 30),
                                  onPressed: () {
                                    FocusScope.of(context).unfocus();
                                    _blocPageTabSf.searchByQuery(
                                        widget.enumTab, _controller.text);
                                  })
                            ],
                          ),
                        ),
                        Expanded(
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    gradient:
                                        _boxDecoration.gradientBackgroundApp()),
                                margin: const EdgeInsets.only(
                                    top: 10.0, left: 0, right: 0),
                                padding: const EdgeInsets.all(5.0),
                                child: Card(
                                  elevation: 0,
                                  color: Colors.transparent,
                                  child: Column(
                                    children: [
                                      _headerPencarian(),
                                      _controllContentPencarian(item),
                                      // _content(item),
                                    ],
                                  ),
                                ))),
                        const SizedBox(
                          height: 70,
                        )
                      ],
                    ),
                  )
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
        children: const [
          LabelWhite.size1("Berikut Daftar Pencarian : "),
          Divider(
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget _controllContentPencarian(UIPageTabSf item) {
    Size s = MediaQuery.of(context).size;
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
      return SizedBox(height: s.height - 365, child: _content(item));
    }
  }

  Widget _content(UIPageTabSf item) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 20),
      shrinkWrap: true,
      //physics: NeverScrollableScrollPhysics(),
      itemCount: item.getCountList(),
      itemBuilder: (context, index) {
        return ListTile(
          title: _cellController(item, index),
        );
      },
    );
  }

  Widget _btnShowMore() {
    return RaisedButton(
        child: const Text('show more'),
        color: Colors.green,
        onPressed: () {
          _blocPageTabSf.showmore(widget.enumTab);
        });
  }

  Widget _spasi() {
    return const SizedBox(
      height: 4,
    );
  }

  Widget _cellController(UIPageTabSf uiPageTabSf, int index) {
    int tmp = uiPageTabSf.getCountList() - 1;
    if (tmp == index) {
      if (uiPageTabSf.isShowmoreVisible()) {
        return _btnShowMore();
      }
    }
    LokasiSearch item = uiPageTabSf.loutlet![index];
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
                          LabelWhite.size3(item.namapembeli),
                          _spasi(),
                          LabelWhite.size3('tgl: ${item.getStrTgl()}'),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                      child: ButtonApp.black(
                        'View Detail',
                        () {
                          _controllerTap(item);
                        },
                        bgColor: Colors.white,
                      ),
                    ),
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
                        LabelWhite.size3(nama),
                        _spasi(),
                        LabelWhite.size3('tgl: ${item.getStrTgl()}'),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                    child: ButtonApp.black(
                      item.nonota,
                      () {
                        _tapNota(item.nonota);
                      },
                      bgColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }

  void _tapNota(String? nota) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => FakturPembayaran(nota, true)));
    // CommonUi.openPage(context,   FakturPembayaran(nota, true));
  }

  void _controllerTap(LokasiSearch item) {
    switch (widget.enumTab) {
      case EnumTab.distribution:
        break;
      case EnumTab.merchandising:
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomeViewMerchandising(item)));
        // CommonUi.openPage(context,   HomeViewMerchandising(item));

        break;
      case EnumTab.promotion:
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomePageViewPromotion(item)));
        // CommonUi.openPage(context,   HomePageViewPromotion(item));
        break;
      case EnumTab.marketaudit:
        {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => HomeHistorySurvey(item)));
          // CommonUi.openPage(context, HomeHistorySurvey(item));
        }
        break;
      case EnumTab.mt:
        // TODO: Handle this case.
        break;
    }
  }

  void _datePicker(bool isawal, UIPageTabSf item) async {
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
        _blocPageTabSf.pickComboAwal(picked);
      } else {
        _blocPageTabSf.pickComboAkhir(picked);
      }
    }
  }
}
